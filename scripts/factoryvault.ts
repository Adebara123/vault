import { ethers } from "hardhat";

async function main() {

  const FactoryVault = await ethers.getContractFactory("factoryVault");
  const _factoryVault = await FactoryVault.deploy();
  await _factoryVault.deployed();

 
  console.log("My compiled vault", _factoryVault.address);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
}); 