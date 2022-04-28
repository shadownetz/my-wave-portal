const main = async () => {
    // here I grabbed the wallet address of contract owner and I also grabbed a random wallet address and called it randomPerson
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    });
    await waveContract.deployed();

    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);

    let waveCount;

    // first wave
    let waveTxn = await waveContract.wave('A message');
    await waveTxn.wait();

    /*
    * Get Contract balance
    */
    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract balance:",hre.ethers.utils.formatEther(contractBalance));

    // second wave
    waveTxn = await waveContract.connect(randomPerson).wave("Another message");
    await waveTxn.wait();


    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract balance:",hre.ethers.utils.formatEther(contractBalance));



    waveCount = await waveContract.getTotalWaves();
    wavers = await waveContract.getWavers();

    console.log("No of wavers:", waveCount);
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