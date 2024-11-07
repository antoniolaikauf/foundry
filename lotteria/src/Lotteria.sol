// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {VRFCoordinatorV2Interface} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/interfaces/VRFCoordinatorV2Interface.sol";

contract Lotteria is VRFCoordinatorV2Interface  {
    error NotEnoughEth();
    uint256 private immutable i_MINIMUN_ENTRANCE;
    // ogni quanto si estrae un vincitore
    uint256 private immutable i_time_winner;

    uint256 private i_last_time;

    uint256 vincita;
    address payable[] private partecipanti; // gli address sono payable cosi che possono ricevere soldi della vincita
    event addressStore(address);

    constructor(uint256 _entra_fee, uint256 _time) {
        i_MINIMUN_ENTRANCE = _entra_fee;
        i_time_winner = _time;
        i_last_time = block.timestamp;
    }
    function enterRuffle(uint256 _price_person) public payable {
        // rinvertire se manda meno ether
        // require(_price_person * 1e18 >= MINIMUN_ENTRANCE, NotEnoughEth()); // funziona con solo una versione di compilatore
        if (_price_person * 1e18 < i_MINIMUN_ENTRANCE) revert NotEnoughEth();
        emit addressStore(msg.sender);
        vincita += _price_person;
        partecipanti.push(payable(msg.sender));
    }

    function winner() public returns (address, uint256) {
        if (block.timestamp - i_last_time < i_time_winner) revert();

        requestId = COORDINATOR.requestRandomWords(
            s_keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );

        i_last_time = block.timestamp;
        return (partecipanti[0], vincita);
    }
}

contract Gamble {
    uint256 private balance_address_contract = address(this).balance;
    constructor(uint256 money) {
        balance_address_contract = money;
    }

    function dubleGamble() external payable {
        address address_player = msg.sender;
        require(msg.value == 1 ether);
        require(
            address(this).balance > 0,
            "gg i finished my money and fuck you"
        );
        if (block.timestamp % 2 == 0) {
            (bool success, ) = address_player.call{value: 1 ether}(""); // controllare ogni volta send
            require(success);
            balance_address_contract -= 1 ether;
        } else {
            // fuck off
            balance_address_contract += 1 ether;
        }
    }

    function getBalance_contract() public view returns (uint256) {
        return balance_address_contract;
    }
}
