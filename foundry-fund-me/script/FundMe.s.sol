// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Fundme} from "../src/Fund.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
contract CounterScript is Script {
    function run() public returns (Fundme) {
        HelperConfig helperConfig = new HelperConfig();
        address PriceFeed = helperConfig.realNetConfig();
        vm.startBroadcast();
        Fundme fundme = new Fundme(PriceFeed);
        vm.stopBroadcast();
        return fundme;
    }
}
