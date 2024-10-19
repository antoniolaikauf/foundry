// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
// installate direttamente forge install smartcontractkit/chainlink-brownie-contracts --no-commit si trovano direttaente
// in lib chainlink-brownie-contracts
// primo modo
// import {AggregatorV3Interface} from "./../lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// secondo modo con remapping in foundry.toml
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {MockV3Aggregator} from "@chainlink/contracts/src/v0.8/tests/MockV3Aggregator.sol";
import {PriceConverter} from "./PriceConverter.sol";

error FundMe__NotOwner();

contract Fundme {
    using PriceConverter for uint256;
    MockV3Aggregator mockV3Aggregator;
    mapping(address => uint256) private s_address_to_amount_fund;
    address[] private s_funders;
    address public immutable i_owner;
    AggregatorV3Interface private s_priceFeed;
    uint256 public constant MINIMUN_USD = 5 * 10 ** 18;

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }
    // se si mette un input allora alla creazione del contratto nello script bisognerebbe aggiungere un input
    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function fund() public payable {
        // controlla minimo fondi per transazione
        require(
            msg.value.getConversionRate(s_priceFeed) >= MINIMUN_USD,
            "You need to spend more ETH!"
        );
        s_address_to_amount_fund[msg.sender] = msg.value;
        s_funders.push(msg.sender);
    }
    // onlyOwner permette l'esecuzione corretta di questa funzione e controlla che
    // chi l'ha chiamata è il i_owner, se un altro chiama questa funzione e non è i_owner
    // allora uscirà un errore
    function withdraw() public onlyOwner {
        uint256 lengthFundes = s_funders.length; // non viene salvata dentro allo storage essendo che è dentro alla funzione
        for (
            uint256 funderIndex = 0;
            funderIndex < lengthFundes;
            funderIndex++
        ) {
            address funder = s_funders[funderIndex];
            s_address_to_amount_fund[funder] = 0;
        }
        s_funders = new address[](0);

        // invia i soldi dell'address a i_owner
        (bool success, ) = i_owner.call{value: address(this).balance}("");
        require(success);
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    // function get

    // ottieni fondi
    function getAmountFound(
        address _address_fund
    ) external view returns (uint256) {
        return s_address_to_amount_fund[_address_fund];
    }
    // ritorna address
    function getFunder(uint256 index) public view returns (address) {
        return s_funders[index];
    }

    function getOwner() external view returns (address) {
        return i_owner;
    }
} //https://github.com/Cyfrin/foundry-fund-me-cu/blob/main/script/DeployFundMe.s.sol
