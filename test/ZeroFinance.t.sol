pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/ZeroFinance.sol";
import "../src/Interface/IERC20Rebasing.sol";

contract ContractBTest is Test {
    IERC20Rebasing USDB = IERC20Rebasing(0x4200000000000000000000000000000000000022);
    uint256 blastFork;
    ZeroFinance zeroFinance;
    address usdbH = 0xF9950E55323aC6Af7a4b2DCEe5e42d5168CdA253;

    function setUp() public {
        blastFork = vm.createFork('https://rpc.ankr.com/blast_testnet_sepolia/8a1be3671e2d45d2ca3c38b6e41327c10334395249036e89464b409429584d13');
        vm.selectFork(blastFork);
        zeroFinance = new ZeroFinance();
    }

    function testLiquidityDeposit() public {
        vm.startPrank(usdbH);
        console.log(zeroFinance.getDepositedLiquidity(usdbH));
        USDB.approve(address(zeroFinance),200e18);
        zeroFinance.provideLiquidityUSDB(200e18);
        console.log(zeroFinance.getDepositedLiquidity(usdbH));
        assertEq((zeroFinance.getDepositedLiquidity(usdbH)), 200e18);
        vm.stopPrank();
    }

    function testLiquidityWithdraw() external {
        testLiquidityDeposit();
        vm.startPrank(usdbH);
        console.log(zeroFinance.getDepositedLiquidity(usdbH));
        
        zeroFinance.withdrawLiquidityUSDB();
        console.log(zeroFinance.getDepositedLiquidity(usdbH));
        assertEq((zeroFinance.getDepositedLiquidity(usdbH)), 0);
    }


}
