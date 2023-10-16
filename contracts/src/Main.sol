 // SPDX-License-Identifier: MIT
//pragma solidity >=0.5.0 <0.6.0;
pragma solidity ^0.8.16;
import "./Collection.sol";

contract Main   {
  int private count;
  mapping(int => Collection) public collections;

  constructor() {
    count = 0;
  }

  function createCollection(string calldata name, int cardCount) external {
    collections[count++] = new Collection(name, cardCount);
  }





}
