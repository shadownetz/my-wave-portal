// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;

    event NewWave(address indexed from, uint256 timestamp, string message);

    constructor(){
        console.log("Yo yo, I am a contract and i am smart");
    }

    struct Wave{
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] wavers;


    function wave(string memory _message) public {
        totalWaves += 1;
        wavers.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);
        console.log("%s has waved", msg.sender);
    }

    function getTotalWaves() public view returns (uint256){
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getWavers() public view returns (Wave[] memory){
        console.log("\n Wavers");
        return wavers;
    }
}
