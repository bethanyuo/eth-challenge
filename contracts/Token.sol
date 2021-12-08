//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NEWToken is ERC20 {
    uint256 _startTime;
    uint256 _endTime;
    address owner;
    mapping (address => uint) tokenBalances;
    uint public initialSupply;
    uint rateOfTokensToGivePerEth;

    constructor() ERC20("Newton", "NEW") {
        _mint(msg.sender, 1000);
        _startTime = block.timestamp;
        _endTime = _startTime + 4 minutes;
        owner = msg.sender;
        initialSupply = 1000;
        tokenBalances[owner] = initialSupply;
        rateOfTokensToGivePerEth = 10;
    }

    modifier timeCheck() {
        require(_endTime >= block.timestamp, "Auction Time is Over");
        _;
    }

}

contract Contribution is NEWToken {
    event Auction(address tokenHolder, uint cost, uint tokenBalance);

    //constructor() public payable {}

    // modifier onlyOwner() {
    //     require(owner == msg.sender, "Only Auction Owner is authorized");
    //     _;
    // }

    function buyTokens() public payable timeCheck {
        uint tokens = rateOfTokensToGivePerEth * (msg.value / 1 ether);
        require(tokens <= initialSupply, "Token Underflow");
        require(tokenBalances[msg.sender] + tokens >= tokenBalances[msg.sender], "Token Overflow");
        tokenBalances[owner] -= tokens;
        tokenBalances[msg.sender] += tokens;

        emit Auction(msg.sender, msg.value, tokenBalances[msg.sender]);
    }

    function getBalance() public view returns (uint tokens) {
        return tokenBalances[msg.sender];
    }

    // function currentSupply() public view onlyOwner returns (uint tokensLeft) {
    //     return tokenBalances[owner];
    // }

    // function auctionBalance() public view onlyOwner returns (uint profits) {
    //     return address(this).balance;
    // }

}