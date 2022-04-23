const inDisplay = (args) => console.log(args); //my easy console func

const major = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();

  inDisplay("This is the contract address:" + waveContract.address);
  // inDisplay("And the contract was deployed by:" + owner.address);

  let waveCount;
  waveCount = await waveContract.getTotalWaves();
  inDisplay(waveCount.toNumber());

  // for sending waves
  let waveTransaction = await waveContract.wave("Message here");
  await waveTransaction.wait(); // while transation is minned

  waveTransaction = await waveContract
    .connect(randomPerson)
    .wave("The next message right here");
  // await waveTransaction.wait([]);  

  let allWaves = await waveContract.getAllWaves();
  inDisplay(allWaves);

  // waveCount = await waveContract.getTotalWaves();
};

const runMajor = async () => {
  try {
    await major();
    process.exit(0); // this is exit node process without error
  } catch (error) {
    inDisplay(error);
    process.exit(1); // to exit node process throwing the error "Uncaught Fatal Exception"
  }
};

runMajor();
