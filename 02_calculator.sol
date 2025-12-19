// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
    1. Make a contract called Calculator
    2. Create a result variable to store the result
    3. Create funtions to add, sutbtract, and multiply to result
    4. Create a function to get result
*/
contract Calculator {
    
    uint256 result = 0;

    function add(uint256 a) public {
        result += a;
    }

    /*
        1. Visibility in functions
            1.1 public - Functions with public visibility can be used internally and externally as well.
            Your metamask account can use it. Other contracts can use it.

            1.2 private - Can be used within contract only. Can be only used within code itself. You can't click
            on it on the deployed contract sidebar(left) section. (Metamask acc can't use this.)

            1.3 internal - Can be used within the contract and other inheriting contracts.

            1.4 external - Can only be accessed from external contracts or accounts. Only used by external wallets of users.
            It saves gas fees.
            Can't call this func inside another func.
            The difference is because in public functions, Solidity immediately copies array arguments to memory, while external functions can read directly from calldata. Memory allocation is expensive, whereas reading from calldata is cheap.
            (https://ethereum.stackexchange.com/questions/19380/external-vs-public-best-practices)
    */
    function sub(uint256 a) public {
        result -= a;
    }

    function mul(uint256 a) public {
        result *= a;
    }

    function get() public view returns (uint256) {
        return result;
    }   
}
