const main = async () => {
    // here I grabbed the wallet address of contract owner and I also grabbed a random wallet address and called it randomPerson
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave('A message');
    await waveTxn.wait();


    waveCount = await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).wave("Another message");
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves();

    wavers = await waveContract.getWavers();

    console.log("Wavers List:", wavers);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();