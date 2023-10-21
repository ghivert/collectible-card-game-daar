// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./erc721.sol";

/////////
abstract contract Pokemon  {
  int public id;
  string  public img_url;
    
  constructor(int  _id) {
    id = _id;
    img_url = "";
  }

 
  
}
