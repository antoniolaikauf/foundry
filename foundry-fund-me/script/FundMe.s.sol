// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Fundme} from "../src/Fund.sol";
contract CounterScript is Script {
    function run() public {
        vm.startBroadcast();
        address zkSyncPriceFeed = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        new Fundme(zkSyncPriceFeed);
        vm.stopBroadcast();
    }
}

