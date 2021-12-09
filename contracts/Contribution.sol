//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./Token.sol";

/**  
@title A simple exchange contract
@author Bethany U. Osueke
@notice This contract is useful for exchanging ETH for ERC20 fungible tokens
@dev These functions call on the deployed NEWToken contract
*/
contract Contribution {
    NEWToken _token;

    constructor() payable {}
    
    mapping(address => uint256) public balance;

    event Auction(address requestor, uint cost, uint tokens);

    /// @notice modifier `price` requires contributors to send sufficient amounts of ETH 
    modifier price() {
        require(msg.value > 0, "Not enough ETH");
        _;
    }
    /** 
    @notice Transfers tokens to provided `recipient` address within set time duration
    @dev `balance` maps function callers to the total ETH they've contributed
    @dev event `Auction` emits the function caller, ETH contributed, and token amount exchanged
    @param recipient The address that will receive tokens
    @param amount The amount of tokens to be sent to the `recipient` address
    @return success as boolean once exchange is completed
    */
    function exchange(address recipient, uint amount) public payable price returns (bool success) {
        _token.transferr(recipient, amount);
        balance[msg.sender] += msg.value;
        emit Auction(msg.sender, msg.value, amount);
        return true;
    }

    /// @notice Returns the total amount of donated ETH per contributor
    /// @param wallet The contributing address
    /// @return ethSpent returns the total ETH amount
    function getBalance(address wallet) public view returns (uint ethSpent) {
        return balance[wallet];
    }

}