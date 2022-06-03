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
        console.log('%s just waved', msg.sender);

        // the actual array that stores the collected data
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // now this emit(shows) logs from event only to the user(client)
        emit NewWave(msg.sender, block.timestamp, _message);

        // logic for withdrawing funds to be allocated to the waver from our contract
        uint256 prizeAmount = 0.0001 ether;

        // this is like and if and else statements
        require(
            prizeAmount <= address(this).balance, //if
            "The account does not have up the amount requested for withdrawal" //else
        );
        //logic for sending the money provided the first step is passed
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(
            success,//if
            "Failded to withdraw money from contract" // else
        )
    }

    // remember the struct array? this returns the data saved in it and help us in
    // in retriving them from the site
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        //this is to show the value in console as well as test running
        console.log('We have %d total ether donations!', totalWaves);
        return totalWaves;
    }
}