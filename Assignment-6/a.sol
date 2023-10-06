// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MyContract is Ownable {
    uint256 public stateVariable;

    function getState() public view returns (uint256) {
        return stateVariable;
    }

    function setState(uint256 newValue) public onlyOwner {
        stateVariable = newValue;
    }
}
