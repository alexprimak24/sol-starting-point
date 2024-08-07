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

//USEFUL CHEATSHEET
contract Todos {

    // ENUM with shipping options
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // default value of that ENUM will be Pending

    // Not type of status is Status enum
    Status public status;


    //Struct creation
    struct Todo {
        string text;
        bool completed;
    }

    // Using Struct inside an array
    Todo[] public todos;

     // Creation of array
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];
    // With max length 10
    uint[10] public myFixedSizeArr;


    function create(string calldata _text) public {
        // How to add value then
        // Via push
        todos.push(Todo(_text, false));

        // Vie push but with keys
        todos.push(Todo({text: _text, completed: false}));

        // init struct in function memory
        Todo memory todo;
        todo.text = _text; //and then set the value
        // todo.completed will be set to false as it is default for bool

        todos.push(todo); // and then from memory we send it to storage so it will be stored on chain
    }

    // Updating just one value in struct
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index]; //take the value from the storage
        todo.text = _text; // then we are updating that value in the storage
    }

    // alternative to instead todo.completed = true)
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }

    function get() public view returns (Status) {
        //get the value of status
        return status;
    }

    // Update status by passing uint into input
    function set(Status _status) public {
        //Changing status
        status = _status;
    }

    // Or just straightforwards way
    function cancel() public {
        status = Status.Canceled;
    }

    // set default value of status (in our case Pending)
    function reset() public {
        delete status;
    }
    //just get a value from array by index
    function getArrIndex(uint i) public view returns (uint) {
        return arr[i];
    }

    // With that we can get the whole arr
    // But avoid it as it consumes a lot of gas for huge array
    // as it may use all the gas and fail tx
    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function push(uint i) public {
        // Adding value for an arr
        arr.push(i);
    }

    function pop() public {
        // Delete el from an array
        arr.pop();
    }

    //Get the length of an array
    function getLength() public view returns (uint) {
        return arr.length;
    }

    function remove(uint index) public {
        // By index we set the value to default
        // It doesn't change the length of an array
        delete arr[index];
    }

    function examples() external pure{
        // this is the length of an array with fixed length inside function
        uint[] memory a = new uint[](5);
        // dynamic array can NOT be created inside function
    }
}

//DAY 4

//Functions pure, view, payable, fallback

contract Demo {
    //public - function can be called from outside and inside
    //external - function can be called from outside(f.e. send funds from MM)
    //internal - function can be called from inside and inherited contracts
    //private - function can be called from inside but not from an inherited contracts

    //view - only read from storage, but not alter them
    //pure - even don't touch the storage

    //get balance of the contract
    //explicit form
    //call
    function getBalance() public view returns(uint){
        uint balance = address(this).balance;
        return balance;
    }
    //just another way to get balance
    //implicit form
    //call
    function getBalance1() public view returns(uint balance){
        balance = address(this).balance;
        // return balance;
    }

    string public message = "hello"; //state
    //this is impossible as we want to return the value form storage but our func is pure
    // function getMessage() external pure returns(string memory){
    //     return message;
    // }

    //how we usually use pure functions
    //for example this is the function that receives some amount of let's say tokens, and 
    //then returns x3 number of tokens - how much user would receive for example
    //call
    function rate(uint amount) public pure returns(uint) {
        return amount * 3;
    }

    //transaction
                        //here I said that the value we receive is just temporary data
    function setMessage(string memory newMessage) public {
        //but once we say that value from storage will have its value, we add this value 
        //to the chain
        message = newMessage;
    }
    //transaction that alters some data, there is no sence in returning what this tx altered
    //make it in separate function

    uint public balanceOfContract;
    
    //payable means that function can receive funds
    //just even if we declare function as payable and don't write anything inside it
    //when we send funds to that function - they will be added to the contract balance
    function pay() external payable {
        balanceOfContract += msg.value;
    }

    //by default if you just send funds to the smart contract address, funds will be returned
    //this function will be called in case someone sent funds to the smart contract address
    receive() external payable {} 

    //A user sends Ether to the contract without specifying any data.
    //A user calls a function that does not exist in the contract.
    fallback() external payable { }
}

//EVENTS MODIFIERS REQUIRE REVERT

