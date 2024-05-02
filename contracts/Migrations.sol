// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Migrations {
  address public owner = msg.sender;
  uint public last_completed_migration;

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }
  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }
}

// 60 80 60 40 52 34 80 15 60 0f 57 60 00 80 fd 5b 50 60 45 80 60 1d 60 00 39 60 00 f3 fe