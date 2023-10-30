pragma solidity ^0.8.19;

import "./ERC721.sol";
import "./Ownable.sol";
import "./Pokemon.sol";
import "./Collection.sol";

contract PokemonOwenership is Ownable, ERC721 {
  mapping(int => Collection) public pokemonCollections;
  int public collectionCount;

  constructor() {}

  /*
   * @dev reate and assign a new token to a specific address.
     OnlyOwner
   */
  function mint(address receiver, address pokemonAdress) public {
    for (int i = 0; i < collectionCount; i++) {
      if (pokemonCollections[i].mintAux(receiver, pokemonAdress)) {
        break;
      }
    }
  }

  /*
    Returns the number of tokens in owner's account.
  */
  function balanceOf(
    address _ownerOf
  ) public view virtual override returns (int) {
    int count = 0;
    for (int i = 0; i < collectionCount; i++) {
      count = pokemonCollections[i].balanceOf(_ownerOf) + count;
    }
    return count;
  }

  /**
  Returns the owner of the tokenId token.
  */
  function ownerOf(
    address _tokenId
  ) public view virtual override returns (address) {
    for (int i = 0; i < collectionCount; i++) {
      address owner = pokemonCollections[i].ownerOf(_tokenId);
      if (owner != address(0)) {
        return owner;
      }
    }
    return address(0);
  }

  /**
  Transfers tokenId token from from to _to.
  */
  function transferFrom(
    address _from,
    address _to,
    address _tokenId
  ) public payable virtual override {
    /*
    for (int i = 0; i < collectionCount; i++) {
      if (keccak256(abi.encodePacked(pokemonCollections[i].owner())) == _tokenId) {
        pokemonCollections[i].userAddress = _to;
      }
    }
    emit Transfer(_from, _to, _tokenId); //* !
    */
  }

  /**
   Returns the account approved for tokenId token.
   */
  function approve(
    address _approved,
    uint256 _tokenId
  ) public payable override {}
}
