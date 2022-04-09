// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;
    address[] wavers;

    constructor(){
        console.log("Yo yo, I am a contract and i am smart");
    }

    function wave() public {
        totalWaves += 1;
        wavers.push(msg.sender);
        console.log("%s has waved", msg.sender);
    }

    function getTotalWaves() public view returns (uint256){
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getWavers() public view returns (address[] memory){
        console.log("\n Wavers");
        return wavers;
    }
}
