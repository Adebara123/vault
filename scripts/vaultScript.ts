import { ethers } from "hardhat";

async function main() {

  const Vault = await ethers.getContractFactory("vault");
  const _vault = await Vault.deploy();
  await _vault.deployed();

 
  console.log("My compiled vault", _vault.address);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
}); 
