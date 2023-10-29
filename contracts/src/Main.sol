// SPDX-License-Identifier: MIT
//pragma solidity >=0.5.0 <0.6.0;

pragma solidity ^0.8.19;

import "./Collection.sol";
import "./Ownable.sol";
import "./PokemonOwenrship.sol";
import "./Pokemon.sol";
import "./PokemonOwenrship.sol";

contract Main is PokemonOwenership {
  address private admin;

  constructor() {
    admin = msg.sender;
  }

  /**
  Create new collection 
  */
  function createCollection2(
    string memory name,
    string memory code
  ) external returns (Collection) {
    Collection collection = new Collection(name, 0, code);
    pokemonCollections[collectionCount] = collection;
    collectionCount++;
    return collection;
  }

  /**
    Create Pokemon NFT then return only its address
  */
  function createPokemon2(string memory url_) public returns (Pokemon) {
    Pokemon p = new Pokemon(url_);
    return p;
  }

  /**
    Add a carte to a collection 
   */
  function addCardToCollection(
    int collectionId,
    string memory pokemonId
  ) external returns (bool) {
    pokemonCollections[collectionId].addCard(pokemonId);
    return true; // s'assurer que la carte a bien été inseree
  }

  /**
    Get ALL COLECTION 
   */
  function allCollections() public view returns (string[] memory) {
    Collection[] memory collections = new Collection[](
      uint256(collectionCount)
    );
    string[] memory codes = new string[](uint256(collectionCount));
    uint256 counter = 0;
    for (int i = 0; i < collectionCount; i++) {
      collections[counter] = pokemonCollections[i];
      codes[counter] = pokemonCollections[i].code();
      counter++;
    }
    return codes;
  }

  /**
    Get ALL Pokemon of collection  
  */
  function allPokemonsOfCollection(
    int collectionId
  ) public view returns (string[] memory) {
    Collection collection = pokemonCollections[collectionId];
    return collection.allPoekmons();
  }

  /**
      Affichage des cartes d'un utilisateur 
  */
  function allCardsUser(
    address _owner
  ) public view virtual returns (string[] memory) {
    string[] memory pokemonsUser;
    string[] memory result;
    uint256 j = 0;
    for (int i = 0; i < collectionCount; i++) {
      Collection collection = pokemonCollections[i];
      result = (collection.allCardsUser(_owner));
      uint256 index = 0;
      while (j < result.length) {
        pokemonsUser[j] = result[index];
      }
    }
    return pokemonsUser;
  }

  function balanceOf(
    address _owner
  ) public view virtual override returns (int) {
    int value = super.balanceOf(_owner);
    return value;
  }

  /** Return the number of cards in a giving collection.
   */
  function cardCount(int collectionId) public view returns (int) {
    Collection collection = pokemonCollections[collectionId];
    return collection.cardCount();
  }

  function identity(address userAddress) public view returns (address) {
    return userAddress;
  }

  modifier onlySuperAdmin() {
    require(msg.sender == admin, "Only Super Admin can call this function");
    _;
  }
}
