// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface ISrcEidLib {
    function srcDecimals(uint32 srcEid) external view returns (uint8);
}