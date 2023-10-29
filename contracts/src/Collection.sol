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
    console.log("goal: ");
    console.log(pokemonAdress);
    for (int i = 0; i < cardCount; i++) {
      console.log("pokemonAdress");
      console.log(address(pokmeons[i]));
      // pokemon trouver.
      if (address(pokmeons[i]) == pokemonAdress) {
        console.log("pokemon trouver");
        // est ce qu'il est libre ?
        if (!pokmeons[i].hasOwner()) {
          console.log("pokemon libre");
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
      console.log("[card balance]");
      console.log(owner);
      console.log(pokmeons[i].owner());
      pokmeons[i].hasOwner();
      if (pokmeons[i].hasOwner()) {
        bool userOwnedPokemon = pokmeons[i].owner() == owner;
        if (userOwnedPokemon) {
          console.log("[one pokemon found]");
          balance++;
        }
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
