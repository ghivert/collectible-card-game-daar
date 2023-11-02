// SPDX-License-Identifier: MIT
//pragma solidity  >=0.5.0 <0.6.0;
pragma solidity ^0.8.19;

import "hardhat/console.sol";
import "./Ownable.sol";
import "./ERC721.sol";
import "./Pokemon.sol";

contract Booster  is Ownable{
    uint256 boosterId;
    address[] cardIds; // Liste des cartes contenues dans le booster
    bool opened; 

    constructor(uint256 _boosterId, address[] memory _cardIds,  address _owner , bool  _opened){
            boosterId=_boosterId;
            cardIds=_cardIds;
            opened=_opened;
    }

}