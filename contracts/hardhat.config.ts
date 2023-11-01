import 'dotenv/config'
import 'hardhat-deploy'
import { HardhatUserConfig } from 'hardhat/config'
import '@nomiclabs/hardhat-ethers'
import '@nomiclabs/hardhat-waffle'
import '@typechain/hardhat'
import 'hardhat-gas-reporter'
import 'hardhat-abi-exporter'

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
const config: HardhatUserConfig = {
  solidity: '0.8.19',
  networks: {
    hardhat: {
      initialBaseFeePerGas: 0,
      gas: 3000000,
      chainId: 1337,
    },
  },
  paths: {
    deploy: './deploy',
    sources: './src',
  },
  namedAccounts: {
    deployer: { default: 1 },
    admin: { default: 0 },
    second: { default: 1 },
    random: { default: 8 },
  },
  abiExporter: {
    runOnCompile: true,
    path: '../frontend/src/abis',
    clear: true,
    flat: true,
    only: [],
    pretty: true,
  },
  typechain: {
    outDir: '../typechain',
  },
}

export default config