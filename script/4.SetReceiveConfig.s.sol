// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {ILayerZeroEndpointV2} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import {SetConfigParam} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/IMessageLibManager.sol";
import {UlnConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/uln/UlnBase.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero Receive Configuration Script (B ← A)
/// @notice Defines and applies ULN (DVN) config for inbound message verification on Chain B for messages received from Chain A via LayerZero Endpoint V2.
contract SetReceiveConfig is Script, Helper {
    uint32 constant RECEIVE_CONFIG_TYPE = 2;

    // destination
    uint32 eid0 = BASE_EID; // Endpoint ID for Chain B
    uint32 eid1 = ARB_EID; // Endpoint ID for Chain B
    uint32 eid2 = KAIA_EID; // Endpoint ID for Chain B
    uint32 eid3 = POL_EID; // Endpoint ID for Chain B
    uint32 eid4 = BSC_EID; // Endpoint ID for Chain B

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

    function run() external {
        // deployBASE();
        // deployARB();
        // deployKAIA();
        // deployPOL();
        deployBSC();
    }

    function deployBASE() public {
        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
        address endpoint = BASE_LZ_ENDPOINT; // Chain B Endpoint
        address oapp = BASE_OAPP; // OApp on Chain B
        address receiveLib = BASE_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 1, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray1([BASE_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        bytes memory encodedUln = abi.encode(uln);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](5);
        params[0] = SetConfigParam(eid0, RECEIVE_CONFIG_TYPE, encodedUln);
        params[1] = SetConfigParam(eid1, RECEIVE_CONFIG_TYPE, encodedUln);
        params[2] = SetConfigParam(eid2, RECEIVE_CONFIG_TYPE, encodedUln);
        params[3] = SetConfigParam(eid3, RECEIVE_CONFIG_TYPE, encodedUln);
        params[4] = SetConfigParam(eid4, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();
    }

    function deployARB() public {
        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
        address endpoint = ARB_LZ_ENDPOINT; // Chain B Endpoint
        address oapp = ARB_OAPP; // OApp on Chain B
        address receiveLib = ARB_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 1, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray1([ARB_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        bytes memory encodedUln = abi.encode(uln);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](5);
        params[0] = SetConfigParam(eid0, RECEIVE_CONFIG_TYPE, encodedUln);
        params[1] = SetConfigParam(eid1, RECEIVE_CONFIG_TYPE, encodedUln);
        params[2] = SetConfigParam(eid2, RECEIVE_CONFIG_TYPE, encodedUln);
        params[3] = SetConfigParam(eid3, RECEIVE_CONFIG_TYPE, encodedUln);
        params[4] = SetConfigParam(eid4, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();
    }

    function deployKAIA() public {
        vm.createSelectFork(vm.rpcUrl("kaia_mainnet"));
        address endpoint = KAIA_LZ_ENDPOINT; // Chain B Endpoint
        address oapp = KAIA_OAPP; // OApp on Chain B
        address receiveLib = KAIA_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // minimum block confirmations required on A before sending to B
            requiredDVNCount: 1, // number of DVNs required
            optionalDVNCount: type(uint8).max, // optional DVNs count, uint8
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray1([KAIA_DVN2]), // sorted list of required DVN addresses
            optionalDVNs: new address[](0) // sorted list of optional DVNs
        });
        bytes memory encodedUln = abi.encode(uln);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](5);
        params[0] = SetConfigParam(eid0, RECEIVE_CONFIG_TYPE, encodedUln);
        params[1] = SetConfigParam(eid1, RECEIVE_CONFIG_TYPE, encodedUln);
        params[2] = SetConfigParam(eid2, RECEIVE_CONFIG_TYPE, encodedUln);
        params[3] = SetConfigParam(eid3, RECEIVE_CONFIG_TYPE, encodedUln);
        params[4] = SetConfigParam(eid4, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();
    }

    function deployPOL() public {
        vm.createSelectFork(vm.rpcUrl("pol_mainnet"));
        address endpoint = POL_LZ_ENDPOINT; // Chain B Endpoint
        address oapp = POL_OAPP; // OApp on Chain B
        address receiveLib = POL_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 1, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray1([POL_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        bytes memory encodedUln = abi.encode(uln);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](5);
        params[0] = SetConfigParam(eid0, RECEIVE_CONFIG_TYPE, encodedUln);
        params[1] = SetConfigParam(eid1, RECEIVE_CONFIG_TYPE, encodedUln);
        params[2] = SetConfigParam(eid2, RECEIVE_CONFIG_TYPE, encodedUln);
        params[3] = SetConfigParam(eid3, RECEIVE_CONFIG_TYPE, encodedUln);
        params[4] = SetConfigParam(eid4, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();
    }

    function deployBSC() public {
        vm.createSelectFork(vm.rpcUrl("bsc_mainnet"));
        address endpoint = BSC_LZ_ENDPOINT; // Chain B Endpoint
        address oapp = BSC_OAPP; // OApp on Chain B
        address receiveLib = BSC_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 1, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray1([BSC_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        bytes memory encodedUln = abi.encode(uln);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](5);
        params[0] = SetConfigParam(eid0, RECEIVE_CONFIG_TYPE, encodedUln);
        params[1] = SetConfigParam(eid1, RECEIVE_CONFIG_TYPE, encodedUln);
        params[2] = SetConfigParam(eid2, RECEIVE_CONFIG_TYPE, encodedUln);
        params[3] = SetConfigParam(eid3, RECEIVE_CONFIG_TYPE, encodedUln);
        params[4] = SetConfigParam(eid4, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();
    }
}

// RUN
// forge script SetReceiveConfig --broadcast -vvv
