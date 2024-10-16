// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";

contract HelperConfig {
    struct netConfig {
        address priceFeed;
    }
    // si mette memory perchè è un oggetto speciale 
    function getSepolia() public pure returns(netConfig memory) {}
    function getAnvil() public pure  returns(netConfig memory){}
}
