pragma solidity ^0.8.19;

import "./ERC721.sol";
import "./Ownable.sol";

contract PokemonOwenership  is Ownable ,ERC721{   //is erc721
    struct PokemonData {
    string url;
    address userAddress;
}
  mapping(int => PokemonData) pokemon_user;  //pokemon url and user adress
  int size_map ;


  constructor()
  { size_map=0;
  }

   /*
   * @dev reate and assign a new token to a specific address.
   */
 function mint(address receiver, string memory amount) public onlyOwner {
        PokemonData memory newPokemon = PokemonData({
        url: amount,
        userAddress: receiver
    });
    pokemon_user[size_map] = newPokemon;
    size_map++;
  }

  /*
    Returns the number of tokens in owner's account.
  */
  function balanceOf(address _owner)  public virtual  view override   returns (uint256) {   
    uint256  counter =0;
    for (int i=0; i<size_map;i++){
      if (pokemon_user[i].userAddress==_owner){
          counter++;
      }
    }
    return counter;
  }

  /**
  Returns the owner of the tokenId token.
  */
  function ownerOf(string memory _tokenId) public virtual view  override returns (address) {
       for (int i=0; i<size_map;i++){
      if (keccak256(abi.encodePacked(pokemon_user[i].url))== keccak256(abi.encodePacked(_tokenId))){
          return pokemon_user[i].userAddress;
      }
    }
  }

  /**
  Transfers tokenId token from from to to.
  */
  function transferFrom(address _from, address _to, string memory  _tokenId) public  virtual override payable {
      for (int i =0; i<size_map; i++)
      {
        if (keccak256(abi.encodePacked(pokemon_user[i].url))== keccak256(abi.encodePacked(_tokenId))){
          pokemon_user[i].userAddress=_to;
        }
      }
      emit Transfer(_from, _to, _tokenId);  //* ! 
  }
  
  /**
   Returns the account approved for tokenId token.
   */
  function approve(address _approved, uint256 _tokenId) public  override payable {

  }

  /**
   modifier onlyOwnerOf(uint  _token) {
    require(msg.sender == pokemon_user[_token]);
    _;
  }
   */

}
