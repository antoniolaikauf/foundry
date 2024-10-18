// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";

import {Fundme} from "../src/Fund.sol";
import {CounterScript} from "../script/FundMe.s.sol";
contract FundMeTest is Test {
    address USER = makeAddr("antonio"); // creazione address 
    uint256 constant AMOUNT = 6e18;
    uint256 constant START_AMOUNT = 10 ether;
    Fundme fundme;
    function setUp() external {
        CounterScript counterScript = new CounterScript();
        // prendi contratto da file script
        fundme = counterScript.run();
        vm.deal(USER, START_AMOUNT); // inizia il balance dell'address con gia dentro soldi 
    }
    // questa viene eseguita una volta eseguita setup ed esegue i controlli
    function testDemo() public view {
        // per vedere i dati nel terminale forge test -vv
        assertEq(fundme.MINIMUN_USD(), 5e18);
    }

    function testOwner() public view {
        // address(this) ritorna l'address del contratto address(this)
        assertEq(fundme.i_owners(), msg.sender);
    }

    function testVersion() public view {
        uint256 version = fundme.getVersion();
        assertEq(version, 4);
        //6 chain eth
    }
    // controllo fondi minore di MINIMUN_USD
    function testFund() public {
        vm.expectRevert();
        fundme.fund();
    }

    // cntrollo fondi con soldi maggiore di MINIMUN_USD
    function testFundWithMoney() public {
        vm.prank(USER); // prossima transazione inviata da USER
        fundme.fund{value: AMOUNT}(); // le {} servono per inviare dei valori al constructor
        uint256 fund = fundme.getAmountFound(USER);
        assertEq(fund, AMOUNT);
    }
}
