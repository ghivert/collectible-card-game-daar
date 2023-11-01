// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./IERC721.sol";
import "./Ownable.sol";

contract CardContract is Ownable, IERC721 {
  struct Card {
    string id;
    uint256 tokenId;
    address user;
  }
  mapping(uint256 => Card) cardIdToCard; //card id to user adress
  uint256 public mintedCardNumber; // number of cards minted

  constructor() {
    mintedCardNumber = 0;
  }

  function mint(address _to, string memory _cardId) public {
    Card memory card = Card({id: _cardId, user: _to, tokenId:mintedCardNumber});
    cardIdToCard[mintedCardNumber] = card;
    mintedCardNumber++;
  }

  function balanceOf(
    address _owner
  ) public view virtual returns (uint256) {
    uint256 count = 0;
    for (uint256 i = 0; i < mintedCardNumber; i++) {
      if (cardIdToCard[i].user == _owner) {
        count++;
      }
    }
    return count;
  }


  function ownerOf(
    uint256 _tokenId
  ) external view returns (address) {
    for (uint256 i = 0; i < mintedCardNumber; i++) {
      if (
        keccak256(abi.encodePacked(cardIdToCard[i].tokenId)) ==
        keccak256(abi.encodePacked(_tokenId))
      ) {
        return cardIdToCard[i].user;
      }
    }
    return address(0); // if not found
  }
    function ownerOf(
    string memory _cardId
  ) external view returns (address) {
    for (uint256 i = 0; i < mintedCardNumber; i++) {
      if (
        keccak256(abi.encodePacked(cardIdToCard[i].id)) ==
        keccak256(abi.encodePacked(_cardId))
      ) {
        return cardIdToCard[i].user;
      }
    }
    return address(0); // if not found
  }

  function transferFrom(
    address _from,
    address _to,
    uint256 _tokenId
  ) external {
    for (uint256 i = 0; i < mintedCardNumber; i++) {
      if (
        keccak256(abi.encodePacked(cardIdToCard[i].id)) ==
        keccak256(abi.encodePacked(_tokenId))
      ) {
        cardIdToCard[i].user = _to;
      }
    }
    emit Transfer(_from, _to, _tokenId);
  }

function safeTransferFrom(
    address from,
    address to,
    uint256 tokenId
  ) external {}

  function approve(address _to, uint256 _tokenId) public {}

  function userToCards(address _user) public view returns (Card[] memory) {
    // count how many cards are owned by user
    uint256 count = 0;
    for (uint256 i = 0; i < mintedCardNumber; i++) {
      if (cardIdToCard[i].user == _user) {
        count++;
      }
    }
    // create array of cards (using the count to set the size)
    Card[] memory cards = new Card[](uint256(count));
    count = 0;
    for (uint256 i = 0; i < mintedCardNumber; i++) {
      if (cardIdToCard[i].user == _user) {
        cards[count] = cardIdToCard[i];
        count++;
      }
    }
    return cards;
  }

}
