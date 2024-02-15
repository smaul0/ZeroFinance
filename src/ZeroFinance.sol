// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Interface/IZeroFinance.sol";
import "./Interface/IBlast.sol";
import "./Interface/IERC20Rebasing.sol";
import "./RewardDistributor.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title ZeroFinance: A zero interest lending pool
/// @author Soumen Jana(soumenjana029@gmail.com)
/// @notice borrow USDB without worrying about paying interest.
contract ZeroFinance is Ownable, IZeroFinance {
    IBlast public constant BLAST = IBlast(0x4300000000000000000000000000000000000002); 
    RewardDistributor public REWARD;
    IERC20Rebasing public immutable USDB;
    uint256 public constant EARLY_WITHDRAWAL_FEE = 10;
    uint256 public minimumCollateralRatio = 115 * 1e18; // 115% minimum Collateral Ratio need to maintain
    uint256 public borrowFee = 5; // 0.5% fee for borrowing
    uint256 public totalDepositedUSDB;
    uint256 public poolUSDB;

    address[] public LP;
    mapping (address lp => uint256 index ) lpIndex;

    struct Liquidity {
        uint256 lpAmount;
        uint256 depositTimestamp;
    }
    /// @notice Keep track of the user deposited liquidity
    mapping (address lp => Liquidity user) depositedLiquidity;

    mapping (address borrower => uint256 collateralAmount) userCollateral;
    mapping (address borrower => uint256 borrowAmount) borrowedCollateral;

    constructor() Ownable(msg.sender) {
        USDB = IERC20Rebasing(0x4200000000000000000000000000000000000022);
        USDB.configure(IERC20Rebasing.YieldMode.CLAIMABLE);
        BLAST.configureClaimableGas();
        BLAST.configureGovernor(msg.sender);
        REWARD = new RewardDistributor(address(this)); 
    }

    /// @notice Allow liquidity provider (LP) to provide USDB as liquidity and earn reward
    /// @param amount Amount of USDB a user wants to deposit as liquidity. Minimum 100 USDB
    function provideLiquidityUSDB(uint256 amount) external {
        require(amount >= 100e18, "Minimum deposit 100 USDB");
        USDB.transferFrom(msg.sender, address(this), amount);

        depositedLiquidity[msg.sender] = Liquidity({
            lpAmount: amount,
            depositTimestamp: block.timestamp
        });

        totalDepositedUSDB += amount;
        poolUSDB += amount;

        if (!_findAddressInLP(msg.sender)) {
            LP.push(msg.sender);
            lpIndex[msg.sender] = LP.length - 1;
        }
    }

    /// @notice Allow LP's to withdraw their USDB and earned reward will also going to be transfered
    /// @notice if the withdrawal is made within a week, a fee of 10% will be levied and no reward will be distributed (if generated any)
    function withdrawLiquidityUSDB() external returns(uint256 transferedUSDB) {
        require(depositedLiquidity[msg.sender].lpAmount >= 0, "Caller is not a LP");

        Liquidity memory _liquidity = depositedLiquidity[msg.sender];
        delete depositedLiquidity[msg.sender];
        
        LP[lpIndex[msg.sender]] = LP[LP.length - 1];
        LP.pop();

        if (block.timestamp - _liquidity.depositTimestamp >= 7 days) {
            /// @notice @TO-DO need to implement reward distribution and interest distribution for providing liquidity
            poolUSDB -= _liquidity.lpAmount;
            USDB.transfer(msg.sender, _liquidity.lpAmount);
            
            REWARD.distributeReward();
            REWARD.claimReward(msg.sender);
            
            return _liquidity.lpAmount;
        } else {
            uint256 amountToTransferAfterFee = _liquidity.lpAmount - ((_liquidity.lpAmount * EARLY_WITHDRAWAL_FEE) / 100);
            USDB.transfer(msg.sender, amountToTransferAfterFee);
            poolUSDB -= amountToTransferAfterFee;
            return amountToTransferAfterFee;
        }
    }

    function depositCollateral(uint256 borrowAmount) payable external {
        require(msg.value >= 1 ether, "Minimum deposit is 1 ETH");
        userCollateral[msg.sender] = userCollateral[msg.sender] + msg.value;

        if (borrowAmount > 0) {
            borrow(borrowAmount);
        }
    }

    function withdrawCollateral(uint256 withdrawAmount) external {
        uint _userCollateral = userCollateral[msg.sender];
        require(_userCollateral >= 0, "No Collateral Deposited");
        require(withdrawAmount <= _userCollateral, "Over Withdrawal");
        uint borrowAmount = borrowedCollateral[msg.sender];

        userCollateral[msg.sender] = userCollateral[msg.sender] - withdrawAmount;

        if (borrowAmount > 0) {
            uint256 _ETHPriceInUSD = _ethPrice(); /// @notice @TO-DO Hardcoded asset Price, Will change after getting some reliable Oracle on Blast
            _checkCollateralRatio(msg.sender, _ETHPriceInUSD, borrowAmount);

            payable(msg.sender).transfer(withdrawAmount);
        } else {
            payable(msg.sender).transfer(withdrawAmount);
        }
        
    }

    /// @notice Allow borrower to take loan against their collateral, Minimum collateral ratio 115% 
    /// @param borrowAmount Amount of USDB a user wants to borrow, borrow amount should not decrease the collateral ratio to 115% 
    function borrow(uint256 borrowAmount) public {
        require(borrowAmount > 0);
        require(userCollateral[msg.sender] >= 0, "No Collateral Deposited");
        require(poolUSDB >= borrowAmount);

        uint fee = (borrowAmount * 5)/ 1000;
        require(fee > 0, "Fee can't be 0");

        uint256 _ETHPriceInUSD = _ethPrice();
        uint256 feeInETH = fee / _ETHPriceInUSD;
        userCollateral[msg.sender] -= feeInETH;

        _checkCollateralRatio(msg.sender, _ETHPriceInUSD, borrowAmount);
        poolUSDB -= borrowAmount;

        borrowedCollateral[msg.sender] += borrowAmount;
        payable(REWARD).transfer(feeInETH);
        USDB.transfer(msg.sender, borrowAmount);
    }

    function repayBorrowedUSDB(uint amount) external {
        uint256 borrowed = borrowedCollateral[msg.sender];
        require(borrowed > 0, "Not a borrower");
        require(amount <= borrowed, "Repaying More Than Owed");

        USDB.transferFrom(msg.sender, address(this), amount);
        borrowedCollateral[msg.sender] -= amount;
    }

    /// @notice Allow liquidator to liquidate any borrower position once borrower collaterl ratio decrease more than 115%
    /// TO-DO Will modify this later to only allow to liquidate 50% collateral if collateral ratio is between 105%-115%. 
    /// Fully liquidable if collateral ratio is below 105%%
    function liquidation(address borrower) external returns(uint) {
        uint256 borrowed = borrowedCollateral[borrower];
        require(borrowed > 0, "Not a borrower");

        
        uint256 _ETHPriceInUSD = _ethPrice();
        uint256 collateralRatio = (userCollateral[borrower] * _ETHPriceInUSD * 100) / borrowed;

        if (collateralRatio < minimumCollateralRatio ) {
            USDB.transferFrom(msg.sender, address(this), borrowed);
            borrowedCollateral[borrower] = 0;

            poolUSDB += borrowed;
            uint256 collateral = userCollateral[borrower];
            userCollateral[borrower] = 0;

            payable(msg.sender).transfer(collateral);
        }
    }

    /// @notice Probably gonna use this as Insurance and create a Insurance contract
    function claimContractsGas() public onlyOwner() {
        BLAST.claimAllGas(address(this), address(REWARD));
    }

    function claimAllYield() public onlyOwner() {
	  //This function is public meaning anyone can claim the yield
		BLAST.claimAllYield(address(this), address(REWARD));
    }

    function getLPLength() public view returns (uint) {
        return LP.length;
    }

    function _checkCollateralRatio(address _user, uint256 _assetPrice, uint256 borrowed) internal view {
        
        if (((userCollateral[_user] * _assetPrice * 100) / borrowed) < minimumCollateralRatio ) revert("collateralRatio is Below minimumCollateralRatio");
    }

    
    function _findAddressInLP(address _lp) internal view returns(bool) {
        for (uint i = 0; i < LP.length - 1; i++) {
            if (LP[i] == _lp) {
                return true;
            }
        }

        return false;
    }

     /// @notice @TO-DO Hardcoded asset Price, Will change after getting some reliable Oracle on Blast
    function _ethPrice() internal returns(uint256) {
        return 2000e18; 
    }
}