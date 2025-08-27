// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SrcEidLib is Ownable {
    mapping(uint32 => uint8) public srcDecimals;

    constructor(uint32[] memory srcEids, uint8[] memory decimals, address _owner) Ownable(_owner) {
        for (uint i; i < srcEids.length; i++) {
            srcDecimals[srcEids[i]] = decimals[i];
        }
    }

    function setSrcDecimals(uint32 srcEid, uint8 decimals) external onlyOwner {
        srcDecimals[srcEid] = decimals;
    }
}
