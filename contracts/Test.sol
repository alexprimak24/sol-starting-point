// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Test {
  function test(uint testNum) external pure returns (uint){
    
    assembly{
       let _num := 4
       let _fmp := mload(0x40)
    }

    // uint8[3] memory items = [1,2,3];

    return testNum;
  }

  function test2() external pure returns (uint data){
    assembly{
       let fmp := mload(0x40)
        //hello
       mstore(add(fmp,0x00),0x68656C6C6F)
       data := mload(add(fmp,0x00))
    }
  }
}
