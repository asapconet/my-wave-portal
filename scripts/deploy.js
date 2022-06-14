const inDisplay = (args) => console.log(args); //my easy console func

const deployMajor = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();
  // const contractAddy = await deployer.getAddress();

  inDisplay(
    "Your contract is ungoing deployment with address: " + deployer.address
  );
  inDisplay(
    "Currently we have" +
      " " +
      accountBalance.toString() +
      " " +
      "in our purse!"
  );

  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("9999"),
  });
  await waveContract.deployed();

  inDisplay("Contract Address: " + waveContract.address);
};

const runDeployMajor = async () => {
  try {
    await deployMajor();
    process.exit(0); // for exiting node process without error
  } catch (error) {
    inDisplay(error, "something went wrong");
    process.exit(1); // error msg indicating 'Uncaught Fatal Exception'
  }
};

deployMajor();
