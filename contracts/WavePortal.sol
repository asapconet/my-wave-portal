// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    // used for generating a random number
    uint256 private seed;

    //the event that accepts and stores the address and...
    event NewWave(address indexed from, uint256 timestamp, string massage);

    //this is a collection of custumized datatypes for our choise of action [endpoints]
    struct Wave{ 
        address waver; // stores the waver address
        string massage; // stores the massage the waver decides to send
        uint256 timestamp; // stores the time of event
    }

    //this decleration (waves) stores all the values of the struct created(wave)
    Wave[] waves;

    //this mapping stores the address and time the last user waved
    mapping(address => uint256) public lastWavedAt;
    

    constructor() payable {
        console.log('We have been contructed!');
        
        // this generates a new seed for the new user that'll wave
        seed = (block.timestamp + block.difficulty) % 100;
    }
    
    // _message in the function is what I use to collect users message from frontEnd
    function wave(string memory _message) public {

        //this is to ensure that the prior timestamp is 10mins less than the current timestam stored
        require(
            lastWavedAt[msg.sender] + 5 minutes < block.timestamp,
            "You will have to wait for 5 minutes"
        );

        //updating the currents timestamp for the user in check
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log('%s just waved', msg.sender);

        // the actual array that stores the collected data
        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        // this is giving a 30% chance that the user wins
        if (seed <= 30) {
            console.log("%s just won!", msg.sender);

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
        );

        }

        // now this emit(shows) logs from event only to the user(client)
        emit NewWave(msg.sender, block.timestamp, _message);


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