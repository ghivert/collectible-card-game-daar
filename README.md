# Collectible Card Game

Welcome to the DAAR project. The idea will be to implement a Collectible Card Game
in a decentralized way, on Ethereum. This will force you to iterate through the creation
of CCG cards as NFT, create a marketplace for players to exchange NFT, and run a frontend to create collections.

[First slideshow](https://www.figma.com/file/MbBKLKATrPIRNDPfY23uwW/Blockchain-%26-Smart-Contracts?type=design&node-id=0%3A1&mode=design&t=FvBuqccvh9fpfW1o-1) [Second slideshow](https://www.figma.com/file/MbBKLKATrPIRNDPfY23uwW/Blockchain-%26-Smart-Contracts?type=design&node-id=184%3A368&mode=design&t=krkx1v8TmtDCpSTl-1)

# Installation

```bash
# With HTTPS
git clone https://github.com/ghivert/collectible-card-game-daar.git
# Or with SSH
git clone git@github.com:ghivert/collectible-card-game-daar.git
```

You’ll need to install dependencies. You’ll need [`HardHat`](https://hardhat.org/), [`Node.js`](https://nodejs.org/en/), [`NPM`](https://www.npmjs.com/) and [`Yarn`](https://yarnpkg.com/). You’ll need to install [`Metamask`](https://metamask.io/) as well to communicate with your blockchain.

- `HardHat` is a local blockchain development, to iterate quickly and avoiding wasting Ether during development. Fortunately, you have nothing to do to install it.
- `Node.js` is used to build the frontend and running `truffle`, which is a utility to deploy contracts.
- `NPM` or `Yarn` is a package manager, to install dependencies for your frontend development. Yarn is recommended.
- `Metamask` is a in-browser utility to interact with decentralized applications.

# Some setup

Once everything is installed, launch the project (with `yarn dev`). You should have a local blockchain running in local. Open Metamask, setup it, and add an account from the Private Keys HardHat displays.
Now you can connect Metamask to the blockchain. To do this, add a network by clicking on `Ethereum Mainnet` and `personalized RPC`. Here, you should be able to add a network.

![Ganache Config](public/ganache-config.png)

Once you have done it, you’re connected to the HardHat blockchain!

# Installation

Install the dependencies.

```bash
# Yarn users
yarn
```

Run the complete project.

```bash
# Yarn users
yarn dev
```

You’re good to go!

---

# Subject

TCG, or Trading Card Game, sometimes called CCG, for Collectible Card Game, are a type of game in which you're opening randomized packs of cards, called boosters, and you're building your pack of cards, called decks, to play against other players. This is a popular format nowadays, both physically or digitally. The most famous of them are [Magic, The Gathering](https://en.wikipedia.org/wiki/Magic:_The_Gathering_Arena), [Pokémon TCG](https://en.wikipedia.org/wiki/Pok%C3%A9mon_Trading_Card_Game), [Yu-Gi-Oh!](https://en.wikipedia.org/wiki/Yu-Gi-Oh!_Trading_Card_Game), [Hearthstone](https://en.wikipedia.org/wiki/Hearthstone), [Marvel Snap](https://en.wikipedia.org/wiki/Marvel_Snap), or even [Legends of Runeterra](https://en.wikipedia.org/wiki/Legends_of_Runeterra). You probably heard about at least one, maybe played with some of them.
The subject of this project will be to put yourself at the place of a TCG creator, and to create a TCG on the Ethereum and other EVM-compatible blockchains. To fulfill this goal, you'll need to understand the different parts of the game, from the onchain part (hosted on the blockchain) to the offchain parts (the frontend and the backend) of the game. While you could go to the end and build a complete, working TCG, you'll not be asked to build a game engine. This would take more than a bunch of weeks, and it's not the scope of the project. The project will be focused on building the _collectible_ part of the project. In other words, you'll build the way to collect digital cards, make them possible to exchange with some friends, browse the cards on your web browser, and order your collection as you want.
In a real TCG, a new set of cards is published approximately every 3 to 4 months. You work will be to build a complete infrastructure able to manage a new collection of cards on a regular basis.

More specifications: the cards will be represented as NFT, or Non-Fungible Tokens. It's the best way to represent collectibles on a blockchain. For this, you'll implement the ERC-721 norm, and you'll build the different frontends and backends on your own. The project is here to help you kickstart the infrastructure.

## Expectations

You'll send:

- The code you wrote as a monorepo. Contracts, frontend and backend should be in the same GitHub repo. Your repository should be send by email.
- A report of what you've done. This report should be comprised of 5 to 8 pages approximately, and should not contain any code, except in case of extreme necessity (i.e. a pseudo-code algorithm for example). You can – if you need to talk about the code – make a link pointing to the correct file or code block on the GitHub repo. Every extract of code not necessary will be a subject of a penalty.
- A short video demo of what you've done. You should be able to create a small video of up to 3 minutes displaying the different features working on your computer.

# Implementations

Let's jump into the code.

## First onchain part

> Create the NFT contract.

1. First, implement a contract able to create some Collections, or Sets. Each collection, or set, is made of a name, a card count (the number of cards in the set), and is a set of NFT. A NFT is a token implementing the standard ERC-721. Each card will be an NFT from a specific collection. In a first time, you will implement only the card number and an img field in a first time in the metadata of the NFT.
Everytime we want to create a new set of cards, we create the collection with a name, and a card count, by calling a function to the Main contract. The Main contract is a way to retrieve all informations from the different sets.
2. The Main contract will have an owner (i.e. a super-admin), which will be able to mint and assign cards to a selected user in a selected collection.
3. The owner will be able to mint and assign an arbitrary amount of cards to a user from a specified collection.

## First offchain part

> Create the frontend to interact with the contract.

1. Create an API able to give informations about an NFT. Simply returns a JSON containing a card name and an illustration (which can be empty). You'll have to create a webserver (you can use Express.js or anything else you want).
2. Create a frontend to visualize all the cards (i.e. NFT) owned by the user. Keep in mind:
  - A user will have some NFT after the owner mint some for him.
  - A user will be able to see its NFT by connecting to the frontend.
    - The user will retrieve all NFT he possess from the chain.
    - The user will then retrieve all metadata of the NFT from the API.
3. Create a frontend and an API (if needed) in order to visualize, for each set, all users and their possessions. You'll maybe have to use events and parse the transactions offchain on an API to retrieve all those information.

## Integration of Pokémon TCG

> Now, it's time to integrate real cards, with real illustrations !

1. Integrate [Pokémon TCG API](https://pokemontcg.io/).
  - Choose which sets you want to integrate, and add them to the Main contract.
  - For each of those sets, you'll have to find the correct card count.
  - Modify the API to return the information of the Pokémon card corresponding to the NFT.

## Add more features

> Now we'll create some boosters to redeem!

1. To create a booster, create a booster offline on your API, and find a way to redeem it onchain, on the contract. The booster must have some cards in it, and it should have the exact same cards when redeemed. The booster should be an NFT.

## To go beyond

> Implement at least one feature.

- Improve the frontend, by adding a way to manage collection, like a binder.
- Improve the contract, to be able to manage a multichain codebase, with a bridge between chains.
- Add a game engine for the cards, like fighting with your Pokémon and some energy cards.
- Implement a marketplace to exchange cards between users.
- Implement a tournament game some promos cards for winners.
