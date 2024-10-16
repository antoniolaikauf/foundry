// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Fundme} from "../src/Fund.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract CounterScript is Script {
    function run() public returns (Fundme) {
        HelperConfig helperConfig = new HelperConfig(); // quando si crea un contratto viene chiamato il contractor
        address PriceFeed = helperConfig.realNetConfig();
        vm.startBroadcast();
        // ottimizzazione crea il contratto e lo ritorna cosi che si può usare nel test
        Fundme fundme = new Fundme(PriceFeed);
        vm.stopBroadcast();
        return fundme;
    }
}
