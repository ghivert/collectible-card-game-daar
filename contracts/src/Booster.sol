// SPDX-License-Identifier: MIT
//pragma solidity  >=0.5.0 <0.6.0;
pragma solidity ^0.8.19;

import "./PokemonOwenrship.sol";
import "./Ownable.sol";
import "./Collection.sol";

contract Booster  is Ownable {
    event OpenBooster(address, Pokemon[]);
    Collection  _collection; // Liste des cartes contenues dans le booster
    bool opened; 
    uint256 _number_card= 5; 
    PokemonOwenership pokemonowner = new PokemonOwenership();
    Pokemon []  cardsBooster = new  Pokemon[](_number_card);
    constructor( Collection collection , bool  _opened){
            //setOwner(msg.sender);
            _collection=collection;
            opened=_opened;
    }
    
    /**
    Creation d'un booster
    */
    function createBooster() external {
        require(address(_collection) != address(0), "Collection not set");
        //creation des cartes
        for (uint256 i = 0; i < _number_card; i++) {
            int randomCardId = generateRandomCardId();
            //verifie si la caarte n'existe pas 
            cardsBooster[i] = _collection.getCard(randomCardId);

         }
    }

    function generateRandomCardId() public view returns (int) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % 101;
        return int(randomNumber);
    }
    /**
     Open Booster : retrun the cards contained on booster 
     */

    function openBooster() external returns (Pokemon[] memory) {
        require(opened == false, "Booster has already been opened");
        require(cardsBooster.length > 0, "Booster is empty, create a new one");

        opened = true;
        for (uint256 i = 0; i < cardsBooster.length; i++) {
                Pokemon tokenId = cardsBooster[i];
                pokemonowner.mint(msg.sender, address(tokenId)); // Mint the card NFTs to the user
        }
        emit OpenBooster(msg.sender, cardsBooster);

        return cardsBooster;
    }

   

}