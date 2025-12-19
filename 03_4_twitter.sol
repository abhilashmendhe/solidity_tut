// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
    Tasks
    -----

    7. Use require to limit the lenght of the tweet by only 280 characters 
*/

/*
    Require
    -------
    The require() statement in Solidity is a crucial error-handling function used to validate inputs and conditions before executing a function. If
*/

contract Twitter {

    uint256 constant MX_TWEET_LEN = 280;

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes; 
    }

    mapping(address => Tweet[]) public tweets; // Like a KV pair

    function createTweet(string memory content) public {

        require(bytes(content).length <= MX_TWEET_LEN, "Tweet content length should be less than 280 characters");

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
