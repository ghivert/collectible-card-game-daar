// SPDX-License-Identifier: MIT
//pragma solidity >=0.5.0 <0.6.0;

pragma solidity ^0.8.19;

import "./Collection.sol";
import "./Ownable.sol";
import "./PokemonOwenrship.sol";

contract Main is Ownable{
  int private count;
  address admin;
  mapping(int => Collection) public pokemonCollections;

  constructor() {
    count = 0;
    admin = msg.sender;
    pokemonCollections[0] =new Collection("colectio1", 0);
    pokemonCollections[1] =new Collection("colectio2", 1);
    pokemonCollections[0].addCarte('xy7-10');
    count=2;
  }

  function createCollection(string memory name) public  {
    pokemonCollections[count++] = new Collection(name, 0);
  }

  function getMessage() public view returns (string memory)  {
        return "Hello World";
  }

  /**
    Add a carte to a collection 
   */
  function add_carte_to_collection(int collection_id, string memory url_carte) public onlySuperAdmin() {
    //require(pokemonCollections[collection_id]  !=  existe);
    pokemonCollections[collection_id].addCarte(url_carte);
  }

  /**
    Get ALL COLECTION 
   */
  function allCollections() public   onlySuperAdmin() view returns (Collection[] memory)  {
        Collection[] memory collections = new Collection[](2);
        uint256 counter =0;
        for (int i = 0; i < count; i++) {
            collections[counter] = pokemonCollections[i];
            counter++;
        }
        return collections; //adress de la collection !!
  }


    /**
      Get ALL Pokemon of collection  
    */
    function allPokemonsOfCollection(int collectionId) public onlySuperAdmin() view returns(string [] memory){
          Collection collection = pokemonCollections[collectionId];
        require(collectionId >= 0 && collectionId < count, "Invalid collection ID");
        string[] memory result = new string[](uint256(collection.cardCount()));
        uint256 index = 0;
        for (int i = 0; i < collection.cardCount(); i++) {
            result[index] = collection.getPokemonById(i);
            index++;
        }

        // Resize the result array to remove any empty slots
        assembly {
            mstore(result, index)
        }

        return result;
    }


   modifier onlySuperAdmin() {
        require(msg.sender != admin, "Only Super Admin can call this function");
        _;
    }
 
}
