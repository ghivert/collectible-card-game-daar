// SPDX-License-Identifier: MIT
//pragma solidity >=0.5.0 <0.6.0;

pragma solidity ^0.8.19;

import "./Collection.sol";
import "./Ownable.sol";
import "./PokemonOwenrship.sol";


contract Main is Ownable{
  int private count;
  address private admin;
  mapping(int => Collection) public pokemonCollections;
  PokemonOwenership public pokemonownership;

  constructor() {
    count = 0;
    admin = msg.sender;
    pokemonownership = new PokemonOwenership();
  }
  /**
  Create new collection 
  Chaque modification de l'état du contrat (ajout de cartes, modification de propriétés, etc.) nécessite 
  une transaction sur la blockchain, et chaque transaction doit être validée et confirmée par le réseau Ethereum.
   Cela garantit l'intégrité des données et assure que toutes les parties de la blockchain sont synchronisées avec 
   la même version du contrat.
  */
  function createCollection(string memory name)  external returns(string memory){
    Collection collection = new Collection(name, 1);
    pokemonCollections[count]=collection;
    count++;
    return name;
  }

  /**
    Add a carte to a collection 
   */
  function add_carte_to_collection(int collection_id, string memory url_carte) public{
    pokemonCollections[collection_id].addCarte(url_carte);
  }

  /**
    Get ALL COLECTION 
   */
  function allCollections() public  view returns (Collection[] memory)  {
        Collection[] memory collections = new Collection[](uint256(count));
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
  function allPokemonsOfCollection(int collectionId) public view returns(string [] memory){
      Collection collection = pokemonCollections[collectionId];
      string[] memory result = new string[](uint256(collection.cardCount()));
      uint256 index = 0;
      for (int i = 0; i < collection.cardCount(); i++) {
          result[index] = collection.getPokemonById(i);
          index++;
      }
      return result;
  }

  function balanceOf_(address _owner) public  view  returns(uint256){
    return pokemonownership.balanceOf(_owner);
  }

  function owner_of_(string memory _tokenId) public view returns (address){
       return pokemonownership.ownerOf(_tokenId);

  }

  function getMessage() public view returns (string memory) {
        return "Hello World";
  }
   modifier onlySuperAdmin() {
        require(msg.sender == admin, "Only Super Admin can call this function");
        _;
    }

}
