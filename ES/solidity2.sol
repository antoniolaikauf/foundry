// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

//type C is V;, where C is the name of the newly introduced type and V has to be a built-in value type
type Price is uint128;

contract Math {
    function add(Price _a1, Price _a2) public pure returns (Price) {
        Price c = Price.wrap(Price.unwrap(_a1) + Price.unwrap(_a2));
        // assert non pupò essere applicato a type Price
        // evita overflow e underflow
        assert(Price.unwrap(c) >= Price.unwrap(_a1));
        return c;
    }
}

interface BalanaceUser {
    function balance(
        address _address,
        uint256 _balance
    ) external returns (uint256);
}

contract User is BalanaceUser {
    function balance(
        address _address,
        uint256 _balance
    ) external view returns (uint256) {
        uint256 money_user = _address.balance + _balance;
        return money_user;
    }
}
