//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./Token.sol";

contract Contribution {
    NEWToken _token;

    constructor() payable {}
    
    mapping(address => uint256) public balance;

    event Auction(address requestor, uint cost, uint tokens);

    modifier price() {
        require(msg.value > 0, "Not enough ETH");
        _;
    }

    function exchange(address recipient, uint amount) public payable price returns (bool success) {
        _token.transferr(recipient, amount);
        balance[msg.sender] += msg.value;
        emit Auction(msg.sender, msg.value, amount);
        return true;
    }


    function getBalance(address wallet) public view returns (uint ethSpent) {
        return balance[wallet];
    }

}