// SPDX-License-Identifier: MIT
//pragma solidity >=0.5.0 <0.6.0;

pragma solidity ^0.8.16;
import "./Collection.sol";
import "./Ownable.sol";
contract Main    {
  address public admin;
  int private count;
  mapping(int => Collection) public collections;

  // Mapping pour lier l'adresse de l'utilisateur à une collection donnée
  mapping(address => address) public userCollection;

  constructor() {
    count = 0;
    admin = msg.sender;
  }

  function createCollection(string memory name, int cardCount)  public{
    // on cree la colleciton
    collections[count++] = new Collection(name, cardCount);
  }

  function create_collection_then_assign_to_user(address user_adress) public     {
    string memory collectionName = "collection name";

    createCollection(collectionName, 0);
    address collection_address = address(collections[count - 1]);
    assign_cardPokemon(user_adress, collection_address);
  }

  function getMessage() public view returns (string memory) {
        return "Hello World";
    }


  /** Assign to a user some collection.
   * 
   */
  function assign_cardPokemon(address user_adress, address collection_adresse)  public{
    userCollection[user_adress]=collection_adresse;
  }

}
