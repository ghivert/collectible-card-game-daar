pragma solidity ^0.8.20;

import "./erc721.sol";
import "./Ownable.sol";

contract PokemonOwenership is ERC721, Ownable {

  mapping(address => uint256) user_pokemon;  //collection ou chaque (id  --->  url pokemon dans l'api)
  mapping(uint256 => address) pokemon_user;  //collection ou chaque user a un uint 
  
  /**
  Can only be called by the contract creator
  */ 
  function mint(address receiver, uint256 amount) public onlyOwner {
        user_pokemon[receiver] += amount;
    }

  /*
    Returns the number of tokens in owner's account.
  */
  function balanceOf(address _owner)  public virtual override   returns (uint256) {   
     return  user_pokemon[_owner];
  }

  /**
  Returns the owner of the tokenId token.
  */
  function ownerOf(uint256 _tokenId) public virtual  override returns (address) {
       return pokemon_user[_tokenId];
  }

  /**
  Transfers tokenId token from from to to.
  */
  function transferFrom(address _from, address _to, uint256 _tokenId) public onlyOwner virtual override payable {
      user_pokemon[_to] +=1;
      user_pokemon[_from ] -=1;
      pokemon_user[_tokenId] = _to;
      emit Transfer(_from, _to, _tokenId);
  }

  /**
   Returns the account approved for tokenId token.
   */
  function approve(address _approved, uint256 _tokenId) public virtual  override payable {
    
  }

   function supportsInterface(bytes4 interfaceId) external view returns (bool){
    
  }

  modifier onlyOwnerOf(uint  _token) {
    require(msg.sender == pokemon_user[_token]);
    _;
  }


}
