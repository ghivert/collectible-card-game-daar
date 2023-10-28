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
  function createCollection2( string memory name,string memory code) external returns (Collection) {
    Collection collection = new Collection(name, 0, code);
    pokemonCollections[collectionCount] = collection;
    collectionCount++;
    return collection;
  }

  /**
    Create Pokemon NFT then return only its address
  */
  function createPokemon(string memory url_) external  returns(address){
    Pokemon p = new Pokemon(url_);
    address a = address(p);
    return a;
  }

  /**
    Create Pokemon NFT then return only its address
  */
  function createPokemon2(string memory url_) external  returns(address){
    Pokemon p = new Pokemon(url_);
    address a = address(p);
    return a;
  }

  /**
    Add a carte to a collection 
   */
  function add_carte_to_collection(int collection_id, string memory url_carte) public {
   // pokemonCollections[collection_id].addCarte(url_carte);
  }

  /**
    Get ALL COLECTION 
   */
  function allCollections() public view returns (string[] memory) {
    Collection[] memory collections = new Collection[](uint256(collectionCount));
    string[] memory codes = new string[](uint256(collectionCount));
    uint256 counter = 0;
    for (int i = 0; i < collectionCount; i++) {
      collections[counter] = pokemonCollections[i];
      codes[counter] = pokemonCollections[i].code();
      counter++;
    }
    return codes; //names des collections
  }

  /**
    Get ALL Pokemon of collection  
  */
  function allPokemonsOfCollection(
    int collectionId
  ) public view returns (string[] memory) {
    Collection collection = pokemonCollections[collectionId];
    string[] memory result = new string[](uint256(collection.counter()));
    uint256 index = 0;
    for (int i = 0; i < collection.counter(); i++) {
      //result[index] = collection.getPokemonById(i);
      index++;
    }
    return result;
  }


  function cardCount(address userAdress) pure external returns(int) {
    /*
    uint256 count = 0;
    for (int i = 0; i < collectionCount; i++) {
      count = pokemonCollections[i].getCardCount(userAdress) + count;
    }
    */
    return 267;
  }

  function balanceOf(address _owner) public virtual view override returns (int) {
       int value = super.balanceOf(_owner);
       return value;
  }

  modifier onlySuperAdmin() {
    require(msg.sender == admin, "Only Super Admin can call this function");
    _;
  }



}
