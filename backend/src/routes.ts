import { Router } from 'express';
import contracts from './contracts.json'

export const index = Router();

index.get('/', (req, res) => {
  // let mainContractAbi = contracts.contracts.Main.abi
  let contractAddress = contracts.contracts.Main.address
  

  return res.json({ message: 'Success', contractAddress: contractAddress});
});
