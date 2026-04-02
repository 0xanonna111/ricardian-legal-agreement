const hre = require("hardhat");

async function main() {
  const [partyA, partyB] = await hre.ethers.getSigners();
  
  // Hash of the legal PDF/Markdown file
  const docHash = hre.ethers.id("LEGAL_AGREEMENT_V1_PROSE");
  const uri = "ipfs://QmLegalDocURI";

  const Ricardian = await hre.ethers.getContractFactory("RicardianContract");
  const contract = await Ricardian.deploy(docHash, uri, [partyA.address, partyB.address]);

  await contract.waitForDeployment();
  console.log("Ricardian Contract deployed to:", await contract.getAddress());
  console.log("Legal Hash locked in contract state.");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
