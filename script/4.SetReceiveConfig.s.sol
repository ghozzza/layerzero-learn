// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import {ILayerZeroEndpointV2} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import {SetConfigParam} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/IMessageLibManager.sol";
import {UlnConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/uln/UlnBase.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero Receive Configuration Script (B ← A)
/// @notice Defines and applies ULN (DVN) config for inbound message verification on Chain B for messages received from Chain A via LayerZero Endpoint V2.
contract SetReceiveConfig is Script, Helper {
    uint32 constant RECEIVE_CONFIG_TYPE = 2;

    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
    }

    /// @notice Helper function to convert fixed-size array to dynamic array
    function _toDynamicArray(address[2] memory fixedArray) internal pure returns (address[] memory) {
        address[] memory dynamicArray = new address[](2);
        dynamicArray[0] = fixedArray[0];
        dynamicArray[1] = fixedArray[1];
        return dynamicArray;
    }

    function run() external {
        address endpoint;
        address oapp;
        uint32 eid;
        address receiveLib;
        UlnConfig memory uln;
        bytes memory encodedUln;
        SetConfigParam[] memory params;
        SetConfigParam[] memory params2;
        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        endpoint = ARB_LZ_ENDPOINT; // Chain B Endpoint
        oapp = ARB_OAPP; // OApp on Chain B
        eid = ARB_EID; // Endpoint ID for Chain A
        receiveLib = ARB_RECEIVE_LIB; // ReceiveLib for B ← A
        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 2, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray([ARB_DVN1, ARB_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        encodedUln = abi.encode(uln);
        params = new SetConfigParam[](1);
        params[0] = SetConfigParam(eid, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("TESTNET_PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();

        console.log("============================================================================================");
        console.log("============================================================================================");

        vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        endpoint = BASE_LZ_ENDPOINT; // Chain B Endpoint
        oapp = BASE_OAPP; // OApp on Chain B
        eid = BASE_EID; // Endpoint ID for Chain A
        receiveLib = BASE_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 2, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray([BASE_DVN1, BASE_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        encodedUln = abi.encode(uln);
        params2 = new SetConfigParam[](1);
        params2[0] = SetConfigParam(eid, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("TESTNET_PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params2); // Set config for messages received on B from A
        vm.stopBroadcast();
    }
}

// RUN
// forge script SetReceiveConfig --broadcast -vvv
