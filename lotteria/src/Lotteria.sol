// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Lotteria {
    error NotEnoughEth();
    uint256 constant MINIMUN_ENTRANCE = 0.1 ether;
    uint256 vincita;
    address payable[] private partecipanti; // gli address sono payable cosi che possono ricevere soldi della vincita
    event addressStore(address);
    function enterRuffle(uint256 _price_person) public payable {
        // rinvertire se manda meno ether
        // require(_price_person * 1e18 >= MINIMUN_ENTRANCE, NotEnoughEth()); // funziona con solo una versione di compilatore
        if (_price_person * 1e18 < MINIMUN_ENTRANCE) revert NotEnoughEth();
        emit addressStore(msg.sender);
        vincita += _price_person;
        partecipanti.push(payable(msg.sender));
    }

    function winner() public view returns (address, uint256) {
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
