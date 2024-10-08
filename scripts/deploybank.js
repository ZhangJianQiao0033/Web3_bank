const { ethers, network, artifacts } = require("hardhat");

async function main() {
  // await hre.run('compile');
  const Bank = await ethers.getContractFactory("Bank");

  const bank = await Bank.deploy();

  await bank.waitForDeployment();

  console.log("Bank deployed to:", bank.target);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });