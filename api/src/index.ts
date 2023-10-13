// index.ts
import express from 'express';
const app = express();
const port = 8000;

app.use(express.json());

app.post('/mint', async (req, res) => {
    const { address, tokenId } = req.body;

    // Call the mint function on the smart contract using ethers.js
    // Example code: (Assuming you've deployed the contract and have an ethers provider)
    // const contract = new ethers.Contract(contractAddress, abi, signer);
    // await contract.mint(address, tokenId);

    res.send(`Minted NFT with tokenId: ${tokenId} to address: ${address}`);
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
