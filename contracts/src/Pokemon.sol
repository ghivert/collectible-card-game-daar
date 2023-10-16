// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;


contract Pokemon {
  int public id;
  string  img_url;

  constructor(int  _id) {
    id = _id;
    img_url = "";
  }
}
