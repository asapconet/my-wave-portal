// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    mapping(address => uint256[]) waverStore;

    constructor() {
        console.log('heyo, I am a smart contractor...');
    }
    
    function wave() public {
        totalWaves += 1;
        waverStore[msg.sender];

        console.log('%s just dropped sum!', msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log('We have %d total ether donations!', totalWaves);
        return totalWaves;
    }
}