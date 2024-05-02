// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

  //this is special function
  //it's called when you make a tx this doesn't specify function name to call

  //External functions are part of the contract interface which means they can be 
  //call via contract and other txs
  receive() external payable {}

  function addFunds() external payable {}
  
  function justTesting() external pure returns(uint)  {
      return 2+2;
  }
  //pure,view


}

