// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import { MyOApp } from "../src/MyOApp.sol";
import { EnforcedOptionParam } from "@layerzerolabs/oapp-evm/contracts/oapp/libs/OAppOptionsType3.sol";
import { OptionsBuilder } from "@layerzerolabs/oapp-evm/contracts/oapp/libs/OptionsBuilder.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero OApp Enforced Options Configuration Script
/// @notice Sets enforced execution options for specific message types and destinations
contract SetEnforcedOptions is Script, Helper {
    using OptionsBuilder for bytes;

    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
    }

    function run() external {
        // Load environment variables
        // address oapp = BASE_OAPP;         // Your OApp contract address
        address oapp = ARB_OAPP;         // Your OApp contract address

        // Destination chain configurations
        // uint32 dstEid1 = BASE_EID;    // First destination EID
        // uint32 dstEid2 = ARB_EID;    // Second destination EID
        uint32 dstEid1 = ARB_EID;    // First destination EID
        uint32 dstEid2 = BASE_EID;    // Second destination EID

        // Message type (should match your contract's constant)
        uint16 SEND = 1;  // Message type for sendString function

        // Build options using OptionsBuilder
        bytes memory options1 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(80000, 0);
        bytes memory options2 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(100000, 0);

        // Create enforced options array
        EnforcedOptionParam[] memory enforcedOptions = new EnforcedOptionParam[](2);

        // Set enforced options for first destination
        enforcedOptions[0] = EnforcedOptionParam({
            eid: dstEid1,
            msgType: SEND,
            options: options1
        });

        // Set enforced options for second destination
        enforcedOptions[1] = EnforcedOptionParam({
            eid: dstEid2,
            msgType: SEND,
            options: options2
        });

        vm.startBroadcast(vm.envUint("TESTNET_PRIVATE_KEY"));

        // Set enforced options on the OApp
        MyOApp(oapp).setEnforcedOptions(enforcedOptions);

        vm.stopBroadcast();

        console.log("Enforced options set successfully!");
        console.log("Destination 1 EID:", dstEid1, "Gas:", 80000);
        console.log("Destination 2 EID:", dstEid2, "Gas:", 100000);
    }
}

// RUN
// forge script SetEnforcedOptions --broadcast -vvv