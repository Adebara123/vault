import { ethers } from "hardhat";

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const time = currentTimestampInSeconds + 10;

  //const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;

  let [acc1, acc2, acc3] = await ethers.getSigners();

  const Vault = await ethers.getContractFactory("vault");
  const _vault = await Vault.deploy();
  await _vault.deployed();

 
  //@ts-ignore
  const amount = ethers.utils.parseEther("1");
  
    const res = await _vault.connect(acc2).createGrant(acc2.address,time, {value: amount});
   const data = await (await res.wait());
  console.log("value", amount);
  
  console.log("My compiled vault", _vault.address);
  console.log("my response", res);
  console.log("my data", data);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
}); 
