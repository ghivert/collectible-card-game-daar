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
  mapping(int => Pokemon) public pokemons;

  constructor(string memory _name, int _cardCount, string memory _code) {
    name = _name;
    cardCount = _cardCount;
    code = _code;
  }

  function addCard(string memory url) public {
    Pokemon p = new Pokemon(url);
    pokemons[cardCount] = p;
    cardCount++;
  }

  function getPokemons() public view returns (address[] memory) {
    address[] memory pokemonsResult = new address[](uint256(cardCount));
    uint256 iUint = 0;
    for (int i = 0; i < (cardCount); i++) {
      pokemonsResult[iUint] = address(pokemons[i]);
      iUint++;
    }
    return pokemonsResult;
  }

  function mintAux(
    address receiver,
    address pokemonAdress
  ) public returns (bool) {
    for (int i = 0; i < cardCount; i++) {
      // pokemon trouver.
      if (address(pokemons[i]) == pokemonAdress) {
        // est ce qu'il est libre ?
        if (!pokemons[i].hasOwner()) {
          // si oui, on mint.
          pokemons[i].setOwner(receiver);
        }
      }
    }
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
      if (pokemons[i].owner() == owner) {
        allcards[index] = (pokemons[i].getId());
        index++;
      }
    }
    return allcards;
  }

  function ownerOf(address _tokenId) public view virtual returns (address) {
    for (int i = 0; i < cardCount; i++) {
      if (address(pokemons[i]) == _tokenId) {
        return pokemons[i].owner();
      }
    }
    return address(0);
  }

  function allPoekmons() public view virtual returns (string[] memory) {
    string[] memory result = new string[](uint256(cardCount));
    uint256 index = 0;
    for (int i = 0; i < cardCount; i++) {
      result[index] = pokemons[i].getId();
      index++;
    }
    return result;
  }

  function pokemonFromadress(
    address adressPokemon
  ) public view returns (string memory) {
    for (int i = 0; i < cardCount; i++) {
      //console.log("pokemon id : %s", address(pokemons[i]));
      //console.log("pokemon id : %s", pokemons[i]).getId();
      if (adressPokemon == address(pokemons[i])) {
        return pokemons[i].getId();
      }
    }
    return "";
  }
}
