// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import 'hardhat/console.sol';
import './Ship.sol';

contract MyShip is Ship {
  uint private _x;
  uint private _y;

  function update(uint x, uint y) public override {
    _x = x;
    _y = y;
  }

  function fire() public view override returns (uint, uint) {
    return (_x, _y);
  }

  function place(uint width, uint height) public
    override view returns (uint, uint) {
      uint value = block.timestamp % (width * height);
      uint x = value % width;
      uint y = value / height;
      return (x, y);
  }
}
