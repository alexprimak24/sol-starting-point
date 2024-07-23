// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

//It's way for designer to say that any child of the abstract contract
//Has to implement specified methods
abstract contract Logger {

  uint public testNum;

  constructor() {
    testNum = 1000;
  }
  //virtual - if we want to create a function without implementation
  //we need to mark it with virtual keyword
  //pure means that it cannot modify the state
  function emitLog() public pure virtual returns(bytes32);

  function test3() external pure returns(uint) {
    return 100;
  }
}

//As for me it is like an ABI in Sway, but with test 3 it is not like an abi in sway
//Interface in Solidity is an ABI in Sway