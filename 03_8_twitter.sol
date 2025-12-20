// SPDX-License-Identifier: GPL-3.0
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity >=0.8.2 <0.9.0;

/*
    Tasks
    -----
    12.1 Import Ownable.sol contract from OpenZeppelin
    12.2 Inherit Ownable Contract
    12.3 Replace current onlyOwner 
*/

contract Twitter is Ownable {

    uint256 public MX_TWEET_LEN = 280;
    // address public owner;
    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        // mapping (address => uint256) likes; 
        uint256 likes;
    }
    constructor() Ownable(msg.sender) {}
    mapping(address => Tweet[]) public tweets; // Like a KV pair

    event TweetCreated(uint256 id, address indexed author, string content, uint256 timestamp);
    event TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint256 likes);
    event TweetUnliked(address unliker, address tweetAuthor, uint256 tweetId, uint256 likes);
    

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
        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
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

        emit TweetLiked(msg.sender, author, id, tweets[author][id-1].likes);
    }
    function unlikeTweet(uint256 id, address author) external {
    require(tweets[author].length > 0, "No tweets are available.");
        require(id > 0, "Tweet id should be greater than 0.");
        require(id <= tweets[author].length, string(abi.encodePacked("Tweet id: ", Strings.toString(id), " not found to unlike.")));
        tweets[author][id-1].likes -= 1;

        emit TweetUnliked(msg.sender, author, id, tweets[author][id-1].likes);
    }

    function getTotalLikes(address author) public view returns (uint) {
        
        uint totalLikes = 0;

        for (uint256 i = 0; i < tweets[author].length; i++) {
            totalLikes += tweets[author][i].likes;
        }
        return totalLikes;
    }
}
