// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";

import {Fundme} from "../src/Fund.sol";

contract FundMeTest is Test {
    Fundme fundme;
    // quest viene eseguita per prima
    function setUp() external {
        address zkSyncPriceFeed = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        fundme = new Fundme(zkSyncPriceFeed);
    }
    // questa viene eseguita una volta eseguita setup ed esegue i controlli
    function testDemo() public view {
        // per vedere i dati nel terminale forge test -vv
        assertEq(fundme.MINIMUN_USD(), 5e18);
    }

    function testOwner() public view {
        // address(this) ritorna l'address del contratto
        assertEq(fundme.i_owners(), address(this));
    }

    function testVersion() public view {
        uint256 version = fundme.getVersion();
        console.log(version);
        assertEq(version, 0);
    }
}
