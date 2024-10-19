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
        assertEq(fundme.i_owner(), msg.sender);
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
    // controllo se funder è corretto
    function testAddFunders() public {
        vm.prank(USER);
        fundme.fund{value: AMOUNT}();
        address funder = fundme.getFunder(0);
        assertEq(funder, USER);
    }

    function testPrelievo() public {
        // invio transazione
        vm.prank(USER);
        fundme.fund{value: AMOUNT}();
        // deve ritornare allo stato precedente essendo che lo USER è diverso da i_owner
        // che sarebbe msg.sender ma se si esegue di qua sarebbe address(this)
        vm.expectRevert();
        vm.prank(USER);
        fundme.withdraw();
    }

    // bug il balance di fundme.getOwner().balance; inizia con 79228162514264337593543950335
    function testPrelievoSingolo() public {
        vm.prank(USER);
        fundme.fund{value: AMOUNT}();
        uint256 startFundmeBalance = address(fundme).balance; // balance del contratto (fondi accumulati all'interno del contratto)
        uint256 startOwnerBalance = fundme.getOwner().balance; // balance del indirizzo del owner (fondi della singola persona)
        console.log(
            startFundmeBalance,
            "Balance del contratto prima di withdraw"
        );
        console.log(startOwnerBalance, "Balance dell'owner prima di withdraw");
        vm.prank(fundme.getOwner());
        fundme.withdraw(); // owner preleva i fondi dal contratto

        uint256 endOwnerBalance = fundme.getOwner().balance;
        uint256 endFundmeBalance = address(fundme).balance;

        console.log(endFundmeBalance, "Balance del contratto dopo di withdraw");
        console.log(endOwnerBalance, "Balance dell'owner dopo di withdraw");
        // non so come mai ma inizia con 79228162514264337593543950335 i balance
        console.log(
            "balance Owner:",
            (endOwnerBalance - 79228162514264337593543950335)
        );
        assertEq(endFundmeBalance, 0);
        assertEq(startFundmeBalance + startOwnerBalance, endOwnerBalance);
    }

    function testWithdrawMultipleFunders() public {
        uint8 funders = 10;
        uint160 startFundersIndex = 1;

        for (uint160 i = startFundersIndex; i < funders; i++) {
            hoax(address(i), AMOUNT); // hoax è come prank quindi la prossima transazione fa riferiment ad address(i)
            fundme.fund{value: AMOUNT}();
        }
        /*
         se non si mette vm.txGasPrice(GAS); in anvil il gas speso sarà sempre 0 cosa in una vera blockchain
         non è possibile.
         Per vedere quanto gas ti rimane si usa una build function che esiste in solidity 
         gas  gasleft()
        */
        vm.prank(USER);
        fundme.fund{value: AMOUNT}();

        uint256 startFundmeBalance = address(fundme).balance;
        uint256 startOwnerBalance = fundme.getOwner().balance;

        vm.prank(fundme.getOwner());
        fundme.withdraw();

        console.log(startFundmeBalance, "balance contratto start");
        console.log(startOwnerBalance, "balance owner start");

        uint256 endFundmeBalance = address(fundme).balance;
        uint256 endOwnerBalance = fundme.getOwner().balance;

        console.log(endFundmeBalance, "Balance del contratto dopo di withdraw");
        console.log(endOwnerBalance, "Balance dell'owner dopo di withdraw");
        console.log((endOwnerBalance - startOwnerBalance), "owner balance");

        assert(address(fundme).balance == 0);
        assert(
            startFundmeBalance + startOwnerBalance == fundme.getOwner().balance
        );
    }
}
