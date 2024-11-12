
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

//type C is V;, where C is the name of the newly introduced type and V has to be a built-in value type 
type Price is uint128;
// queste tipo di variabili scelte dall'user possono avere due funzioni 
Price.wrap()  che prende il valore (che è un uint128) all'interno e lo fa diventare di tipo Price
Price.unwrap() che prende un valore di tipo Price e lo ritrasforma di tipo uint128 
di solito si utilizza questo per migliorare la leggibilità e la sicurezza 
