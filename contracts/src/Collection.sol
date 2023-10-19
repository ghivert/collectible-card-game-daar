// SPDX-License-Identifier: MIT
//pragma solidity  >=0.5.0 <0.6.0;
pragma solidity ^0.8.20;

import "./Ownable.sol";
import "./Pokemon.sol";
import "./erc721.sol";
import "./Ownable.sol";

contract Collection  is ERC721, Ownable{ 
  string public name;
  int public cardCount;  

  constructor(string memory _name, int _cardCount) {
    name = _name;
    cardCount = _cardCount;
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



}
