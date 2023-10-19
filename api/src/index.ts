// index.ts
import express from 'express';
import MAIN_ABI from './config/Main_abi';
import Web3 from 'web3';

const provider = new Web3.providers.HttpProvider("http://127.0.0.1:8545/")
const web3 = new Web3(provider);

//const web3 = new Web3('http://127.0.0.1:8545/');

//const web3 = new Web3(new Web3.providers.HttpProvider('http://127.0.0.1:8545/'));

const CONTRACT_ADDRESSS = '0x5fbdb2315678afecb367f032d93f642f64180aa3';
const abi = MAIN_ABI;
const contract = new web3.eth.Contract(abi, CONTRACT_ADDRESSS);

const app = express();
const port = 8000;
app.use(express.json());  



app.get("/", async (req, res) => {
  try {
    const userAddress = '0x70997970C51812dc3A010C7d01b50e0d17dc79C8';
    
    const result = await contract.methods.getMessage().call()    
    
    res.send("Tu attends quoi !!!!");
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erreur lors de l\'appel du contrat' });
  }
});

app.post('/mint', async (req, res) => {
  const { address, tokenId } = req.body;
  res.send(`Minted NFT with tokenId: ${tokenId} to address: ${address}`);
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
