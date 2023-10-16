// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import "./Ownable.sol";

contract Pokemon is Ownable {
  int public id;
  string  public img_url;

  constructor(int  _id) {
    id = _id;
    img_url = "";
  }
}
