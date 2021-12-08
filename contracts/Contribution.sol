//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./Token.sol";

contract Contribution {
    NewtonToken _token;

    constructor() payable {}
    
    mapping(address => uint256) private balance;
    event Auction(address requestor, uint cost, uint tokens);

    modifier price() {
        require(msg.value > 0, "Not enough ETH");
        _;
    }

    function exchange(address recipient, uint amount) public payable price {
        _token.transferr(recipient, amount);
        balance[msg.sender] += msg.value;
        emit Auction(msg.sender, msg.value, amount);
    }


    function getBalance(address wallet) public view returns (uint ethSpent) {
        return balance[wallet];
    }

}