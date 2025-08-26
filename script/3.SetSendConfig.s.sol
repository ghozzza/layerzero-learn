// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// mainnet -> check again

import "forge-std/Script.sol";
import {ILayerZeroEndpointV2} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import {SetConfigParam} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/IMessageLibManager.sol";
import {UlnConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/uln/UlnBase.sol";
import {ExecutorConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/SendLibBase.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero Send Configuration Script (A → B)
/// @notice Defines and applies ULN (DVN) + Executor configs for cross‑chain messages sent from Chain A to Chain B via LayerZero Endpoint V2.
contract SetSendConfig is Script, Helper {
    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        // vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
    }

    uint32 constant EXECUTOR_CONFIG_TYPE = 1;
    uint32 constant ULN_CONFIG_TYPE = 2;

    /// @notice Helper function to convert fixed-size array to dynamic array
    function _toDynamicArray(address[2] memory fixedArray) internal pure returns (address[] memory) {
        address[] memory dynamicArray = new address[](2);
        dynamicArray[0] = fixedArray[0];
        dynamicArray[1] = fixedArray[1];
        return dynamicArray;
    }

    /// @notice Broadcasts transactions to set both Send ULN and Executor configurations for messages sent from Chain A to Chain B
    function run() external {
        address endpoint;
        address oapp;
        uint32 eid;
        address sendLib;
        UlnConfig memory uln;
        ExecutorConfig memory exec;
        bytes memory encodedUln;
        bytes memory encodedExec;
        SetConfigParam[] memory params;
        SetConfigParam[] memory params2;

        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        endpoint = ARB_LZ_ENDPOINT; // Chain A Endpoint
        oapp = ARB_OAPP; // OApp on Chain A
        eid = ARB_EID; // Endpoint ID for Chain B
        sendLib = ARB_SEND_LIB; // SendLib for A → B
        /// @notice ULNConfig defines security parameters (DVNs + confirmation threshold) for A → B
        /// @notice Send config requests these settings to be applied to the DVNs and Executor for messages sent from A to B
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        uln = UlnConfig({
            confirmations: 15, // minimum block confirmations required on A before sending to B
            requiredDVNCount: 2, // number of DVNs required
            optionalDVNCount: type(uint8).max, // optional DVNs count, uint8
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray([ARB_DVN1, ARB_DVN2]), // sorted list of required DVN addresses
            optionalDVNs: new address[](0) // sorted list of optional DVNs
        });
        /// @notice ExecutorConfig sets message size limit + fee‑paying executor for A → B
        exec = ExecutorConfig({
            maxMessageSize: 10000, // max bytes per cross-chain message
            executor: ARB_EXECUTOR // address that pays destination execution fees on B
        });
        encodedUln = abi.encode(uln);
        encodedExec = abi.encode(exec);
        params = new SetConfigParam[](2);
        params[0] = SetConfigParam(eid, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[1] = SetConfigParam(eid, ULN_CONFIG_TYPE, encodedUln);
        vm.startBroadcast(vm.envUint("TESTNET_PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, sendLib, params); // Set config for messages sent from A to B
        vm.stopBroadcast();

        console.log("============================================================================================");
        console.log("============================================================================================");

        vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        endpoint = BASE_LZ_ENDPOINT; // Chain A Endpoint
        oapp = BASE_OAPP; // OApp on Chain A
        eid = BASE_EID; // Endpoint ID for Chain B
        sendLib = BASE_SEND_LIB; // SendLib for A → B

        /// @notice ULNConfig defines security parameters (DVNs + confirmation threshold) for A → B
        /// @notice Send config requests these settings to be applied to the DVNs and Executor for messages sent from A to B
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        uln = UlnConfig({
            confirmations: 15, // minimum block confirmations required on A before sending to B
            requiredDVNCount: 2, // number of DVNs required
            optionalDVNCount: type(uint8).max, // optional DVNs count, uint8
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray([BASE_DVN1, BASE_DVN2]), // sorted list of required DVN addresses
            optionalDVNs: new address[](0) // sorted list of optional DVNs
        });

        /// @notice ExecutorConfig sets message size limit + fee‑paying executor for A → B
        exec = ExecutorConfig({
            maxMessageSize: 10000, // max bytes per cross-chain message
            executor: BASE_EXECUTOR // address that pays destination execution fees on B
        });

        encodedUln = abi.encode(uln);
        encodedExec = abi.encode(exec);

        params2 = new SetConfigParam[](2);
        params2[0] = SetConfigParam(eid, EXECUTOR_CONFIG_TYPE, encodedExec);
        params2[1] = SetConfigParam(eid, ULN_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("TESTNET_PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, sendLib, params2); // Set config for messages sent from A to B
        vm.stopBroadcast();
    }
}

// RUN
// forge script SetSendConfig --broadcast -vvv
