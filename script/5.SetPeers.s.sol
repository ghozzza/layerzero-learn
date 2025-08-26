// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import {MyOApp} from "../src/MyOApp.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero OApp Peer Configuration Script
/// @notice Sets up peer connections between OApp deployments on different chains
contract SetPeers is Script, Helper {
    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
    }

    function run() external {
        address oapp;
        uint32 eid1;
        bytes32 peer1;
        uint32 eid2;
        bytes32 peer2;

        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        // Load environment variables
        oapp = ARB_OAPP; // Your OApp contract address
        // Example: Set peers for different chains
        // Format: (chain EID, peer address in bytes32)
        (eid1, peer1) = (ARB_EID, bytes32(uint256(uint160(ARB_OAPP))));
        (eid2, peer2) = (BASE_EID, bytes32(uint256(uint160(BASE_OAPP))));
        vm.startBroadcast(vm.envUint("TESTNET_PRIVATE_KEY"));
        // Set peers for each chain
        MyOApp(oapp).setPeer(eid1, peer1);
        MyOApp(oapp).setPeer(eid2, peer2);
        vm.stopBroadcast();

        console.log("============================================================================================");
        console.log("============================================================================================");

        vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        // Load environment variables
        oapp = BASE_OAPP; // Your OApp contract address
        // Example: Set peers for different chains
        // Format: (chain EID, peer address in bytes32)
        (eid1, peer1) = (BASE_EID, bytes32(uint256(uint160(BASE_OAPP))));
        (eid2, peer2) = (ARB_EID, bytes32(uint256(uint160(ARB_OAPP)))); // Your OApp contract address
        vm.startBroadcast(vm.envUint("TESTNET_PRIVATE_KEY"));
        // Set peers for each chain
        MyOApp(oapp).setPeer(eid1, peer2);
        MyOApp(oapp).setPeer(eid2, peer2);
        vm.stopBroadcast();
    }
}

// RUN
// forge script SetPeers --broadcast -vvv
