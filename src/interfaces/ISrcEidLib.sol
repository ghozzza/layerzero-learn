// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface ISrcEidLib {
    struct SrcEidInfo {
        uint32 eid;
        uint8 decimals;
    }

    function srcDecimals(uint32 srcEid) external view returns (uint8);
}