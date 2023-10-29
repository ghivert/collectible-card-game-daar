// SPDX-License-Identifier: MIT
//pragma solidity  >=0.5.0 <0.6.0;
pragma solidity ^0.8.19;

import "hardhat/console.sol";
import "./Ownable.sol";
import "./ERC721.sol";
import "./Pokemon.sol";

contract Collection {
  string public name;
  string public code;
  int public cardCount; //taile de la colection
  mapping(int => Pokemon) public pokmeons;

  constructor(string memory _name, int _cardCount, string memory _code) {
    name = _name;
    cardCount = _cardCount;
    code = _code;
  }

  function addCard(string memory url) public {
    Pokemon p = new Pokemon(url);
    pokmeons[cardCount] = p;
    cardCount++;
  }

  function mintAux(
    address receiver,
    address pokemonAdress
  ) public returns (bool) {
    for (int i = 0; i < cardCount; i++) {
      // pokemon trouver.
      if (address(pokmeons[i]) == pokemonAdress) {
        // est ce qu'il est libre ?
        if (!pokmeons[i].hasOwner()) {
          // si oui, on mint.
          pokmeons[i].setOwner(receiver);
        }
      }
    }
  }

  /** Returns the number of nft owned by a user in the collection.
   */
  function balanceOf(address owner) public view returns (int) {
    int balance = 0;
    for (int i = 0; i < cardCount; i++) {
      // log:  owner vs pokemon owner
      if (pokmeons[i].owner() == owner) {
        balance++;
      }
    }
    return balance;
  }

  /**
      returns all cards of user 
   */
  function allCardsUser(
    address owner
  ) public view virtual returns (string[] memory) {
    string[] memory allcards;
    uint256 index = 0;
    for (int i = 0; i < cardCount; i++) {
      if (pokmeons[i].owner() == owner) {
        allcards[index] = (pokmeons[i].getId());
        index++;
      }
    }
    return allcards;
  }

  function ownerOf(address _tokenId) public view virtual returns (address) {}

  function allPoekmons() public view virtual returns (string[] memory) {
    string[] memory result = new string[](uint256(cardCount));
    uint256 index = 0;
    for (int i = 0; i < cardCount; i++) {
      result[index] = pokmeons[i].getId();
      index++;
    }
    return result;
  }
}
