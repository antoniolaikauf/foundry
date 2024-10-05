// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Counter {
    uint256 myFavoriteNumber;

    struct persone {
        // type creato
        int256 number;
        string name;
    }

    function store(uint256 _myFavoriteNumbe) public {
        myFavoriteNumber = _myFavoriteNumbe;
    }
    
    function retrive() public view returns (uint256) {
        return myFavoriteNumber;
    }

    persone[] public list_persone; // array di type persone

    mapping(string => int256) public name_to_number;

    function list_name(string memory _name, int256 _number) public {
        list_persone.push(persone(_number, _name)); // mette persone in array
        name_to_number[_name] = _number;
    }
}
