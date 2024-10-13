// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// installate direttamente forge install smartcontractkit/chainlink-brownie-contracts --no-commit si trovano direttaente
// in lib chainlink-brownie-contracts
// primo modo
// import {AggregatorV3Interface} from "./../lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// secondo modo con remapping in foundry.toml
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error FundMe__NotOwner();

contract fundme {
    mapping(address => uint256) public address_to_amount_fund;
    address[] public funders;
    address public i_owners;
    AggregatorV3Interface private s_priceFeed;
    uint256 public constant MINIMUN_USD = 5 * 10 ** 18;

    modifier onlyOwner() {
        if (msg.sender != i_owners) revert FundMe__NotOwner();
        _;
    }

    // s_priceFeed = AggregatorV3Interface(priceFeed);
    constructor() {
        i_owners = msg.sender;
    }
}
