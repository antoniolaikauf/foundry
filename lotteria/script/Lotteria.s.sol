// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Lotteria} from "../src/Lotteria.sol";

contract LotteriaDeploy is Script {
    function run() external returns (Lotteria) {
        vm.startBroadcast();
        Lotteria lotteria = new Lotteria();
        vm.stopBroadcast();
        return lotteria;
    }
}
