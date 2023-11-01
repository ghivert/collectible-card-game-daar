//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


abstract contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, string _tokenId);

  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

  function balanceOf(address _owner) public virtual returns (uint256);

  function ownerOf(string memory _tokenId) public virtual returns (address);

  function transferFrom(
    address _from,
    address _to,
    string memory _tokenId
  ) public payable virtual;

  function approve(address _to, uint256 _tokenId) public payable virtual;
}