contract Demo {
    //require
    //revert
    //assert
    address owner;

    //EVENTS
                        //with it we can create searching
                        //up to 3 fields can be indexed
    event Paid(address indexed _from, uint _amount, uint _timestamp);

    //called only once while creating contract
    constructor() {
        owner = msg.sender;
    }

    function pay() external payable {
        //this is how we emit our Events, that data is not storing in the chain,
        //it is storing in the special event log
        //we are rarely reading from event log , mostly we are reading from it in our frontend part
        emit Paid(msg.sender,msg.value,block.timestamp);
    }


    //MODIFIERS
    modifier onlyOwner(address _to) {
        require(msg.sender == owner,"you are not an owner");
        //address(0) - 0x00000000
        require(_to != address(0), "incorrect address!");
        //without it we won't return to our function execution
        _;
        //we can also make checked even after function body
        // require(...);
    }
                                                    //it can even take some values
    function withdraw(address payable _to) external onlyOwner(_to){
        //REQUIRE
        //if this is false then tx will just revert
        require(msg.sender == owner,"you are not an owner!");

        _to.transfer(address(this).balance);

        //REVERT
        // if(msg.sender != owner) {
        //     revert("you are not an owner!");
        // }
        // revert("you are not an owner!"); //so revert reverts tx and trows a message
        //so difference between require and revert, in require we can easily write condition
        //inside require, in revert we have to do it manually

        //ASSERT
        //it is used quite rarely, in cases when we want to sure that something really 
        //dangerous won't happen
        //in case this is wrong - it will panic
        //and we also won't receive normal error for the reason what happened
        assert(msg.sender == owner);

    }
}

//DAY 5

//CALL

contract TestCall {
  string public message;
  uint public x;

  event Log(string message);

  fallback() external payable { 
    emit Log("fallback was called");
  }

  function foo(string memory _message, uint _x) external payable returns(bool,uint) {
    message = _message;
    x = _x;
    return (true, 999);
  }
}

contract Call {
    bytes public data;

    function callFoo(address _test) external payable {
        //we need to encode the func that we are going to call, we use abi.encodeWithSignature
        //1.functions we are going to call 2.arguments for that func        
        //when we use call it returns boolean and data (return of that function) (data is going to be in bytes)
        //we can also specify the value that we are going to send and amount of gas that is going to be used
        (bool success, bytes memory _data) = _test.call{value: 111}(abi.encodeWithSignature("foo(string, uint256)", "call foo", 123));
        require(success, "call failed");
        data = _data;
    }

    //trying to call the function that doesn't exist
    function callDoesNotExist(address _test) external {
        (bool success, ) = _test.call(abi.encodeWithSignature("doesNotExist()"));
        require(success, "call failed");
    }
}

//DELEGATECALL

/*
A calls B, sends 100 wei
    B calls C, sends 50 wei
A ---> B ---> C
                msg.sender = B
                msg.value = 50
                execture code on C's state variables
                use ETH in C

A calls B, sends 100 wei
        B delegatecall C
A ---> B ---> C
                msg.sender = A
                msg.value = 100
                execute code on B's state variables
                use ETH in B
*/
//!!! if we are using delegatecall all our state variables should 
//be the same and with the same storage slot

//the main benefit of delegate call, is like we can update our setVars functionality
//for example num = _num; we can set to num = 3 * _num; , and it will be multiplying value
//by 3 in DelegateCall, but as we noticed, we didn't redeplyed our DelegateCall contract
contract TestDelegateCall {
  //they will be uninitialized even after calling setVars from DelegateCall
  uint public num;
  address public sender;
  uint public value;

  function setVars(uint _num) external payable {
    num = _num;
    sender = msg.sender;
    value = msg.value;
  }
}

contract DelegateCall {
    uint public num;
    address public sender;
    uint public value;
    //so while calling setVars we will update values that are in our contract
    function setVars(address _test, uint _num) external payable {
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)",_num))
        //this method is kinda better as you don't need to update anything manually if needed
        (bool success, bytes memory data) = _test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector,_num));
        require(success,"delegatecall failed");
    }

}

// DAY 6

//CONSTANTS

//this will be cheaper
contract Constants {
  //as a convention constants are capitalized
  //the main benefit of declaring a constant is that you save gas
    address public constant MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}

contract Var {
    address public MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}

