import 'dotenv/config'
import { DeployFunction } from 'hardhat-deploy/types'
import { getAllCards, getAllCollections } from '../services/pokemon.service'
import { ethers } from 'ethers'

const deployer: DeployFunction = async hre => {
  if (hre.network.config.chainId !== 31337) return
  const { deployer } = await hre.getNamedAccounts()
  await hre.deployments.deploy('Main', { from: deployer, log: true })
  const main =await hre.ethers.getContract("Main",deployer)
  getCollectionFromApi().forEach(collection => {
      main.createCollection2(collection.name, collection.code);
  })

  let collections : any[];
  setTimeout(async () => {
    console.log("debut collecttion");
    collections = await main.allCollections();
    console.log("fin collecttion");
    console.log(collections);
  }, 3000);
  setTimeout(() => {
    //ajout des pokemons dans la blockchain
    console.log("insertion des cartes");
    getPokemonFromApi().forEach(pokemon => {
      if (collections.includes(pokemon.set)) {
        const position = collections.indexOf(pokemon.set);
        main.add_carte_to_collection(position, pokemon.id)
      }
    })
  }, 5000);
  

  setTimeout(() => {
      console.log("affichage cartes de la collection 3");
      main.allPokemonsOfCollection(3).then(console.log)
  }, 7000);

  setTimeout(async () => {
    console.log(" creation de pokemon NFT");
    main.createPokemon2("cart1").then(()=>{
      main.allCollections().then(console.log)
    })
  
     main.mint(main.address, "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266" ).then(()=>{
         main.balanceOf(main.address).then(console.log)
     })
    
    console.log("balance  après le mint");
}, 10000);
}

const getCollectionFromApi = () => {
  return getAllCollections()
}

const getPokemonFromApi = () =>{
  return getAllCards()
}


export default deployer
