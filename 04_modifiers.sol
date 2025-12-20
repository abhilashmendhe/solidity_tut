// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
    Modifiers
    ---------
    Modifiers are special functions that change a function's behavior, letting you add common checks (like access control, input validation) or logic before/after the 
    main function runs, reducing code duplication and improving security, using the modifier keyword and _; to insert the original function's code, with built-in ones 
    like view, pure, and payable. 

    e.g
    contract Test {
        address public owner;
        constructor() {
            owner = msg.sender;
        }
        modifier onlyOwner() {
            require(mesg.sender == owner, "You are not the owner");    
            _; // this tells solidity that where your other logic runs
        }
        function changeOwner(address newOwner) public onlyOwner {
            owner = newOwner;
        }
    }
*/
contract PausableToken {
    address public owner;
    bool public paused;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
        paused = false;
        balances[owner] = 1000;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        // 1️⃣ Implement the modifier to allow only the owner to call the function
        _;
    }

    // 2️⃣ Implement the modifier to check if the contract is not paused
    modifier notPaused() {
        require(paused == false, "The contract is paused");
        _;
    }
    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    // 3️⃣ use the notPaused modifier in this function 
    function transfer(address to, uint amount) public notPaused onlyOwner {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
