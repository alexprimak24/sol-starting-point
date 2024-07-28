// DAY 1

//BASICS INTO
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

//BOOL AND UINT AND INT

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    bool myBool; //by default has false

    function myFunc(bool _inputBool) public {
        bool localBool = false; //temporary
        localBool && _inputBool; //and
        localBool || _inputBool; //or
        localBool == _inputBool; //equal
        localBool != _inputBool; //not equal
        !localBool //not
    }

    // unsigned integers
    uint256 public myUint = 42; //256 number of bits 2**256

    uint8 public mySmallUint = 2; //2**8 = 256
    //Min 0, Max 256-1

    function demo(uint _inputUint) public {
        uint localUint = 42;
        localUint + 1;
        localUint - 1;
        localUint * 2;
        localUint / 2;
        localUint ** 3;//^3

        -myInt //+42
    }

    //signed integers
    int public myInt = -42;
    int8 public mySmallInt = -2;
    //2 ** 7 = 128 - as it stores a data about sign
    //min= -128, max= 128-1

    uint public minimum;
    function demo() public {
        minimum = type(uint8).min; // that way you can see min value that that type can store
        //.max - maximal value
    }

    // if we go over the limit
    // transaction will just revert
    uint8 public myVal = 254;

    function inc() public {
        myVal++;
    }

    //but in that case our counter myVal will just start from 0
    uint8 public myVal = 254;

    function inc() public {
        unchecked {
            myVal++;
        }
    }
}

//Homework

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Demo {
    bool myBool = true;
    bool myBool1;

    //called inside and outside of the contract
    uint public U1 = 1;
    //only outside of the contract
    uint external U2 = 2;
    //can be accesible only within smart contract
    uint private U3 = 3;
    //can be accesible within smart contract and derived smart contract
    int internal I4 = 4;
}

