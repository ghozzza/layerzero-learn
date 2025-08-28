// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ILayerZeroEndpointV2} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import {UlnConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/uln/UlnBase.sol";
import {ExecutorConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/SendLibBase.sol";
import {Helper} from "./Helper.sol";

/// @title GetConfigScript
/// @notice Retrieves and logs the current configuration for the OApp.
contract GetConfigScript is Script, Helper {
    // function setUp() public {
    //     vm.createSelectFork(vm.rpcUrl("base_mainnet"));
    // }
    function run() public {
        getConfig(vm.rpcUrl("base_mainnet"), BASE_LZ_ENDPOINT, BASE_OAPP, BASE_SEND_LIB, BASE_EID, 2);
    }

    function getConfig(
        string memory _rpcUrl,
        address _endpoint,
        address _oapp,
        address _lib,
        uint32 _eid,
        uint32 _configType
    ) public {
        // Create a fork from the specified RPC URL.
        vm.createSelectFork(_rpcUrl);
        vm.startBroadcast();

        // Instantiate the LayerZero endpoint.
        ILayerZeroEndpointV2 endpoint = ILayerZeroEndpointV2(_endpoint);
        // Retrieve the raw configuration bytes.
        bytes memory config = endpoint.getConfig(_oapp, _lib, _eid, _configType);

        if (_configType == 1) {
            // Decode the Executor config (configType = 1)
            ExecutorConfig memory execConfig = abi.decode(config, (ExecutorConfig));
            // Log some key configuration parameters.
            console.log("Executor Type:", execConfig.maxMessageSize);
            console.log("Executor Address:", execConfig.executor);
        }

        if (_configType == 2) {
            // Decode the ULN config (configType = 2)
            UlnConfig memory decodedConfig = abi.decode(config, (UlnConfig));
            // Log some key configuration parameters.
            console.log("Confirmations:", decodedConfig.confirmations);
            console.log("Required DVN Count:", decodedConfig.requiredDVNCount);
            for (uint256 i = 0; i < decodedConfig.requiredDVNs.length; i++) {
                console.logAddress(decodedConfig.requiredDVNs[i]);
            }
            console.log("Optional DVN Count:", decodedConfig.optionalDVNCount);
            for (uint256 i = 0; i < decodedConfig.optionalDVNs.length; i++) {
                console.logAddress(decodedConfig.optionalDVNs[i]);
            }
            console.log("Optional DVN Threshold:", decodedConfig.optionalDVNThreshold);
        }
        vm.stopBroadcast();
    }
}

// RUN
// forge script GetConfigScript --broadcast -vvvv
