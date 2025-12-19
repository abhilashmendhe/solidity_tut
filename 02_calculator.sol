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
