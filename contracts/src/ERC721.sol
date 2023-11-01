//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
  
interface ERC721 {
  event Transfer(address indexed _from, address indexed _to, string _tokenId);

  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

  function balanceOf(address _owner) external returns (uint256);

  function ownerOf(string memory _tokenId) external returns (address);

  function transferFrom(
    address _from,
    address _to,
    string memory _tokenId
  ) external payable;

  function approve(address _to, uint256 _tokenId) external payable;
}