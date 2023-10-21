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
    pokemonCollections[0] =new Collection("colectio1", 1);
    pokemonCollections[1] =new Collection("colectio2", 1);
    pokemonCollections[0].addCarte('xy7-10');
    pokemonCollections[1].addCarte('xy7-10');
    count=2;
    pokemonownership = new PokemonOwenership();
    pokemonownership.mint(msg.sender, 'xy7-10');
  }
  /**
  Create new collection 
  Chaque modification de l'état du contrat (ajout de cartes, modification de propriétés, etc.) nécessite 
  une transaction sur la blockchain, et chaque transaction doit être validée et confirmée par le réseau Ethereum.
   Cela garantit l'intégrité des données et assure que toutes les parties de la blockchain sont synchronisées avec 
   la même version du contrat.
  */
  function createCollection(string memory name) public  onlySuperAdmin() {
    Collection collection = new Collection(name, 10); //10 cards 
    pokemonCollections[count]=collection;
    count++;
  }

  /**
    Add a carte to a collection 
   */
  function add_carte_to_collection(int collection_id, string memory url_carte) public  onlySuperAdmin() {
    //require(pokemonCollections[collection_id].);
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

  function balanceOf_(address _owner) public  view  returns(uint256){
    //return pokemonownership.balanceOf(_owner);
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
