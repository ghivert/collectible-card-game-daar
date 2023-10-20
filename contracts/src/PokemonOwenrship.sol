pragma solidity ^0.8.19;

import "./erc721.sol";
import "./Ownable.sol";

contract PokemonOwenership  is Ownable ,ERC721{   //is erc721


  mapping(address => uint256) user_pokemon;  //collection ou chaque (id  --->  url pokemon dans l'api)
  mapping(uint256 => address) pokemon_user;  //collection ou chaque user a un uint 
  
   /*
   * @dev Internal function to mint a new token
   * Reverts if the given token ID already exists
   * @param to The address that will own the minted token
   * @param tokenId uint256 ID of the token to be minted by the msg.sender
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
      //emit Transfer(_from, _to, _tokenId);
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
  /**
    All cards of user 
   */
   /** 
   function getCards() public returns(uint256 [] memory) external {
    uint256 [] memory cards;
    uint256 counter; 
    for (uint256 i=0; i< 10; i++){
      if(pokemon_user[i]== msg.sender){
       cards[counter]= i;
      }
    }
    return cards;
   }
   */

}
