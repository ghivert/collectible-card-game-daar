pragma solidity ^0.8.19;

import "./Ownable.sol";


contract Pokemon is Ownable{
  string  private id;
  
  constructor(string memory  _id){
    id = _id;
  }

  function getId() public view  returns (string memory){
    return id;
  }

}