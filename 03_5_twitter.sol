// SPDX-License-Identifier: GPL-3.0
import "@openzeppelin/contracts/utils/Strings.sol";
pragma solidity >=0.8.2 <0.9.0;

/*
    Tasks
    -----
    8. Work with modifiers 

        8.1 Add a func called changeTweetLength to change max tweet length; HINT: use newTweetLength as input for function
        8.2 Create a constructor function to set an owner of contract
        8.3 Create a modifer called onlyOwner
        8.4 Use only owner on changeTweetLenght function 
*/



contract Twitter {

    uint256 public MX_TWEET_LEN = 280;
    address public owner;
    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes; 
    }

    mapping(address => Tweet[]) public tweets; // Like a KV pair

    constructor() {
        owner = msg.sender;

    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner. Can't change the tweet length");
        _;
    }

    function changeTweetLength(uint256 newTweetLen) public onlyOwner {
        MX_TWEET_LEN = newTweetLen;
    }

    function createTweet(string memory content) public {

        require(bytes(content).length <= MX_TWEET_LEN, string(abi.encodePacked("Tweet content length should be less than ", Strings.toString(MX_TWEET_LEN), " characters.")));

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
