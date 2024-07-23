// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

  uint public numOfFunders;
  mapping(address => bool) public funders;
  mapping(uint => address) public lutFunders;
  
  receive() external payable {}

  function addFunds() external payable {
    address funder = msg.sender;
    if (!funders[funder]){
      uint index = numOfFunders++; //why this works?
      //numOfFunders++ will increment the value of numOfFunders by 1
      //BUT it returns the value before the increment!
      lutFunders[index] = funder;
      funders[funder] = true;
    }
  }

  function getAllFunders() external view returns (address[] memory) {
    address[] memory _funders = new address[](numOfFunders);

    for(uint i=0; i < numOfFunders; i++) {
      _funders[i] = lutFunders[i];
    }
    return _funders;
  }

  function getFunderAtIndex(uint8 index) external view returns(address) {
    // address[] memory _funders = getAllFunders();
    return lutFunders[index];
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