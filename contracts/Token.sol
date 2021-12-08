//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NEWToken is ERC20 {
    uint256 public _startTime;
    uint256 public _endTime;
    bool public hasStarted;
    bool public hasEnded;
    address owner;

    event Transfers(address recipient, uint tokensSent, uint currentTime);
   
    constructor() ERC20("Newton", "NEW") {
        owner = address(this);
        _mint(owner, 1000);
        _startTime = block.timestamp;
        _endTime = _startTime + 3 minutes;
        hasStarted;
        !hasEnded;
    }

    modifier timeCheck() {
        require(_endTime >= block.timestamp, "Contribution Time is Over");
        _;
        hasEnded = true;
    }

    function transferr(address recipient, uint256 amount) public timeCheck {
        _transfer(owner, recipient, amount);
        emit Transfers(recipient, amount, block.timestamp);
    }

}