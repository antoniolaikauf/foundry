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
