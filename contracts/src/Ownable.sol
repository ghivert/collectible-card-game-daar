pragma solidity ^0.8.19;

import "./ERC721.sol";

contract Ownable {
  address private _owner;
  
  constructor() {
    _owner = address(0);
    emit OwnershipTransferred(address(0), _owner);
  }

  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );

  function owner() public view returns (address) {
    return _owner;
  }

  function hasOwner() public view returns (bool) {
    return _owner != address(0);
  }

  function setOwner(address _newOwner) external   {
    _owner = _newOwner;
  }

  modifier onlyOwner() {
    require(isOwner());
    _;
  }

  function isOwner() public view returns (bool) {
    return msg.sender == _owner;
  }

  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }

  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0));
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}