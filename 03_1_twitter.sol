// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
    Tasks
    -----

    1. Create a Twitter contract
    2. Create a mapping betwen user and tweet
    3. Add function to create a Tweet and save it in mapping
    4. Creat a function to get Tweet
*/

contract Twitter {

    mapping(address => string) public tweets; // Like a KV pair

    // 'memory' keyword means we need to tell solidity to store this in memory because string takes a lot of space.
    // it tells that store it in memory rather than in function
    /*
    msg.sender is directly comes from blockchain. 
    msg.sender is a built-in global variable that represents the address of the account (either an external account or another smart contract) that is making the current function call or transaction
    
    Immediate Caller: msg.sender always refers to the immediate sender of the current message.
    Dynamic Value: If an external account (like a user's wallet) calls Contract A, and Contract A in turn calls Contract B, then:
        Inside Contract A, msg.sender is the user's wallet address.
        Inside Contract B, msg.sender is the address of Contract A.

    */
    function createTweet(string memory _tweet) public {
        tweets[msg.sender] = _tweet;
    }

    function getTweet(address _owner) public view returns (string memory) {
        return tweets[_owner];
    }
}
