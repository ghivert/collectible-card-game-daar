// index.ts
import express from "express";
//const ethereum = require('./lib/ethereum');
import { ethereum } from './lib/ethereum.ts';
const main = require('./lib/main.ts');
//import main from './lib/main';
import { Wallet } from 'ethers'

const app = express();
const port = 8000;
app.use(express.json());

/** handlers */
const useWallet = async () => {
  const details = await ethereum.connect("metamask");
  if (!details) return;

  const contract = await main.init(details);
  if (!contract) return;
  return { details, contract: contract };
}

/** end handlers */

app.get("/", async (req, res) => {
  res.send("Hello World!");
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});