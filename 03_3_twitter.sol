// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
    Tasks
    -----

    6. Add tweet to struct
        6.1 Define tweet of struct with author, content, timepstamp, likes
        6.2 Add struct to array
        6.3 Test tweets
*/

/*
    Structs
    -------
    A collection of differnt datatypes.
    e.g.:
    struct Car {
        string model;
        uint256 year;
    }
    Car[] public cars; // Arrays of struct
    Car memory car1 = Car({ model: model, year: year });
    cars.push(car1)
*/

contract Twitter {

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes; 
    }

    mapping(address => Tweet[]) public tweets; // Like a KV pair

    function createTweet(string memory content) public {
        // remember,`memory` keyword tells to save the data in temp memory.
        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: content,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);
    }

    function getTweet(address _owner, uint _i) public view returns (Tweet memory) {
        return tweets[_owner][_i];
    }

    function getAllTweet(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
