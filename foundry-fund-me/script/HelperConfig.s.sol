// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/AggregatorV3Interface.sol";

contract HelperConfig is Script {
    uint8 DECIMAL = 8;
    int256 PRICE = 2000e8;
    struct NetConfig {
        address priceFeed;
    }

    NetConfig public realNetConfig;

    constructor() {
        // block.chainId si riferisce all'attuale chainId perchè ogni rete ha il proprio chainId
        if (block.chainid == 11155111) realNetConfig = getSepolia();
        else if (block.chainid == 1) realNetConfig = getETHChain();
        else realNetConfig = anyChain();
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
    // impostazione di una nostra chain 
    function anyChain() public returns (NetConfig memory) {
        if (realNetConfig.priceFeed != address(0)) return realNetConfig;
        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMAL, PRICE);
        vm.stopBroadcast();
        NetConfig memory netconfig = NetConfig({
            priceFeed: address(mockPriceFeed)
        });

        return netconfig;
    }
}
