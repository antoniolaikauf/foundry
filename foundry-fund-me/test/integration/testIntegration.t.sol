// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {Fundme} from "../../src/Fund.sol";
import {CounterScript} from "../../script/FundMe.s.sol";
import {FundFundme} from "../../script/interaction.s.sol";

contract testIntegration is Test {
    address USER = makeAddr("antonio");
    uint256 constant START_AMOUNT = 10 ether;
    Fundme fundme;
    function setUp() external {
        CounterScript deploy = new CounterScript();
        fundme = deploy.run();
        vm.deal(USER, START_AMOUNT);
    }

    function testUser() public {
        FundFundme fundFundme = new FundFundme(); // prende ultimo contratto deploiato
        // fundme.fund{value: 1e18}();
        fundFundme.fundFundMe(address(fundme));
        // address funder = fundme.getFunder(0);
        // assert(funder == USER);
    }
}
