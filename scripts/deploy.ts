import hre, { network } from "hardhat";

const { ethers } = await network.connect();

async function main() {
  console.log("Deploying PollFactory contract...");

  const poll = await ethers.deployContract("PollFactory");
  const contractAddress = await poll.getAddress();

  console.log("PollFactory contract deployed to:", contractAddress);
  
  // Save the contract address for frontend use
  const fs = require("fs");
  fs.writeFileSync(
    "frontend/contract-address.json",
    JSON.stringify({ address: contractAddress }, null, 2)
  );
  console.log("Contract address saved to frontend/contract-address.json");
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
