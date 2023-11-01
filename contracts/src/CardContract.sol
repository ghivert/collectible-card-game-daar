// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./ERC721.sol";
import "./Ownable.sol";

contract CardContract is Ownable, ERC721 {
  struct Card {
    uint256 id;
    address user;
  }
  mapping(uint256 => Card) cardToUser; //card id to user adress
  uint256 mintedCardNumber; // number of cards minted

  constructor() {
    mintedCardNumber = 0;
  }

  function mint(address _to, uint256 _cardId) public {
    Card memory card = Card({id: _cardId, user: _to});
    cardToUser[mintedCardNumber] = card;
    mintedCardNumber++;
  }

  function balanceOf(
    address _owner
  ) public view virtual override returns (uint256) {
    uint256 count = 0;
    for (uint256 i = 0; i < mintedCardNumber; i++) {
      if (cardToUser[i].user == _owner) {
        count++;
      }
    }
    return count;
  }


  function ownerOf(
    string memory _tokenId
  ) public view virtual override returns (address) {
    for (uint256 i = 0; i < mintedCardNumber; i++) {
      if (
        keccak256(abi.encodePacked(cardToUser[i].id)) ==
        keccak256(abi.encodePacked(_tokenId))
      ) {
        return cardToUser[i].user;
      }
    }
    return address(0); // if not found
  }

  function transferFrom(
    address _from,
    address _to,
    string memory _tokenId
  ) public payable virtual override {
    for (uint256 i = 0; i < mintedCardNumber; i++) {
      if (
        keccak256(abi.encodePacked(cardToUser[i].id)) ==
        keccak256(abi.encodePacked(_tokenId))
      ) {
        cardToUser[i].user = _to;
      }
    }
    emit Transfer(_from, _to, _tokenId); //* !
  }

  function approve(address _to, uint256 _tokenId) public payable override {}

  function getCardsOfUser(address _user) public view returns (uint256[] memory) {
    // count how many cards are owned by user
    uint256 count = 0;
    for (uint256 i = 0; i < count; i++) {
      if (cardToUser[i].user == _user) {
        count++;
      }
    }
    // create array of cards (using the count to set the size)
    uint256[] memory cards = new uint256[](uint256(count));
    count = 0;
    for (uint256 i = 0; i < count; i++) {
      if (cardToUser[i].user == _user) {
        cards[uint256(count)] = cardToUser[i].id;
        count++;
      }
    }
    return cards;
  }

}
