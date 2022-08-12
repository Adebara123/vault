import "@nomiclabs/hardhat-ethers";
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

//const ALCHEMY_GOERLI_API_KEY_URL = process.env.ALCHEMY_GOERLI;

const ACCOUNT_PRIVATE_KEY = process.env.PRIVATE_KEY;

const API_TOKEN = process.env.API_TOKEN;

type HttpNetworkAccountsUserConfig = any;

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  networks: {
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/iWVVGEdMfq5za6NeV_U0W86woka0EQow",
      accounts: ["70d4ac3ce7aafaf48917d2d272680bfc73865fd87265f46bd074299e95e7db2c"],
    }
  },
  etherscan: {
    apiKey: API_TOKEN
  }
};

export default config;