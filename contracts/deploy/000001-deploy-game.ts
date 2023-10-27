import 'dotenv/config'
import { DeployFunction } from 'hardhat-deploy/types'
import { getAllCollections } from '../services/pokemon.service'

const deployer: DeployFunction = async hre => {
  if (hre.network.config.chainId !== 31337) return
  const { deployer } = await hre.getNamedAccounts()
  await hre.deployments.deploy('Main', { from: deployer, log: true })
  const main =await hre.ethers.getContract("Main",deployer)
 getCollectionFromApi().forEach(collection => {
    main.createCollection2(collection.name, collection.code);
 })

 setTimeout(() => {
  main.allCollections().then(console.log)
 }, 3000);

 main.allCollections().then(console.log)
}

const getCollectionFromApi = () => {
  return getAllCollections()
}


export default deployer
