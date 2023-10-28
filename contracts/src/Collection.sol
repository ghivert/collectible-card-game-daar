// SPDX-License-Identifier: MIT
//pragma solidity  >=0.5.0 <0.6.0;
pragma solidity ^0.8.19;

import "./Ownable.sol";
import "./ERC721.sol";
import "./Ownable.sol";

contract Collection is Ownable {
  string public name;
  string public code;
  int public cardCount; //taile de la colection
  int public counter;
  mapping(int => string) public pokmeons;

  constructor(string memory _name, int _cardCount, string memory _code) {
    name = _name;
    cardCount = _cardCount;
    counter = 0;
    code = _code;
  }

  function addCarte(string memory url) public {
    pokmeons[counter] = url;
    counter++;
  }

  function getPokemonById(int index) public view returns (string memory) {
    require(index >= 0 && index < counter, "Invalid index");
    return pokmeons[index];
  }

  function getCode() public view returns (string memory) {
    return code;
  }
}