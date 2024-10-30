// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Lotteria, Gamble} from "../src/Lotteria.sol";

contract LotteriaDeploy is Script {
    function run() external returns (Gamble) {
        vm.startBroadcast();
        Gamble gamble = new Gamble(10 ether);
        // Lotteria lotteria = new Lotteria();
        vm.stopBroadcast();
        return gamble;
    }
}
