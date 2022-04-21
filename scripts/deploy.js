const inDisplay = (args) => console.log(args); //my easy console func

const deployMajor = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

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

  const donationContractFactory = await hre.ethers.getContractFactory(
    "WavePortal"
  );
  const donatetionContract = await donationContractFactory.deploy();
  await donatetionContract.deployed();
};

const runDeployMajor = async () => {
  try {
    await deployMajor();
    process.exit(0); // for exiting node process without error
  } catch (error) {
    inDisplay(error);
    process.exit(1); // error msg indicating 'Uncaught Fatal Exception'
  }
};

deployMajor();
