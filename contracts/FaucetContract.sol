// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

  uint public numOfFunders;
  mapping(uint => address) public funders;

  receive() external payable {}

  function addFunds() external payable {
    uint index = numOfFunders++;
    funders[index] = msg.sender;
  }

  function getAllFunders() external view returns (address[] memory) {
    address[] memory _funders = new address[](numOfFunders);

    for(uint i=0; i < numOfFunders; i++) {
      _funders[i] = funders[i];
    }
    return _funders;
  }

  function getFunderAtIndex(uint8 index) external view returns(address) {
    // address[] memory _funders = getAllFunders();
    return funders[index];
  }
}

//open console
// truffle console
//create an instance
// const instance = await Faucet.deployed();
// add funds to the contract
// instance.addFunds({from: accounts[3],value: "20000000"})
// get a third address that deposited to the faucet
// instance.getFunderAtIndex(2)