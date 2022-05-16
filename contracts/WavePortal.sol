// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;
    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }
    mapping(address=>uint256) public lastWavedAt;

    Wave[] wavers;

    event NewWave(address indexed from, uint256 timestamp, string message);

    constructor() payable {
        // set the intial seed
        seed = (block.timestamp + block.difficulty) % 100;
        console.log("Yo yo, I am a contract and i am smart");
    }


    function wave(string memory _message) public {

        require((lastWavedAt[msg.sender]+30 seconds) < block.timestamp, "Must wait 30 seconds before waving again.");
        lastWavedAt[msg.sender] = block.timestamp;
        totalWaves += 1;
        wavers.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        seed = (block.timestamp + block.difficulty) % 100; // value range btw 0 - 99
        console.log("Random seed generated: %d", seed);

        if (seed <= 50) {
            console.log("%s won", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getWavers() public view returns (Wave[] memory) {
        console.log("\n Wavers");
        return wavers;
    }
}
