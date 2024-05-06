// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Storage {
  uint8 public a = 7; // 1 byte
  uint16 public b = 10; // 2 bytes
  address public c = 0x3803a25803755807B6Db5780A5E3789b4736d26A; //20bytes
  bool d = true; //1 byte
  uint64 public e = 15; //8 bytes because uint64
  //32bytes in total, all vals will be stored in slot 0


  uint256 public f = 200; //32 bytes because uint256
  //will be stored in slot 1

  uint8 public g = 40; // 1 byte
  //as next we will have also 32 bytes, we need to store this 1 byte
  //in slot 2

  uint public h = 789; //32 bytes
  //will be stored in slot 3

  //btw keep in mind that in such cases order MATTERS, like
  //if I change g and h it's places, if after that I'll have
  //a value that is also 1 byte - we will be stored at the same slot
  //therefore gas consumption will be lower
}