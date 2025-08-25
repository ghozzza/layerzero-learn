// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import {ILayerZeroEndpointV2} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero Library Configuration Script
/// @notice Sets up send and receive libraries for OApp messaging
contract SetLibraries is Script, Helper {
    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function run() external {
        // Load environment variables
        address endpoint = block.chainid == 421614 ? ARB_LZ_ENDPOINT : BASE_LZ_ENDPOINT; // LayerZero Endpoint address
        address oapp = block.chainid == 421614 ? ARB_OAPP : BASE_OAPP; // Your OApp contract address
        // address signer = vm.envAddress("PUBLIC_KEY"); // Address with permissions to configure

        // Library addresses
        // address sendLib = block.chainid == 421614 ? ARB_SEND_LIB : BASE_SEND_LIB; // SendUln302 address
        // address sendLib = BASE_SEND_LIB; // SendUln302 address
        address sendLib = ARB_SEND_LIB; // SendUln302 address
        // address receiveLib = block.chainid == 421614 ? ARB_RECEIVE_LIB : BASE_RECEIVE_LIB; // ReceiveUln302 address
        // address receiveLib = BASE_RECEIVE_LIB; // ReceiveUln302 address
        address receiveLib = ARB_RECEIVE_LIB; // ReceiveUln302 address

        // Chain configurations
        // uint32 dstEid = block.chainid == 421614 ? ARB_EID : BASE_EID; // Destination chain EID
        // uint32 dstEid = ARB_EID; // Destination chain EID
        uint32 dstEid = BASE_EID; // Destination chain EID  
        // uint32 srcEid = block.chainid == 421614 ? BASE_EID : ARB_EID; // Source chain EID
        // uint32 srcEid = BASE_EID; // Source chain EID
        uint32 srcEid = ARB_EID; // Source chain EID
        uint32 gracePeriod = uint32(0); // Grace period for library switch

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
    }
}
// RUN
// forge script SetLibraries --broadcast -vvv
