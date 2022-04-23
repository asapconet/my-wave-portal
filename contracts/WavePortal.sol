// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    //the event that accepts and stores the address and...
    event NewWave(address indexed from, uint256 timestamp, string massage);

    //this is a collection of custumized datatypes for our choise of action
    struct Wave{ 
        address waver; // stores the waver address
        string massage; // stores the massage the waver decides to send
        uint256 timestamp; // stores the time of event
    }

    //this decleration (waves) stores all the values of the struct created(wave)
    Wave[] waves;

    constructor() {
        console.log('heyo, I am a smart contractor...');
    }
    
    // _message in the function is what I use to collect users message from frontEnd
    function wave(string memory _message) public {
        totalWaves += 1;
        console.log('%s waved w/ massage %s', msg.sender, _message);

        // the actual array that stores the collected data
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // now this emit(shows) logs from event only to the user(client)
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    // remember the struct array? this returns the data saved in it and help us in
    // in retriving them from the site
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log('We have %d total ether donations!', totalWaves);
        return totalWaves;
    }
}