// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Hello {

    // Represents ethereum address
    address userAddress = 0x708B00980e2659d40C695f3a9f93432B4315F822;
    
    // a list of character or a text
    string public welcome = "Hello World";

    // bool - true or false
    bool isRead = true;

    // UINT
    // 1. Small number for max supply of NFTs
    uint8 MAX_SUP = 10;
    // What is days?
    uint256 WAIT_TIME = 1 days; // (60*60*24)
}
