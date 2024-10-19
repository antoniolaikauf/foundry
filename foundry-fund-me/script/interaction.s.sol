// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";

import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Fundme} from "../src/Fund.sol";

contract FundFundme is Script {
    uint256 constant AMOUNT = 10 ether;
    function fundFundMe(address _recentDeployed) public {
        vm.startBroadcast();
        Fundme(payable(_recentDeployed)).fund{value: AMOUNT}(); // invia al contratto i soldi automaticamente
        vm.stopBroadcast();
    }
    function run() external {
        // guarda nella cartella dove ci sono i deploy dei contratti e prende l'ultimo deploiato
        address recentDeployed = DevOpsTools.get_most_recent_deployment(
            "Fundme",
            block.chainid
        );
        fundFundMe(recentDeployed);
    }
}