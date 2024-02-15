pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/ZeroFinance.sol";

contract ContractBTest is Test {
    ZeroFinance ZeroFinance;

    function setUp() public {
        testNumber = new ZeroFinance();
    }
}
