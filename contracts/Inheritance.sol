//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NewtonToken is ERC20 {
    uint256 _startTime;
    uint256 _endTime;
    address owner;
   
    constructor() ERC20("Newton", "NEW") {
        owner = msg.sender;
        _mint(owner, 1000);
        _startTime = block.timestamp;
        _endTime = _startTime + 4 minutes;
    }

    modifier timeCheck() {
        require(_endTime >= block.timestamp, "Contribution Time is Over");
        _;
    }

}

contract Contribution is NewtonToken {

    constructor() payable {}
    
    event Auction(address requestor, uint cost, uint tokensSent);

    modifier price() {
        require(msg.value > 0, "Not enough ETH");
        _;
    }

    function exchange(address recipient, uint amount) public payable price timeCheck {
        _transfer(owner, recipient, amount);
        emit Auction(msg.sender, msg.value, amount);
    }


    function getBalance() public view returns (uint tokensOwned) {
        return balanceOf(msg.sender);
    }

}