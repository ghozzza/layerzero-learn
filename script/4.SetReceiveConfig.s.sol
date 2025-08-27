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
        // vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
    }

    /// @notice Helper function to convert fixed-size array to dynamic array
    function _toDynamicArray(address[2] memory fixedArray) internal pure returns (address[] memory) {
        address[] memory dynamicArray = new address[](2);
        dynamicArray[0] = fixedArray[0];
        dynamicArray[1] = fixedArray[1];
        return dynamicArray;
    }

    function run() external {
        deployBASE();
        // deployARB();
        // deployKAIA();
        // deployPOL();
        // deployBSC();
    }

    function deployBASE() public {
        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
        address endpoint = BASE_LZ_ENDPOINT; // Chain B Endpoint
        address oapp = BASE_OAPP; // OApp on Chain B
        uint32 eid = BASE_EID; // Endpoint ID for Chain A
        address receiveLib = BASE_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 2, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray([BASE_DVN1, BASE_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        bytes memory encodedUln = abi.encode(uln);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](1);
        params[0] = SetConfigParam(eid, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();
    }

    function deployARB() public {
        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
        address endpoint = ARB_LZ_ENDPOINT; // Chain B Endpoint
        address oapp = ARB_OAPP; // OApp on Chain B
        uint32 eid = ARB_EID; // Endpoint ID for Chain A
        address receiveLib = ARB_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 2, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray([ARB_DVN1, ARB_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        bytes memory encodedUln = abi.encode(uln);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](1);
        params[0] = SetConfigParam(eid, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();
    }

    function deployKAIA() public {
        vm.createSelectFork(vm.rpcUrl("kaia_mainnet"));
        address endpoint = KAIA_LZ_ENDPOINT; // Chain B Endpoint
        address oapp = KAIA_OAPP; // OApp on Chain B
        uint32 eid = KAIA_EID; // Endpoint ID for Chain A
        address receiveLib = KAIA_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 2, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray([KAIA_DVN1, KAIA_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        bytes memory encodedUln = abi.encode(uln);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](1);
        params[0] = SetConfigParam(eid, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();
    }

    function deployPOL() public {
        vm.createSelectFork(vm.rpcUrl("pol_mainnet"));
        address endpoint = POL_LZ_ENDPOINT; // Chain B Endpoint
        address oapp = POL_OAPP; // OApp on Chain B
        uint32 eid = POL_EID; // Endpoint ID for Chain A
        address receiveLib = POL_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 2, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray([POL_DVN1, POL_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        bytes memory encodedUln = abi.encode(uln);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](1);
        params[0] = SetConfigParam(eid, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();
    }

    function deployBSC() public {
        vm.createSelectFork(vm.rpcUrl("bsc_mainnet"));
        address endpoint = BSC_LZ_ENDPOINT; // Chain B Endpoint
        address oapp = BSC_OAPP; // OApp on Chain B
        uint32 eid = BSC_EID; // Endpoint ID for Chain A
        address receiveLib = BSC_RECEIVE_LIB; // ReceiveLib for B ← A

        /// @notice UlnConfig controls verification threshold for incoming messages from A to B
        /// @notice Receive config enforces these settings have been applied to the DVNs for messages received from A
        /// @dev 0 values will be interpretted as defaults, so to apply NIL settings, use:
        /// @dev uint8 internal constant NIL_DVN_COUNT = type(uint8).max;
        /// @dev uint64 internal constant NIL_CONFIRMATIONS = type(uint64).max;
        UlnConfig memory uln;
        uln = UlnConfig({
            confirmations: 15, // min block confirmations from source (A)
            requiredDVNCount: 2, // required DVNs for message acceptance
            optionalDVNCount: type(uint8).max, // optional DVNs count
            optionalDVNThreshold: 0, // optional DVN threshold
            requiredDVNs: _toDynamicArray([BSC_DVN1, BSC_DVN2]), // sorted required DVNs
            optionalDVNs: new address[](0) // no optional DVNs
        });
        bytes memory encodedUln = abi.encode(uln);
        SetConfigParam[] memory params;
        params = new SetConfigParam[](1);
        params[0] = SetConfigParam(eid, RECEIVE_CONFIG_TYPE, encodedUln);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ILayerZeroEndpointV2(endpoint).setConfig(oapp, receiveLib, params); // Set config for messages received on B from A
        vm.stopBroadcast();
    }
}

// RUN
// forge script SetReceiveConfig --broadcast -vvv
