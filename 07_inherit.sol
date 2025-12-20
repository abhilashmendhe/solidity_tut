// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/*
    Inheritence
    -----------
    1.1 Imherit from the Multiplayer Game
    1.2 Call the parent joinGame() function
        HINT: you might have to use the super keyword
    1.3 Increment playerCount in joinGame() function
*/
// MultiplayerGame contract

contract MultiplayerGame {
    
    mapping(address => bool) public players;

    function joinGame() public virtual {
        players[msg.sender] = true;
    }
}

// Game contract inheriting from MultiplayerGame
contract Game is MultiplayerGame {

    string public gameName;
    uint256 public playerCount;

    constructor(string memory _gameName) {
        gameName = _gameName;
        playerCount = 0;
    }

    function startGame() public {
        // Perform game-specific logic here
    }

    function joinGame() public override {
       super.joinGame(); // fucntion from parent contract
       // add our own func..
       playerCount++;
    }
}
