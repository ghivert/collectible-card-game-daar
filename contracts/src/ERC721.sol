//SPDX-License-Identifier
pragma solidity ^0.8.19;

//import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

abstract contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, string _tokenId);

  function balanceOf(address _owner)   external virtual returns (int );

  function ownerOf(address _tokenId) public virtual returns (address);

  function transferFrom(
    address _from,
    address _to,
    address _tokenId
  ) public payable virtual;

  function approve(address _approved, uint256 _tokenId) public payable virtual;
}
