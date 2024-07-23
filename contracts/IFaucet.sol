// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
//Interface in Solidity is an ABI in Sway

//They are similar with Abstract classes, but they cannot inherit from other smart contracts
//they can only inherit from other interfaces

//They cannot decalre a constructor
//They cannot declare a constructor
//if you set an interface - ALL YOUT FUNCTIONS HAVE TO BE EXTERNAL

interface IFaucet {
  function addFunds() external payable;
  function withdraw(uint withdrawAmount) external;
}