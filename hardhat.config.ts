import * as dotenv from 'dotenv'
dotenv.config()

import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-ethers";
import 'hardhat-deploy'
import 'hardhat-deploy-ethers'

const RPCS = {
  mumbai: process.env.MUMBAI_ALCHEMY_API!
}

const wallets = [
  process.env.PK!
]

const config: HardhatUserConfig = {
  solidity: "0.8.21",
  networks: {
    mumbai: {
      forking: {
        url: RPCS.mumbai,
      },
      url: RPCS.mumbai,
      accounts: wallets,
    },
    // polygon: {
    //   forking: {
    //     url: `https://polygon-mainnet.g.alchemy.com/v2/${POLYGON_ALCHEMY_API}`,
    //   },
    //   url: `https://polygon-mainnet.g.alchemy.com/v2/${POLYGON_ALCHEMY_API}`,
    //   accounts: envAccounts,
    // },
  }
};

export default config;
