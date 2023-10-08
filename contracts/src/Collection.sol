// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Collection {
  string public name;
  int public cardCount;

  constructor(string memory _name, int _cardCount) {
    name = _name;
    cardCount = _cardCount;
  }
}
