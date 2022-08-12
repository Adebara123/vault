import "@nomiclabs/hardhat-ethers";
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

const ALCHEMY_GOERLI_API_KEY_URL = process.env.ALCHEMY_GOERLI;

const ACCOUNT_PRIVATE_KEY = process.env.PRIVATE_KEY;

const API_TOKEN = process.env.API_TOKEN;

type HttpNetworkAccountsUserConfig = any;

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  networks: {
    goerli: {
      url: ALCHEMY_GOERLI_API_KEY_URL,
      accounts: [process.env.PRIVATE_KEY] as HttpNetworkAccountsUserConfig | undefined,
    }
  },
  etherscan: {
    apiKey: API_TOKEN
  }
};

export default config;