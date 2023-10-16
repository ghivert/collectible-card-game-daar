 // SPDX-License-Identifier: MIT
//pragma solidity >=0.5.0 <0.6.0;
pragma solidity ^0.8.16;
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

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return collections[_tokenId];
  }
   function ownerOf(int id) external view returns (string memory) {
    return collections[id].name;
  }


    function getcollectionByOwner(address _owner) external view returns(uint[] memory) {
          uint[] memory result = new uint[](0);
          result[0] = 0;  //needs to be changedd
          return result;

    }
}
