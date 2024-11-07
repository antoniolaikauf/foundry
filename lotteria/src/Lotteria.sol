// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {VRFConsumerBaseV2Plus} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from '../lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol';

contract Lotteria is VRFConsumerBaseV2Plus {
    error NotEnoughEth();
    uint256 private immutable i_MINIMUN_ENTRANCE;
    // ogni quanto si estrae un vincitore
    uint256 private immutable i_time_winner;

    uint256 private i_last_time;

    uint256 vincita;
    address payable[] private partecipanti; // gli address sono payable cosi che possono ricevere soldi della vincita
    event addressStore(address);
    //  P.S  quando si eredita un contratto che ha un contructor allora bisogna metterlo nel costructor del contratto da cui eredita
    constructor(
        uint256 _entra_fee,
        uint256 _time,
        address _VRcordinator
    ) VRFConsumerBaseV2Plus(_VRcordinator) {
        i_MINIMUN_ENTRANCE = _entra_fee;
        i_time_winner = _time;
        i_last_time = block.timestamp;
        // questa variabile non viene dichiarata in questo contratto perchè in realà viene ereditata e si trova nel contratto VRFConsumerBaseV2Plus

        s_vrfCoordinator.requestRandomWords();
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
// request sarebbe uno struct vedere contract VRFV2PlusClient
        VRFV2PlusClient.RandomWordsRequest request = VRFV2PlusClient
            .RandomWordsRequest({
                keyHash: s_keyHash,
                subId: s_subscriptionId,
                requestConfirmations: requestConfirmations,
                callbackGasLimit: callbackGasLimit,
                numWords: numWords,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            });


        uint256 requestId = s_vrfCoordinator.requestRandomWords(
           request
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
