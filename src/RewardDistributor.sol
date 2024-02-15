// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Interface/IBlast.sol";
import "./ZeroFinance.sol";

/// @title RewardDistributor: Distribute the Reward to LP's
/// @author Soumen Jana(soumenjana029@gmail.com)
contract RewardDistributor { 
    IBlast public constant BLAST = IBlast(0x4300000000000000000000000000000000000002); 
    address public zeroFinance;
    address public owner;
    uint256 public feeEarned;
    uint256 public yieldEarned;
    uint currentRewardPerUser;
    bool rewardDistributed;

    /// @notice Need to implement yield Distribution and better way to distribute the earned fees.
    constructor(address _zeroFinance) {
        zeroFinance = _zeroFinance;
    }

    /// @notice Distributing the reward to lp's. Currently every LP will get same reward despite their joining time(except for first 7 days)
    /// @notice this need to implemented in a way that will benefit the LP's as per joining time. 
    /// @notice the longer the LP provide liquidity the larger reward will be ditributed to the LP
    function distributeReward() public {
        require(msg.sender == zeroFinance);

        if (feeEarned > 0 && !rewardDistributed) {
            uint256 lpLength = ZeroFinance(zeroFinance).getLPLength();
            currentRewardPerUser = feeEarned / lpLength;
            rewardDistributed = true;
        }        
    }

    function claimReward(address lpUser) public {
        require(msg.sender == zeroFinance);
        payable(lpUser).transfer(currentRewardPerUser);
    }

    receive() external payable {
        if(msg.sender == zeroFinance) {
            feeEarned += msg.value;
        } else if (msg.sender == address(BLAST)) {
            yieldEarned += msg.value;
        } else {
            revert();
        }
    }
}