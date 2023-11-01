// SPDX-License-Identifier: MIT
//pragma solidity  >=0.5.0 <0.6.0;
pragma solidity ^0.8.19;

import "./Ownable.sol";
import "./ERC721.sol";
import "./Ownable.sol";

contract Collection is Ownable {
  string public collectionName; //it's kinda the id of the collection
  uint256 public cardNumberMax; // number of cards in the collection (size)
  uint256 public cardNumberMinted;  // number of cards created -1, because it functions as an index that starts from 0
  mapping(uint256 => uint256) public collectionToCards; //given by indexes

  constructor(string memory _collectionName, uint256 _cardNumberMax) {
    collectionName = _collectionName;
    cardNumberMax = _cardNumberMax;
    cardNumberMinted = 0;
  }

    //The owner will be able to mint and assign an arbitrary amount of cards to a user from a specified collection.
  function mint(
    uint256 _cardId
    //string memory _tokenURI
  ) public returns (bool) {
    collectionToCards[cardNumberMinted] = _cardId;
    cardNumberMinted++;
    // emit Transfer(msg.sender, _to, _cardId);
    return true;
  }

  function getCardIdByIndex(uint256 _index) public view returns (uint256) {
    require(_index >= 0 && _index < cardNumberMinted, "Invalid index");
    return collectionToCards[_index];
  }

}