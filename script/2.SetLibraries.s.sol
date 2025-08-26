// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import {ILayerZeroEndpointV2} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero Library Configuration Script
/// @notice Sets up send and receive libraries for OApp messaging
contract SetLibraries is Script, Helper {
    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function run() external {
        address endpoint;
        address oapp;
        address sendLib;
        address receiveLib;
        uint32 dstEid;
        uint32 srcEid;
        uint32 gracePeriod;

        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        endpoint = ARB_LZ_ENDPOINT; // LayerZero Endpoint address
        oapp = ARB_OAPP; // Your OApp contract address
        // Library addresses
        sendLib = ARB_SEND_LIB; // SendUln302 address
        receiveLib = ARB_RECEIVE_LIB; // ReceiveUln302 address
        // Chain configurations
        dstEid = BASE_EID; // Destination chain EID
        srcEid = ARB_EID; // Source chain EID
        gracePeriod = uint32(0); // Grace period for library switch
        vm.startBroadcast(vm.envUint("TESTNET_PRIVATE_KEY"));
        // Set send library for outbound messages
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid, // Destination chain EID
            sendLib // SendUln302 address
        );
        // Set receive library for inbound messages
        ILayerZeroEndpointV2(endpoint).setReceiveLibrary(
            oapp, // OApp address
            srcEid, // Source chain EID
            receiveLib, // ReceiveUln302 address
            gracePeriod // Grace period for library switch
        );
        vm.stopBroadcast();

        console.log("============================================================================================");
        console.log("============================================================================================");

        vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        vm.startBroadcast(vm.envUint("TESTNET_PRIVATE_KEY"));
        endpoint = BASE_LZ_ENDPOINT; // LayerZero Endpoint address
        oapp = BASE_OAPP; // Your OApp contract address
        sendLib = BASE_SEND_LIB; // SendUln302 address
        receiveLib = BASE_RECEIVE_LIB; // ReceiveUln302 address
        dstEid = ARB_EID; // Destination chain EID
        srcEid = BASE_EID; // Source chain EID
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid, // Destination chain EID
            sendLib // SendUln302 address
        );
        // Set receive library for inbound messages
        ILayerZeroEndpointV2(endpoint).setReceiveLibrary(
            oapp, // OApp address
            srcEid, // Source chain EID
            receiveLib, // ReceiveUln302 address
            gracePeriod // Grace period for library switch
        );
        vm.stopBroadcast();
    }
}
// RUN
// forge script SetLibraries --broadcast -vvv
