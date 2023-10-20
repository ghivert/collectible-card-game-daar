// SPDX-License-Identifier: MIT
//pragma solidity  >=0.5.0 <0.6.0;
pragma solidity ^0.8.19;

import "./Ownable.sol";
import "./Pokemon.sol";
import "./erc721.sol";
import "./Ownable.sol";

contract Collection  is ERC721, Ownable{ 
  string public name;
  int public cardCount;  
  mapping(int  => string) public  pokmeons;

  constructor(string memory _name, int _cardCount) {
    name = _name;
    cardCount = _cardCount;
  }
  function addCarte(string memory id) public onlyOwner{
    pokmeons[cardCount]=id;
    cardCount++;
  }

  function getPokemonById(int index) public view returns (string memory) {
    require(index >= 0 && index < cardCount, "Invalid index");
    return pokmeons[index];
}
  
  /*
    Returns the number of tokens in owner's account.
  */
  function balanceOf(address _owner)  public virtual override   returns (uint256) {   
  }

  /**
  Returns the owner of the tokenId token.
  */
  function ownerOf(uint256 _tokenId) public virtual  override returns (address) {
  }

  /**
  Transfers tokenId token from from to to.
  */
  function transferFrom(address _from, address _to, uint256 _tokenId) public virtual override payable {
  }

  /**
   Returns the account approved for tokenId token.
   */
  function approve(address _approved, uint256 _tokenId) public virtual  override payable {
    
  }

  function supportsInterface(bytes4 interfaceId) external view returns (bool){
    
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