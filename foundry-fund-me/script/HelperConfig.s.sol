// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";

contract HelperConfig {
    struct NetConfig {
        address priceFeed;
    }

    NetConfig public realNetConfig;

    constructor() {
        // block.chainId si riferisce all'attuale chainId perchè ogni rete ha il proprio chainId
        if (block.chainid == 11155111) realNetConfig = getSepolia();
        else if (block.chainid == 1) realNetConfig = getETHChain();
    }
    // si mette memory perchè è un oggetto speciale
    function getSepolia() public pure returns (NetConfig memory) {
        NetConfig memory netconfig = NetConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return netconfig;
    }
    function getETHChain() public pure returns (NetConfig memory) {
        NetConfig memory netconfig = NetConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return netconfig;
    }
}
