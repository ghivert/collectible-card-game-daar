// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Collection {
  string public collectionName; //it's kinda the id of the collection
  uint256 public cardNumberMax; // number of cards in the collection (size)
  uint256 public cardNumberMinted;  // number of cards created -1, because it functions as an index that starts from 0
  mapping(uint256 => string) public cards; //from index of the card to the card Id (string)
  // mapping(string => uint256) public collectionNameToId; //from collection name to collection id

  constructor(string memory _collectionName, uint256 _cardNumberMax) {
    collectionName = _collectionName;
    cardNumberMax = _cardNumberMax;
    cardNumberMinted = 0;
  }

    //The owner will be able to mint and assign an arbitrary amount of cards to a user from a specified collection.
  function mint(
    string memory _cardId
  ) public returns (bool) {
    cards[cardNumberMinted]=_cardId;
    cardNumberMinted++;
    return true;
  }

}