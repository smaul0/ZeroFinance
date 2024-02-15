// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/// @title ZeroFinance: A zero interest lending pool
/// @author Soumen Jana(soumenjana029@gmail.com)
/// @notice borrow USDB without worrying about paying interest.
interface IZeroFinance { 
    function provideLiquidityUSDB(uint256) external;
    function withdrawLiquidityUSDB() external returns(uint);
    function borrow(uint256) external;
    // function Liquidation() external returns(uint);
    function depositCollateral(uint256) payable external;
    // function borrowUSDB() external returns(uint);
}