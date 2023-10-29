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
  let collections : any[];
  setTimeout(async () => {
    console.log("debut collecttion");
    collections = await main.allCollections();
    console.log(collections);
  }, 3000);

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
        console.log(`ajout de ${pokemon.id} dans la collection ${pokemon.set}`);
        
        insertion++;
        await  main.addCardToCollection(position, pokemon.id)
      }
    })
    console.log(`insertion de ${insertion} cartes`);
  }, 5000);
  
  /**
   * Affichage des pokemon de la collection 3
  */
  setTimeout( () => {
    console.log("affichage cartes de la collection 3");
    main.allPokemonsOfCollection(3).then(console.log)
  }, 7000);

  /**
   * Mint card to user 
   */
  setTimeout(async () => {
    console.log(" creation de pokemon NFT");
    const userAddress = "0x70997970C51812dc3A010C7d01b50e0d17dc79C8";
    // retrive the user address
    const my_new_pokemon = await main.createPokemon2("cart1");
    console.log("adresse du pokemon: " + my_new_pokemon);
    
    const transactionHash = my_new_pokemon.hash;
    const transactionReceipt = await hre.ethers.provider.getTransactionReceipt(transactionHash);
    const nftAddress = transactionReceipt.logs[0].address;
    main.mint(userAddress, nftAddress).then(()=>{
      // Afichage du nombre de cartes de l'utilisateur
      console.log("nombre de cartes de l'utilisateur");
      main.balanceOf(userAddress).then(result => {
        let count = result;
        if (result instanceof ethers.BigNumber) {
          count = result.toNumber();
        }
        console.log(count);
      });

    })
  }, 10000);
}




const getCollectionFromApi = () => {
  return getAllCollections()
}

const getPokemonFromApi = () =>{
  return getAllCards()
}


export default deployer
