require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();
const PRIVATE_KEY_1 = process.env.PRIVATE_KEY_1

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.27",
  networks:{
    dev:{
      url: "http://127.0.0.1:8545",
      accounts: [PRIVATE_KEY_1],
      chainId: 31337
    }
  }
};
