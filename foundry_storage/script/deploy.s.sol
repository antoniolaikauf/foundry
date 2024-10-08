// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";
// questo contract serve solo per il deploy dello smart contract sulla blockchain
contract simplestorage is Script {
    function run() external returns (Counter) {
        // vm keyword che si usa solo in foundry
        // e all'interno di startBroadcast e  stopBroadcast  sarà il codice che verrà deploiato
        vm.startBroadcast();
        Counter counter = new Counter(); // si crea un nuovo contratto
        vm.stopBroadcast();
        return counter;
    }
}
