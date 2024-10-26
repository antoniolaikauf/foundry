// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Lotteria {
    uint256 constant MINIMUN_ENTRANCE = 0.1 ether;
    uint256[] partecipanti;

    function enterRuffle(uint256 _enter_pool) public payable {
        require(_enter_pool * 1e18 >= MINIMUN_ENTRANCE);
        partecipanti.push(_enter_pool);
    }

    function winner() public view returns (uint256) {
        return partecipanti[0];
    }
}
