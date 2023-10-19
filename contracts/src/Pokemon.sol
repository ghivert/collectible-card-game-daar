// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./erc721.sol";

/////////
abstract contract Pokemon  is ERC721{
  int public id;
  string  public img_url;
    
  constructor(int  _id) {
    id = _id;
    img_url = "";
  }

   function balanceOf(address _owner)  public virtual override   returns (uint256) {
        
  }
  
  function ownerOf(uint256 _tokenId) public virtual  override returns (address) {

  }

  
  function transferFrom(address _from, address _to, uint256 _tokenId) public virtual override payable {

  }

  
  function approve(address _approved, uint256 _tokenId) public virtual  override payable {
    
  }
  
}
