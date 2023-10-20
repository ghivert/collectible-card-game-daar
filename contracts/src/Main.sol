// SPDX-License-Identifier: MIT
//pragma solidity >=0.5.0 <0.6.0;

pragma solidity ^0.8.20;

import "./Collection.sol";
import "./Ownable.sol";
import "./PokemonOwenrship.sol";

contract Main  is  Ownable{
  int private count;
  address admin;
  mapping(int => Collection) public pokemonCollections;

  constructor()  Ownable() {
    count = 0;
  }

  function createCollection(string memory name) public  onlyOwner(){
    pokemonCollections[count++] = new Collection(name, 0);
  }

  function getMessage() public view returns (string memory) {
        return "Hello World";
  }
  /**
    Add a carte to a collection 
   */
  function add_carte_to_collection(int collection_int, string memory url_carte) public  onlyOwner  {
    pokemonCollections[collection_int].addCarte(url_carte);
  }
  

}
