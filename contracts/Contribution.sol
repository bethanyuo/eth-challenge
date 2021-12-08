//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./Token.sol";

contract Contribution {
    NEWToken _token;
    constructor() payable {}
    
    event Auction(address requestor, uint cost, uint tokens);

    modifier price() {
        require(msg.value > 0, "Not enough ETH");
        _;
    }

    function exchange(address recipient, uint amount) public payable price {
        _token.transferr(recipient, amount);
        emit Auction(msg.sender, msg.value, amount);
    }


    function getBalance() public view returns (uint tokensOwned) {
        return _token.balanceOf(msg.sender);
    }

}