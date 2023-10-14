 // SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./Collection.sol";
import "./ERC721.sol";

contract Main  is ERC721 {
  int private count;
  mapping(int => Collection) public collections;

  constructor() {
    count = 0;
  }

  function createCollection(string calldata name, int cardCount) external {
    collections[count++] = new Collection(name, cardCount);
  }
  // @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    /// @param Documents a parameter just like in doxygen (must be followed by parameter name);
   function ownerOf(int cardCount) external view returns (string) {
    return collections[cardCount].name;
  }
}
