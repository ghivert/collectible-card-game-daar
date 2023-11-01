// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Collection.sol";
import "./Ownable.sol";

contract Main is Ownable {
  uint256 private count;
  mapping(uint256 => Collection) private collections;
  mapping(uint256 => address) private collectionOwners;
  mapping(address => Collection[]) private ownerCollections;

  constructor() {
    count = 0;
    isAdmin[msg.sender] = true;
  }

  function createCollection(
    string memory _collectionName
  ) external returns (Collection) {
    Collection collection = new Collection(_collectionName, 0);
    collections[count] = collection;
    count++;
    return collection;
  }

    //The Main contract will have an owner (i.e. a super-admin), which will be able to mint and assign cards to a selected user in a selected collection.
  function mintAndAssignCard(
    uint256 _collectionId,
    uint256 _cardId
  ) internal onlyAdmin {
    collections[_collectionId].mint(_cardId);
  }

  function mintAndAssignCards(
    uint256 _collectionId,
    uint256[] memory _cardIds
  ) external onlyAdmin{
    for (uint256 i = 0; i < _cardIds.length; i++) {
      mintAndAssignCard(_collectionId, _cardIds[i]);
    }
  }

  function getAllCollections() public view returns (string[] memory) {
    Collection[] memory _collections = new Collection[](uint256(count));
    string[] memory collectionNames = new string[](uint256(count));
    uint256 index = 0;
    for (uint256 i = 0; i < count; i++) {
      _collections[index] = collections[i];
      collectionNames[index] = collections[i].collectionName();
      index++;
    }
    return collectionNames;
  }

  function getCardsFromCollection(
    uint256 collectionName
  ) public view returns (uint256[] memory) {
    Collection collection = collections[collectionName];
    uint256[] memory result = new uint256[](uint256(collection.cardNumberMinted()));
    uint256 index = 0;
    for (uint256 i = 0; i < collection.cardNumberMinted(); i++) { //.cardNumberMinted() retrieves the property "cardNumberMinted" from Collection contract 
      result[index] = collection.getCardIdByIndex(i);
      index++;
    }
    return result;
  }
}
