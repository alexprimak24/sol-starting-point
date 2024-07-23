// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Owned.sol";
//now faucet inherited all the functionality from Owned
contract Faucet is Owned{

  uint public numOfFunders;

  mapping(address => bool) public funders;
  mapping(uint => address) public lutFunders;

  //modifier is the thing that is needed if we want something to be repeatedly used
  modifier limitWithdraw(uint withdrawAmount) {
    //if the require is not met it will just revert tx
    require(
      withdrawAmount <= 100000000000000000,
      "Cannot withdraw more that 0.1 ether"
    );
    _; //this is function body (function body this is everything that is inside the function
       // in which we call that modifier)
  }
  
  receive() external payable {}

  function transferOwnership(address newOwner) external onlyOwner {
    owner = newOwner;
  }

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

  function test1() external onlyOwner{
   //some managing stuff that only an admin have access to
  }

  function test2() external onlyOwner{
   //some managing stuff that only an admin have access to
  }

  function withdraw(uint withdrawAmount) external limitWithdraw(withdrawAmount){
    payable(msg.sender).transfer(withdrawAmount);
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

// open console
// truffle console
// create an instance
// const instance = await Faucet.deployed();
// add funds to the contract
// instance.addFunds({from: accounts[3],value: "20000000"})
// get a third address that deposited to the faucet
// instance.getFunderAtIndex(2)

// instance.withdraw("2000000000000000000", {from: accounts[1]})