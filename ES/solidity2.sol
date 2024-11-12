// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

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
