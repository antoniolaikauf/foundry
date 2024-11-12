// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {VRFConsumerBaseV2Plus} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

contract Lotteria is VRFConsumerBaseV2Plus {
    error NotEnoughEth();
    uint256 private immutable i_MINIMUN_ENTRANCE;
    // ogni quanto si estrae un vincitore
    uint256 private immutable i_time_winner;
    bytes32 private immutable i_keyHash;
    uint256 private immutable i_last_time;
    uint32 private immutable i_callbackGasLimit;
    uint256 private immutable i_subscriptionId;
    uint16 private constant requestConfirmations = 3;
    uint32 private constant i_numWords = 1;
    address payable private address_vincitore;

    uint256 vincita;
    address payable[] private partecipanti; // gli address sono payable cosi che possono ricevere soldi della vincita
    event addressStore(address);
    //  P.S  quando si eredita un contratto che ha un contructor allora bisogna metterlo nel costructor del contratto da cui eredita
    constructor(
        uint256 _entra_fee,
        uint256 _time,
        address _VRcordinator,
        bytes32 _gasLane,
        uint256 _subscriptionId,
        // uint32 _numWords,
        uint32 _callbackGasLimit
    ) VRFConsumerBaseV2Plus(_VRcordinator) {
        i_MINIMUN_ENTRANCE = _entra_fee;
        i_time_winner = _time;
        i_last_time = block.timestamp;
        i_keyHash = _gasLane;
        i_subscriptionId = _subscriptionId;
        // i_numWords = _numWords;
        i_callbackGasLimit = _callbackGasLimit;
    }

    function enterRuffle(uint256 _price_person) external payable {
        // rinvertire se manda meno ether
        // require(_price_person * 1e18 >= MINIMUN_ENTRANCE, NotEnoughEth()); // funziona con solo una versione di compilatore
        if (_price_person * 1e18 < i_MINIMUN_ENTRANCE) revert NotEnoughEth();
        emit addressStore(msg.sender);
        // ilbalance del contratto aumenta a prescindere quindi la variabile vincita non ha molto senso 
        vincita += _price_person;
        partecipanti.push(payable(msg.sender));
    }

    function winner() public {
        if (block.timestamp - i_last_time < i_time_winner) revert();
        // request sarebbe uno struct vedere contract VRFV2PlusClient
        VRFV2PlusClient.RandomWordsRequest memory request = VRFV2PlusClient
            .RandomWordsRequest({
                keyHash: i_keyHash, //which is the maximum gas price you are willing to pay for a request in wei
                subId: i_subscriptionId, // The subscription ID that this contract uses for funding requests
                requestConfirmations: requestConfirmations, // quant blocchi dete aspettare prima di ritornarti il numero
                callbackGasLimit: i_callbackGasLimit, //The limit for how much gas to use for the callback request to your contract's quanto uìgas usare per ritornare le words
                numWords: i_numWords, //How many random values to request
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            });
        // s_vrfCoordinator questa variabile non viene dichiarata in questo contratto perchè in realà viene ereditata e si trova nel contratto VRFConsumerBaseV2Plus
        uint256 requestId = s_vrfCoordinator.requestRandomWords(request);
        // i_last_time = block.timestamp;
    }

    // queste sono funzioni indefinite
    // questa funzione in realtà chiama rawFulfillRandomWords
    function fulfillRandomWords(
        uint256 requestId,
        uint256[] calldata randomWords
    ) internal override {
        uint256 random_index = partecipanti.length % randomWords[0];
        address_vincitore = partecipanti[random_index];
        address_vincitore.transfer(address(this).balance);
        vincita = 0;
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
