// index.ts
import express from 'express';
import Web3 from 'web3';
import MAIN_ABI from './config/Main_abi';
const web3 = new Web3('https://ropsten.infura.io/v3/your_infura_project_id');
const CONTRACT_ADDRESSS = '0x5fbdb2315678afecb367f032d93f642f64180aa3';
const abi = MAIN_ABI;
const contract = new web3.eth.Contract(abi, CONTRACT_ADDRESSS);

const app = express();
const port = 8000;
app.use(express.json());


app.get("/", async (req, res) => {
  try {
    const user_adress = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";
    const contractData = await contract.methods.create_collection_then_assign_to_user().call();
    res.json({ data: contractData });
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de l\'appel du contrat' });
  }
  res.send("Hello world");
});


app.post('/mint', async (req, res) => {
  const { address, tokenId } = req.body;
  res.send(`Minted NFT with tokenId: ${tokenId} to address: ${address}`);
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
