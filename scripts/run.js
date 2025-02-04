const inDisplay = (args, param) => console.log(args, param); //my easy console func

const major = async () => {
  // const [_, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("9999"),
  });

  await waveContract.deployed();
  inDisplay("This is the contract address:", waveContract.address);
  // inDisplay("And the contract was deployed by:" + owner.address);

  //Checking wallet balance
  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  inDisplay("Contract balance:", hre.ethers.utils.formatEther(contractBalance));

  // let waveCount;
  // waveCount = await waveContract.getTotalWaves();
  // inDisplay(waveCount.toNumber());

  // for sending waves
  let waveTransaction = await waveContract.wave("First waver");
  await waveTransaction.wait(); // while transation is minned

  // let waveTransaction2 = await waveContract.wave("Second waver");
  // await waveTransaction2.wait();

  //getting current balance contract to be sure a trans was held or not
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  inDisplay(
    "Available Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );
  
  // waveTransaction = await waveContract
  //   .connect(randomPerson)
  //   .wave("The next message right here");
  // await waveTransaction.wait();

  let allWaves = await waveContract.getAllWaves();
  inDisplay(allWaves, "");

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
