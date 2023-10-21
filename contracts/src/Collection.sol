// SPDX-License-Identifier: MIT
//pragma solidity  >=0.5.0 <0.6.0;
pragma solidity ^0.8.19;

import "./Ownable.sol";
import "./Pokemon.sol";
import "./erc721.sol";
import "./Ownable.sol";

contract Collection  is  Ownable{ 
  string public name;
  int public cardCount;  //taile de la colection
  int  private counter ;
  mapping(int  => string) public  pokmeons;

  constructor(string memory _name, int _cardCount) {
    name = _name;
    cardCount = _cardCount;
    counter=0;
  }
  function addCarte(string memory url) public {
    pokmeons[counter]=url;
    counter++;
  }

  function getPokemonById(int index) public view returns (string memory) {
    require(index >= 0 && index < cardCount, "Invalid index");
    return pokmeons[index];
}


}



/*

  Main: 
    - Collections
        - Collection1
            - Pokemon1
                - meta_donnee (id_sur_api)
            - Pokemon2
            - Pokemon3
            ...
            - Pokemonn
        - Collection2
        - Coollection3
    - pokemon_ownership: mapping (owner_address => pokemon_adress)



*/