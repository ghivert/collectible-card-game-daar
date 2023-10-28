import 'dotenv/config'
import { DeployFunction } from 'hardhat-deploy/types'
import { getAllCards, getAllCollections } from '../services/pokemon.service'

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
      console.log("affichage cartes");
      main.allPokemonsOfCollection(3).then(console.log)
  }, 7000);

  setTimeout(() => {
    console.log("ajoute une carte a un utilisateur cartes"+main.address);
    main.mint_(main.address, "base3-5")
    main.AllCardsUser_(main.address).then(console.log)
}, 7000);
}

const getCollectionFromApi = () => {
  return getAllCollections()
}

const getPokemonFromApi = () =>{
  return getAllCards()
}


export default deployer
