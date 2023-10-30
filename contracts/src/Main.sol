// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// import "./Collection.sol";

contract Main {
  uint256 balance;
  event Deposited(address addr);

  function Deposit() public payable {
      balance += msg.value;
      emit Deposited(msg.sender);
  }

  function seeBalance() public view returns (uint256) {
      return balance;
  }
}

