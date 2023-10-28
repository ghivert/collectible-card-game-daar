pragma solidity ^0.8.19;

import "./ERC721.sol";
import "./Ownable.sol";
import "./Pokemon.sol";

contract PokemonOwenership is  Ownable,ERC721
{
  struct PokemonData_user {
    Pokemon url;  
    address userAddress;
  }
  mapping(int => PokemonData_user) pokemon_user; //pokemon url and user adress
  int size_map;

  constructor() {
    size_map = 0;
  }

  /*
   * @dev reate and assign a new token to a specific address.
     OnlyOwner
   */
  function mint(address receiver, Pokemon  amount) public {
    PokemonData_user memory newPokemon = PokemonData_user({
      url: amount,
      userAddress: receiver
    });
    pokemon_user[size_map] = newPokemon;
    size_map++;
  }

  /*
    Returns the number of tokens in owner's account.
  */
  function balanceOf(
    address _owner
  ) public view virtual override returns (uint256) {
    uint256 counter = 0;
    for (int i = 0; i < size_map; i++) {
      if (pokemon_user[i].userAddress == _owner) {
        counter++;
      }
    }
    return counter;
  }

  /**
  Returns the owner of the tokenId token.
  */
  function ownerOf(string memory _tokenId) public view virtual override returns (address) {
    for (int i = 0; i < size_map; i++) {
      if (
        keccak256(abi.encodePacked(pokemon_user[i].url)) ==
        keccak256(abi.encodePacked(_tokenId))
      ) {
        return pokemon_user[i].userAddress;
      }
    }
  }

  /**
  Transfers tokenId token from from to to.
  */
  function transferFrom(
    address _from,
    address _to,
    string memory _tokenId
  ) public payable virtual override {
    for (int i = 0; i < size_map; i++) {
      if (
        keccak256(abi.encodePacked(pokemon_user[i].url)) ==
        keccak256(abi.encodePacked(_tokenId))
      ) {
        pokemon_user[i].userAddress = _to;
      }
    }
    emit Transfer(_from, _to, _tokenId); //* !
  }

  /**
   Returns the account approved for tokenId token.
   */
  function approve(
    address _approved,
    uint256 _tokenId
  ) public payable override {}

  /**
  Returns all cards of user 
  */

  function AllCardsUser(address owner) public view returns  (string [] memory){
    int counter =0;
    for (int i = 0; i<size_map; i++){
      if (pokemon_user[i].userAddress==owner){
        counter++;
      }
    }
    string [] memory allcards = new  string[](uint256(counter));
    counter=0;
    for (int i = 0; i<size_map; i++){
      if (pokemon_user[i].userAddress==owner){
          allcards[uint256(counter)]=pokemon_user[i].url.getUrl();
          counter++;
      }
    }
    return allcards;
  }


  /**
   modifier onlyOwnerOf(uint  _token) {
    require(msg.sender == pokemon_user[_token]);
    _;
  }
   */
}
