// SPDX-License-Identifier: UNLICENSED

/*
 la differenza tra enum e struct è che con struct si vedrebbe il valore e i valori al suo interno possono essere di 
 vario tipo invece con gli enum ritornano l'indice, quindi se si volesse vedere choise_day ritornerebbe 0
*/
pragma solidity ^0.8.28;

contract Prova_enum {
    enum week_day {
        mondey,
        saturday
    }

    week_day week;
    week_day choise_day;

    function get_day() public {
        choise_day = week_day.mondey;
    }
}

contract prova_struct {
    struct persona {
        string nome;
        uint8 altezza;
        bool maggiorenne;
    }

    persona public luca;

    function get_persona(
        string memory _name,
        uint8 _heigth,
        uint8 _age
    ) public {
        luca.altezza = _heigth;
        luca.nome = _name;
        if (_age < 18) luca.maggiorenne = false;
        else luca.maggiorenne = true;
    }
}
