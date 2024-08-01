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

//DAY 2

//STRINGS
    //in Solidity strings:
    //1.Don't have length as they are being stored as byte array
    //2.You can't concat,compare strings
    //3.You can't call string characters by index
    //the more u want to store - the more u pay in gas
    string public myStr = "test"; //storage, will exist till Ethereum Chain exist

    function demo(string memory newValueStr) public {
        //temporary
        string memory myTempStr = "temp";
        //newValueStr from temporary actually becomes not temporary
        myStr = newValueStr;
    }

    //ADDRESS
    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // //function to get user balance
    function getBalance(address _targetAddr) public view returns(uint){
        return _targetAddr.balance;
    }
    //function to receive funds
    function receiveFunds() public payable {

    }
    // //function to transfer funds from the contract
    function transferTo(address _targetAddr,uint amount) public {
        address payable _to = payable(_targetAddr);
        _to.transfer(amount);
    }

    //MAPPING
    mapping (address => uint) public payments;//storage

    function receiveFunds() public payable {
        payments[msg.sender] = msg.value;
    }


//DAY 3

//ARRAY, BYTES, ENUM, STRUCT

contract Demo {
    //Enum
    enum Status {
        Paid,Delivered,Received
    }
    // //Status is data type of currentStatus
    // //we set not the value Paid,Delivered..., we receive Index of them Paid - 0, Delivered - 1
    // Status public currentStatus;

    function pay() public {
        currentStatus = Status.Paid;
    }
    function delivered() public {
        currentStatus = Status.Delivered;
    }

    //Array with set length
    //uint - elements, 10 - max number of elements
    uint[10] public items = [1,2,3];

    function demo() public {
        items[0] = 100;
        items[2] = 200;
        items[4] = 400;

    }

    //Nested array
    //2el in the outer array
    //3el in the inner array
    uint[3][2] public items;

    function demo() public {
       items = [
        [1,2,3],
        [3,4,5]
       ];
       //to call 4 we need to call 1,1
    }

    //Array with dynamic length

    uint[] public items;
    uint public len;
    function demo() public {
        //push exist only for dynamic arrays
        items.push(4);//add first el
        items.push(5);//add sencond el
        //we can measure the length of an array
        len = items.length;
    }

    // //We can also create a temporary arrays that exist only while function execution
    function sampleMemory() public pure returns(uint[] memory) {
        uint[] memory tempArray = new uint[](10);
        tempArray[0] = 1;
        return tempArray;
    }

    //Byte Array
    //from 1 --> 32 bytes
    //32*8 - also max length 256 bits as well as for uint
    //it takes 1 byte or 8bits
    //we can even input strings here - but it will be converted to bytes
    bytes32 public myVar = "test";
    //dynamic byte arr
    bytes public myVarDynamic = "test";

    // //how to store other that english
    bytes public myVarDynamicUkr = unicode"Привіт!";

    function demo() public view returns(uint) {
        //in that case all good and we receive 4, but in case we paste here not english
        //but symbols from other languages, everything becomes more complicated
        return myVarDynamic.length;
    }

    function demo() public view returns(bytes1) {
        //we can get the first byte, btw then we can decode it and get what symbol we received
        return myVarDynamic[0];
    }

    //Struct - like Objects in JS
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
        //this is not allowed
        // Payment payment;
    }

    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function getPayment(address _addr, uint _index) public view returns(Payment memory){
        return balances[_addr].payments[_index];
    }

    function pay(string memory message) public payable {

        uint paymentNum =  balances[msg.sender].totalPayments;

        //uint totalPayments - incremented
        balances[msg.sender].totalPayments++;
        //as for now it is temporary 
        Payment memory newPayment = Payment(
             msg.value,
             block.timestamp,
             msg.sender,
             message   
        );
        //and now we stored it in the blockchain
        balances[msg.sender].payments[paymentNum] = newPayment;
    }
}
