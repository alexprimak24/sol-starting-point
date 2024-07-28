// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Shop {
    // address owner;//closed, and can't be reached
    address public owner;//can call from inside of the contract and from outside
    //       key        value scope  name of the variable
    mapping (address => uint) public payments;
    
    constructor(){ //this is the thing that is being called only after creation of the contract once
        owner = msg.sender; // this data is being saved in blockchain
    }

    //deposit is set automatically, if we send 30wei here, just with that code, they will be added
    //to the contract balance
    function payForItem() public payable {
        //with that we now know how much will each depositor deposited to the contract
        payments[msg.sender] = msg.value;
    }

    function withdrawAll() public {
        //this is temporary variable, once we out of the contract, it will be removed
        //we assigned _to with the value - owner, but set the owner as temporary payable
        address payable _to = payable(owner);
        //this means the contract we are interacting with
        address _thisContract = address(this);
        _to.transfer(_thisContract.balance);
    }
}

//payable means that funds can be sent here
