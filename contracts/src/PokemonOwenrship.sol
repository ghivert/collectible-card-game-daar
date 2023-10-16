pragma solidity ^0.8.16;
import "./erc721.sol";

contract PokemonOwenership is ERC721  {

  function balanceOf(address _owner)  public virtual override   returns (uint256) {

  }
  
  function ownerOf(uint256 _tokenId) public virtual  override returns (address) {

  }

  
  function transferFrom(address _from, address _to, uint256 _tokenId) public virtual override payable {

  }

  
  function approve(address _approved, uint256 _tokenId) public virtual  override payable {
    
  }

}
