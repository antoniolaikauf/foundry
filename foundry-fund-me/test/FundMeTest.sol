// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {Fundme} from "../src/Fund.sol";

contract FundMeTest is Test {
    Fundme fundme;
    // quest viene eseguita per prima
    function setUp() external {
        fundme = new Fundme();
    }
    // questa viene eseguita una volta eseguita setup ed esegue i controlli
    function testDemo() public view {
        // per vedere i dati nel terminale forge test -vv
        console.log(fundme.i_owners(), "jjjjjj");
        assertEq(fundme.MINIMUN_USD(), 5e18);
    }
}
