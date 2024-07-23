// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Owned {
  address public owner;

  //Constructors in Solidity are special functions that 
  //are only executed once when the contract is deployed.
  constructor(){
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(owner == msg.sender,"Only owner can call this function");
    _;
  }
}