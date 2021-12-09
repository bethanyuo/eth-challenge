//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**  
@title A simple ERC20 fungible token contract
@author Bethany U. Osueke
@notice This contract is useful for only the most basic token minting and transfers
@dev All function calls are directly inherited from Openzepplin
*/
contract NEWToken is ERC20 {
    uint256 public _startTime;
    uint256 public _endTime;
    bool public hasStarted;
    bool public hasEnded;
    address public owner;

    event Transfers(address recipient, uint256 tokensSent);

    /// @notice Create Newton tokens (1000 NEWs) and store them in this contract
    /// @dev setting time constraints `_startTime` and `_endTime`
    constructor() ERC20("Newton", "NEW") {
        owner = address(this);
        _mint(owner, 1000);
        _startTime = block.timestamp;
        _endTime = _startTime + 3 minutes;
        hasStarted = true;
        hasEnded = false;
    }
    
    /// @notice modifier `timeCheck` sets the time duration for token transferring
    /// @dev boolean hasEnded reassigned once duration is surpassed
    modifier timeCheck() {
        require(_endTime >= block.timestamp, "Contribution Time is Over");
        _;
        hasEnded = true;
    }

    /// @notice Transfers tokens to provided `recipient` address within set time duration
    /// @dev event `Transfers` emits params
    /// @param recipient The address that will receive tokens
    /// @param amount The amount of tokens to be sent to the `recipient` address
    function transferr(address recipient, uint256 amount) public timeCheck {
        _transfer(owner, recipient, amount);
        emit Transfers(recipient, amount);
    }
}
