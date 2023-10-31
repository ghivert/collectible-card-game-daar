import 'dotenv/config'
import { DeployFunction } from 'hardhat-deploy/types'
import { getAllCards, getAllCollections } from '../services/pokemon.service'
import { ethers } from 'ethers'

/**
 * creation des collections 
 */
const deployer: DeployFunction = async hre => {
  if (hre.network.config.chainId !== 31337) return
  const { deployer } = await hre.getNamedAccounts()
  await hre.deployments.deploy('Main', { from: deployer, log: true })
  const main =await hre.ethers.getContract("Main",deployer)
  getCollectionFromApi().forEach(collection => {
      main.createCollection2(collection.name, collection.code);
  })
       
/**
 * aFIICHAGE DES COLLECTIONS
 */
  let collections : any[] = await main.allCollections();
  /**
   * Rajout des pokemons from api to collections
   */
  setTimeout(async () => {
    //ajout des pokemons dans la blockchain
    const pokemons = getPokemonFromApi();
    
    let insertion = 0
    pokemons.forEach(async pokemon => {
      if (collections.includes(pokemon.set)) {
        const position = collections.indexOf(pokemon.set);
        insertion++;
        await  main.addCardToCollection(position, pokemon.id)
      }
    })
  }, 5000);
  

  /**
   * Mint card to user 
   */
  setTimeout(async () => {
    console.log(" creation de pokemon NFT");
    // retrive the user address
    const userAddress = "0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65";
       
    // retrive all pokemons
    let allPokemons : any[] = [];  
    console.log(collections)
    console.log(collections.length)
    for (let i = 0; i < collections.length; i++) {
      const pokemons = await main.allPokemonsFrom(i);
      //console.log(pokemons)
      allPokemons = allPokemons.concat(pokemons);
    }
  
    console.log(allPokemons);
   
    if (allPokemons.length >= 1) {
        main.mint( userAddress , allPokemons[0]).then(()=>
        main.ownerOf( allPokemons[0]).then(console.log)
      )        
    }
  }, 7000);          
}      

const getCollectionFromApi = () => {
  return getAllCollections()
}   
   
const getPokemonFromApi = () =>{
  return getAllCards()
}


export default deployer
