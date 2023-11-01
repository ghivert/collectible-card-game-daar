pragma solidity ^0.8.19;

import "./Ownable.sol";


contract Pokemon is Ownable{
  string public id;
  
  constructor(string memory  _id){
    id = _id;
  }

  function getId() public view  returns (string memory){
    return id;
    //return "I am a pokemon";
  }

}