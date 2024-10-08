
const { ethers, network, artifacts } = require("hardhat");


async function main() {
  let bank = await ethers.getContractAt("Bank",
    "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707");

    let tx = await bank.withdraw();
    await tx.wait();

    console.log("withdrawed")

}

main();