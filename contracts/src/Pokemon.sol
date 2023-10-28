pragma solidity ^0.8.19;

import "./ERC721.sol";
import "./Ownable.sol";


contract Pokemon is ERC721, Ownable{
  string  private url; 
  
  constructor(string memory  _url){
    url= _url;
  }


  function getUrl() public view  returns (string memory){
    return url;
  }

  function balanceOf(address _owner) public virtual override returns (uint256){

  }

  function ownerOf(string memory _tokenId) public virtual override returns (address){

  }

  function transferFrom(address _from, address _to,string memory _tokenId ) public payable override virtual{
  }

  function approve(address _approved, uint256 _tokenId) public override payable virtual{

  }
}