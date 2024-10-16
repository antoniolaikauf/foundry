// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";

import {Fundme} from "../src/Fund.sol";
import {CounterScript} from "../script/FundMe.s.sol";
contract FundMeTest is Test {
    // quest viene eseguita per prima
    Fundme fundme;
    function setUp() external {
        CounterScript counterScript = new CounterScript();
        fundme = counterScript.run();
    }
    // questa viene eseguita una volta eseguita setup ed esegue i controlli
    function testDemo() public view {
        // per vedere i dati nel terminale forge test -vv
        assertEq(fundme.MINIMUN_USD(), 5e18);
    }

    function testOwner() public view {
        // address(this) ritorna l'address del contratto address(this)
        assertEq(fundme.i_owners(), msg.sender);
    }

    function testVersion() public view {
        uint256 version = fundme.getVersion();
        assertEq(version, 4);
    }
}
