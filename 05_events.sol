// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/*
    Events
    ------
    Events are notifications to the blockchain.

    e.g.
    contract EventExample {
        event EventName(uint256 indexed data1, string data2); // indexed keyword used as cache. For faster lookup.
        function someFunc() public {
            ...
            emit EventName(data1, data2);
        }
    }
*/

/*
    Tasks
    -----
    1. Add an event called "NewUserRegistered" with 2 args
        1.1. user as address type
        1.2. username as string type
    2. Emit in the function registerUser
*/

contract EventExample {

    event NewUserRegistered(address indexed user, string username);

    struct User {
        string username;
        uint256 age;
    }

    mapping (address => User) public users;

    function registerUser(string memory _username, uint256 _age) public {
        User storage newUser = users[msg.sender];
        newUser.username = _username;
        newUser.age = _age;
    
        emit NewUserRegistered(msg.sender, _username);
    }


}

