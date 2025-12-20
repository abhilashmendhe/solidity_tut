// SPDX-License-Identifier: GPL-3.0
import "@openzeppelin/contracts/utils/Strings.sol";
pragma solidity >=0.8.2 <0.9.0;

/*
    Tasks
    -----
    // 9.1 Add id to Tweet Struct to make every Tweet Unique
    // 9.2 Set the id to be the Tweet[] length 
        // HINT: you do it in the createTweet function
    // 9.3 Add a function to like the tweet
        // HINT: there should be 2 parameters, id and author
    // 9.4 Add a function to unlike the tweet
        // HINT: make sure you can unlike only if likes count is greater then 0
    // 9.5 Mark both functions external 
*/



contract Twitter {

    uint256 public MX_TWEET_LEN = 280;
    address public owner;
    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        // mapping (address => uint256) likes; 
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
            id: uint256(tweets[msg.sender].length+1),
            author: msg.sender,
            content: content,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);
    }

    function getTweet(address _owner, uint256 id) public view returns (Tweet memory) {
        require(tweets[_owner].length > 0, "No tweets are available.");
        require(id > 0, "Tweet id should be greater than 0.");
        require(id <= tweets[_owner].length, string(abi.encodePacked("Tweet id: ", Strings.toString(id), " not found.")));
        return tweets[_owner][id-1];
    }

    function getAllTweet(address _owner) public view returns (Tweet[] memory) {
        require(tweets[_owner].length > 0, "No tweets are available.");
        return tweets[_owner];
    }

    function likeTweet(uint256 id, address author) external {
        require(tweets[author].length > 0, "No tweets are available.");
        require(id > 0, "Tweet id should be greater than 0.");
        require(id <= tweets[author].length, string(abi.encodePacked("Tweet id: ", Strings.toString(id), " not found to like.")));
        tweets[author][id-1].likes += 1;
    }
    function unlikeTweet(uint256 id, address author) external {
       require(tweets[author].length > 0, "No tweets are available.");
        require(id > 0, "Tweet id should be greater than 0.");
        require(id <= tweets[author].length, string(abi.encodePacked("Tweet id: ", Strings.toString(id), " not found to unlike.")));
        tweets[author][id-1].likes -= 1;
    }
}
