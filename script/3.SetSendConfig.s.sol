// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// mainnet -> check again

import {Script} from "forge-std/Script.sol";
import {ILayerZeroEndpointV2} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import {SetConfigParam} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/IMessageLibManager.sol";
import {UlnConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/uln/UlnBase.sol";
import {ExecutorConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/SendLibBase.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero Send Configuration Script (A → B)
/// @notice Defines and applies ULN (DVN) + Executor configs for cross‑chain messages sent from Chain A to Chain B via LayerZero Endpoint V2.
contract SetSendConfig is Script, Helper {
    // destination
    uint32 eid0 = BASE_EID; // Endpoint ID for Chain B
    uint32 eid1 = ARB_EID; // Endpoint ID for Chain B
    uint32 eid2 = KAIA_EID; // Endpoint ID for Chain B
    uint32 eid3 = POL_EID; // Endpoint ID for Chain B
    uint32 eid4 = BSC_EID; // Endpoint ID for Chain B

    uint32 constant EXECUTOR_CONFIG_TYPE = 1;
    uint32 constant ULN_CONFIG_TYPE = 2;

    /// @notice Helper function to convert fixed-size array to dynamic array
    function _toDynamicArray(address[2] memory fixedArray) internal pure returns (address[] memory) {
        address[] memory dynamicArray = new address[](2);
        dynamicArray[0] = fixedArray[0];
        dynamicArray[1] = fixedArray[1];
        return dynamicArray;
    }

    function _toDynamicArray1(address[1] memory fixedArray) internal pure returns (address[] memory) {
        address[] memory dynamicArray = new address[](1);
        dynamicArray[0] = fixedArray[0];
        return dynamicArray;
    }

    /// @notice Broadcasts transactions to set both Send ULN and Executor configurations for messages sent from Chain A to Chain B
    function run() external {
        // deployBASE();
        // deployARB();
        // deployKAIA();
        deployPOL();
        deployBSC();
    }

    function deployBASE() public {
        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
        address endpoint = BASE_LZ_ENDPOINT; // Chain A Endpoint
        address oapp = BASE_OAPP; // OApp on Chain A
        address sendLib = BASE_SEND_LIB; // SendLib for A → B
        /// @notice ULNConfig defines security parameters (DVNs + confirmation threshold) for A → B
        /// @notice Send config requests these settings to be applied to the DVNs and Executor for messages sent from A to B
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // minimum block confirmations required on A before sending to B
            requiredDVNCount: 1, // number of DVNs required
            optionalDVNCount: type(uint8).max, // optional DVNs count, uint8
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray1([BASE_DVN2]), // sorted list of required DVN addresses
            optionalDVNs: new address[](0) // sorted list of optional DVNs
        });
        /// @notice ExecutorConfig sets message size limit + fee‑paying executor for A → B
        ExecutorConfig memory exec = ExecutorConfig({
            maxMessageSize: 10000, // max bytes per cross-chain message
            executor: BASE_EXECUTOR // address that pays destination execution fees on B
        });
        bytes memory encodedUln = abi.encode(uln);
        bytes memory encodedExec = abi.encode(exec);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](10);
        params[0] = SetConfigParam(eid0, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[1] = SetConfigParam(eid0, ULN_CONFIG_TYPE, encodedUln);
        params[2] = SetConfigParam(eid1, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[3] = SetConfigParam(eid1, ULN_CONFIG_TYPE, encodedUln);
        params[4] = SetConfigParam(eid2, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[5] = SetConfigParam(eid2, ULN_CONFIG_TYPE, encodedUln);
        params[6] = SetConfigParam(eid3, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[7] = SetConfigParam(eid3, ULN_CONFIG_TYPE, encodedUln);
        params[8] = SetConfigParam(eid4, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[9] = SetConfigParam(eid4, ULN_CONFIG_TYPE, encodedUln);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, sendLib, params); // Set config for messages sent from A to B
        vm.stopBroadcast();
    }

    function deployARB() public {
        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
        address endpoint = ARB_LZ_ENDPOINT; // Chain A Endpoint
        address oapp = ARB_OAPP; // OApp on Chain A
        address sendLib = ARB_SEND_LIB; // SendLib for A → B
        /// @notice ULNConfig defines security parameters (DVNs + confirmation threshold) for A → B
        /// @notice Send config requests these settings to be applied to the DVNs and Executor for messages sent from A to B
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // minimum block confirmations required on A before sending to B
            requiredDVNCount: 1, // number of DVNs required
            optionalDVNCount: type(uint8).max, // optional DVNs count, uint8
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray1([ARB_DVN2]), // sorted list of required DVN addresses
            optionalDVNs: new address[](0) // sorted list of optional DVNs
        });
        /// @notice ExecutorConfig sets message size limit + fee‑paying executor for A → B
        ExecutorConfig memory exec;
        exec = ExecutorConfig({
            maxMessageSize: 10000, // max bytes per cross-chain message
            executor: ARB_EXECUTOR // address that pays destination execution fees on B
        });
        bytes memory encodedUln = abi.encode(uln);
        bytes memory encodedExec = abi.encode(exec);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](10);
        params[0] = SetConfigParam(eid0, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[1] = SetConfigParam(eid0, ULN_CONFIG_TYPE, encodedUln);
        params[2] = SetConfigParam(eid1, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[3] = SetConfigParam(eid1, ULN_CONFIG_TYPE, encodedUln);
        params[4] = SetConfigParam(eid2, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[5] = SetConfigParam(eid2, ULN_CONFIG_TYPE, encodedUln);
        params[6] = SetConfigParam(eid3, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[7] = SetConfigParam(eid3, ULN_CONFIG_TYPE, encodedUln);
        params[8] = SetConfigParam(eid4, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[9] = SetConfigParam(eid4, ULN_CONFIG_TYPE, encodedUln);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, sendLib, params); // Set config for messages sent from A to B
        vm.stopBroadcast();
    }

    function deployKAIA() public {
        vm.createSelectFork(vm.rpcUrl("kaia_mainnet"));
        address endpoint = KAIA_LZ_ENDPOINT; // Chain A Endpoint
        address oapp = KAIA_OAPP; // OApp on Chain A
        address sendLib = KAIA_SEND_LIB; // SendLib for A → B
        /// @notice ULNConfig defines security parameters (DVNs + confirmation threshold) for A → B
        /// @notice Send config requests these settings to be applied to the DVNs and Executor for messages sent from A to B
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 10, // minimum block confirmations required on A before sending to B
            requiredDVNCount: 1, // number of DVNs required
            optionalDVNCount: type(uint8).max, // optional DVNs count, uint8
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray1([KAIA_DVN2]), // sorted list of required DVN addresses
            optionalDVNs: new address[](0) // sorted list of optional DVNs
        });
        /// @notice ExecutorConfig sets message size limit + fee‑paying executor for A → B
        ExecutorConfig memory exec;
        exec = ExecutorConfig({
            maxMessageSize: 10000, // max bytes per cross-chain message
            executor: KAIA_EXECUTOR // address that pays destination execution fees on B
        });
        bytes memory encodedUln = abi.encode(uln);
        bytes memory encodedExec = abi.encode(exec);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](10);
        params[0] = SetConfigParam(eid0, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[1] = SetConfigParam(eid0, ULN_CONFIG_TYPE, encodedUln);
        params[2] = SetConfigParam(eid1, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[3] = SetConfigParam(eid1, ULN_CONFIG_TYPE, encodedUln);
        params[4] = SetConfigParam(eid2, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[5] = SetConfigParam(eid2, ULN_CONFIG_TYPE, encodedUln);
        params[6] = SetConfigParam(eid3, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[7] = SetConfigParam(eid3, ULN_CONFIG_TYPE, encodedUln);
        params[8] = SetConfigParam(eid4, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[9] = SetConfigParam(eid4, ULN_CONFIG_TYPE, encodedUln);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, sendLib, params); // Set config for messages sent from A to B
        vm.stopBroadcast();
    }

    function deployPOL() public {
        vm.createSelectFork(vm.rpcUrl("pol_mainnet"));
        address endpoint = POL_LZ_ENDPOINT; // Chain A Endpoint
        address oapp = POL_OAPP; // OApp on Chain A
        address sendLib = POL_SEND_LIB; // SendLib for A → B
        /// @notice ULNConfig defines security parameters (DVNs + confirmation threshold) for A → B
        /// @notice Send config requests these settings to be applied to the DVNs and Executor for messages sent from A to B
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // minimum block confirmations required on A before sending to B
            requiredDVNCount: 1, // number of DVNs required
            optionalDVNCount: type(uint8).max, // optional DVNs count, uint8
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray1([POL_DVN2]), // sorted list of required DVN addresses
            optionalDVNs: new address[](0) // sorted list of optional DVNs
        });
        /// @notice ExecutorConfig sets message size limit + fee‑paying executor for A → B
        ExecutorConfig memory exec;
        exec = ExecutorConfig({
            maxMessageSize: 10000, // max bytes per cross-chain message
            executor: POL_EXECUTOR // address that pays destination execution fees on B
        });
        bytes memory encodedUln = abi.encode(uln);
        bytes memory encodedExec = abi.encode(exec);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](10);
        params[0] = SetConfigParam(eid0, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[1] = SetConfigParam(eid0, ULN_CONFIG_TYPE, encodedUln);
        params[2] = SetConfigParam(eid1, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[3] = SetConfigParam(eid1, ULN_CONFIG_TYPE, encodedUln);
        params[4] = SetConfigParam(eid2, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[5] = SetConfigParam(eid2, ULN_CONFIG_TYPE, encodedUln);
        params[6] = SetConfigParam(eid3, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[7] = SetConfigParam(eid3, ULN_CONFIG_TYPE, encodedUln);
        params[8] = SetConfigParam(eid4, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[9] = SetConfigParam(eid4, ULN_CONFIG_TYPE, encodedUln);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, sendLib, params); // Set config for messages sent from A to B
        vm.stopBroadcast();
    }

    function deployBSC() public {
        vm.createSelectFork(vm.rpcUrl("bsc_mainnet"));
        address endpoint = BSC_LZ_ENDPOINT; // Chain A Endpoint
        address oapp = BSC_OAPP; // OApp on Chain A
        address sendLib = BSC_SEND_LIB; // SendLib for A → B
        /// @notice ULNConfig defines security parameters (DVNs + confirmation threshold) for A → B
        /// @notice Send config requests these settings to be applied to the DVNs and Executor for messages sent from A to B
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // minimum block confirmations required on A before sending to B
            requiredDVNCount: 1, // number of DVNs required
            optionalDVNCount: type(uint8).max, // optional DVNs count, uint8
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray1([BSC_DVN2]), // sorted list of required DVN addresses
            optionalDVNs: new address[](0) // sorted list of optional DVNs
        });
        /// @notice ExecutorConfig sets message size limit + fee‑paying executor for A → B
        ExecutorConfig memory exec;
        exec = ExecutorConfig({
            maxMessageSize: 10000, // max bytes per cross-chain message
            executor: BSC_EXECUTOR // address that pays destination execution fees on B
        });
        bytes memory encodedUln = abi.encode(uln);
        bytes memory encodedExec = abi.encode(exec);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](10);
        params[0] = SetConfigParam(eid0, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[1] = SetConfigParam(eid0, ULN_CONFIG_TYPE, encodedUln);
        params[2] = SetConfigParam(eid1, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[3] = SetConfigParam(eid1, ULN_CONFIG_TYPE, encodedUln);
        params[4] = SetConfigParam(eid2, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[5] = SetConfigParam(eid2, ULN_CONFIG_TYPE, encodedUln);
        params[6] = SetConfigParam(eid3, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[7] = SetConfigParam(eid3, ULN_CONFIG_TYPE, encodedUln);
        params[8] = SetConfigParam(eid4, EXECUTOR_CONFIG_TYPE, encodedExec);
        params[9] = SetConfigParam(eid4, ULN_CONFIG_TYPE, encodedUln);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, sendLib, params); // Set config for messages sent from A to B
        vm.stopBroadcast();
    }
}

// RUN
// forge script SetSendConfig --broadcast -vvv
