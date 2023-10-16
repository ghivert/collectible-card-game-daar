// SPDX-License-Identifier: MIT
//pragma solidity  >=0.5.0 <0.6.0;
pragma solidity ^0.8.16;

import "./Ownable.sol";
import "./Pokemon.sol";

contract Collection  {  ///card==nft
  string public name;
  int public cardCount;  // nomre de carte dns la collection
  //adress public owner;
  // (tokennft==> Card )
  mapping(uint => Pokemon)  pokemons;

  constructor(string memory _name, int _cardCount) {
    name = _name;
    cardCount = _cardCount;
  }

}
