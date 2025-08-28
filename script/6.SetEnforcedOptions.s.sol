// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {MyOApp} from "../src/MyOApp.sol";
import {EnforcedOptionParam} from "@layerzerolabs/oapp-evm/contracts/oapp/libs/OAppOptionsType3.sol";
import {OptionsBuilder} from "@layerzerolabs/oapp-evm/contracts/oapp/libs/OptionsBuilder.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero OApp Enforced Options Configuration Script
/// @notice Sets enforced execution options for specific message types and destinations
contract SetEnforcedOptions is Script, Helper {
    using OptionsBuilder for bytes;

    uint16 SEND = 1; // Message type for sendString function

    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        // vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
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
        // Load environment variables
        address oapp = BASE_OAPP; // Your OApp contract address

        // Destination chain configurations
        uint32 dstEid1 = BASE_EID; // First destination EID
        uint32 dstEid2 = ARB_EID; // Second destination EID
        uint32 dstEid3 = KAIA_EID; // Third destination EID
        uint32 dstEid4 = POL_EID; // Fourth destination EID
        uint32 dstEid5 = BSC_EID; // Fifth destination EID

        // Build options using OptionsBuilder
        bytes memory options1 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(80000, 0);
        bytes memory options2 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(100000, 0);

        // Create enforced options array
        EnforcedOptionParam[] memory enforcedOptions;
        enforcedOptions = new EnforcedOptionParam[](5);
        // Set enforced options for first destination
        enforcedOptions[0] = EnforcedOptionParam({eid: dstEid1, msgType: SEND, options: options1});
        // Set enforced options for second destination
        enforcedOptions[1] = EnforcedOptionParam({eid: dstEid2, msgType: SEND, options: options2});
        // Set enforced options for third destination
        enforcedOptions[2] = EnforcedOptionParam({eid: dstEid3, msgType: SEND, options: options2});
        // Set enforced options for fourth destination
        enforcedOptions[3] = EnforcedOptionParam({eid: dstEid4, msgType: SEND, options: options2});
        // Set enforced options for fifth destination
        enforcedOptions[4] = EnforcedOptionParam({eid: dstEid5, msgType: SEND, options: options2});

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MyOApp(oapp).setEnforcedOptions(enforcedOptions);
        vm.stopBroadcast();

        console.log("deployed on ChainId: ", block.chainid);
        console.log("Enforced options set successfully!");
        console.log("Destination 1 EID:", dstEid1, "Gas:", 80000);
        console.log("Destination 2 EID:", dstEid2, "Gas:", 100000);
        console.log("Destination 3 EID:", dstEid3, "Gas:", 100000);
        console.log("Destination 4 EID:", dstEid4, "Gas:", 100000);
        console.log("Destination 5 EID:", dstEid5, "Gas:", 100000);
    }

    function deployARB() public {
        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
        // Load environment variables
        address oapp = ARB_OAPP; // Your OApp contract address

        // Destination chain configurations
        uint32 dstEid2 = BASE_EID; // First destination EID
        uint32 dstEid1 = ARB_EID; // Second destination EID
        uint32 dstEid3 = KAIA_EID; // Third destination EID
        uint32 dstEid4 = POL_EID; // Fourth destination EID
        uint32 dstEid5 = BSC_EID; // Fifth destination EID

        // Build options using OptionsBuilder
        bytes memory options1 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(80000, 0);
        bytes memory options2 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(100000, 0);

        // Create enforced options array
        EnforcedOptionParam[] memory enforcedOptions;
        enforcedOptions = new EnforcedOptionParam[](5);
        // Set enforced options for first destination
        enforcedOptions[0] = EnforcedOptionParam({eid: dstEid1, msgType: SEND, options: options1});
        // Set enforced options for second destination
        enforcedOptions[1] = EnforcedOptionParam({eid: dstEid2, msgType: SEND, options: options2});
        // Set enforced options for third destination
        enforcedOptions[2] = EnforcedOptionParam({eid: dstEid3, msgType: SEND, options: options2});
        // Set enforced options for fourth destination
        enforcedOptions[3] = EnforcedOptionParam({eid: dstEid4, msgType: SEND, options: options2});
        // Set enforced options for fifth destination
        enforcedOptions[4] = EnforcedOptionParam({eid: dstEid5, msgType: SEND, options: options2});

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MyOApp(oapp).setEnforcedOptions(enforcedOptions);
        vm.stopBroadcast();

        console.log("deployed on ChainId: ", block.chainid);
        console.log("Enforced options set successfully!");
        console.log("Destination 1 EID:", dstEid1, "Gas:", 80000);
        console.log("Destination 2 EID:", dstEid2, "Gas:", 100000);
        console.log("Destination 3 EID:", dstEid3, "Gas:", 100000);
        console.log("Destination 4 EID:", dstEid4, "Gas:", 100000);
        console.log("Destination 5 EID:", dstEid5, "Gas:", 100000);
    }

    function deployKAIA() public {
        vm.createSelectFork(vm.rpcUrl("kaia_mainnet"));
        // Load environment variables
        address oapp = KAIA_OAPP; // Your OApp contract address

        // Destination chain configurations
        uint32 dstEid3 = BASE_EID; // First destination EID
        uint32 dstEid2 = ARB_EID; // Second destination EID
        uint32 dstEid1 = KAIA_EID; // Third destination EID
        uint32 dstEid4 = POL_EID; // Fourth destination EID
        uint32 dstEid5 = BSC_EID; // Fifth destination EID

        // Build options using OptionsBuilder
        bytes memory options1 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(80000, 0);
        bytes memory options2 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(100000, 0);

        // Create enforced options array
        EnforcedOptionParam[] memory enforcedOptions;
        enforcedOptions = new EnforcedOptionParam[](5);
        // Set enforced options for first destination
        enforcedOptions[0] = EnforcedOptionParam({eid: dstEid1, msgType: SEND, options: options1});
        // Set enforced options for second destination
        enforcedOptions[1] = EnforcedOptionParam({eid: dstEid2, msgType: SEND, options: options2});
        // Set enforced options for third destination
        enforcedOptions[2] = EnforcedOptionParam({eid: dstEid3, msgType: SEND, options: options2});
        // Set enforced options for fourth destination
        enforcedOptions[3] = EnforcedOptionParam({eid: dstEid4, msgType: SEND, options: options2});
        // Set enforced options for fifth destination
        enforcedOptions[4] = EnforcedOptionParam({eid: dstEid5, msgType: SEND, options: options2});

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MyOApp(oapp).setEnforcedOptions(enforcedOptions);
        vm.stopBroadcast();

        console.log("deployed on ChainId: ", block.chainid);
        console.log("Enforced options set successfully!");
        console.log("Destination 1 EID:", dstEid1, "Gas:", 80000);
        console.log("Destination 2 EID:", dstEid2, "Gas:", 100000);
        console.log("Destination 3 EID:", dstEid3, "Gas:", 100000);
        console.log("Destination 4 EID:", dstEid4, "Gas:", 100000);
        console.log("Destination 5 EID:", dstEid5, "Gas:", 100000);
    }

    function deployPOL() public {
        vm.createSelectFork(vm.rpcUrl("pol_mainnet"));
        // Load environment variables
        address oapp = POL_OAPP; // Your OApp contract address

        // Destination chain configurations
        uint32 dstEid4 = BASE_EID; // First destination EID
        uint32 dstEid2 = ARB_EID; // Second destination EID
        uint32 dstEid3 = KAIA_EID; // Third destination EID
        uint32 dstEid1 = POL_EID; // Fourth destination EID
        uint32 dstEid5 = BSC_EID; // Fifth destination EID

        // Build options using OptionsBuilder
        bytes memory options1 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(80000, 0);
        bytes memory options2 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(100000, 0);

        // Create enforced options array
        EnforcedOptionParam[] memory enforcedOptions;
        enforcedOptions = new EnforcedOptionParam[](5);
        // Set enforced options for first destination
        enforcedOptions[0] = EnforcedOptionParam({eid: dstEid1, msgType: SEND, options: options1});
        // Set enforced options for second destination
        enforcedOptions[1] = EnforcedOptionParam({eid: dstEid2, msgType: SEND, options: options2});
        // Set enforced options for third destination
        enforcedOptions[2] = EnforcedOptionParam({eid: dstEid3, msgType: SEND, options: options2});
        // Set enforced options for fourth destination
        enforcedOptions[3] = EnforcedOptionParam({eid: dstEid4, msgType: SEND, options: options2});
        // Set enforced options for fifth destination
        enforcedOptions[4] = EnforcedOptionParam({eid: dstEid5, msgType: SEND, options: options2});

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MyOApp(oapp).setEnforcedOptions(enforcedOptions);
        vm.stopBroadcast();

        console.log("deployed on ChainId: ", block.chainid);
        console.log("Enforced options set successfully!");
        console.log("Destination 1 EID:", dstEid1, "Gas:", 80000);
        console.log("Destination 2 EID:", dstEid2, "Gas:", 100000);
        console.log("Destination 3 EID:", dstEid3, "Gas:", 100000);
        console.log("Destination 4 EID:", dstEid4, "Gas:", 100000);
        console.log("Destination 5 EID:", dstEid5, "Gas:", 100000);
    }

    function deployBSC() public {
        vm.createSelectFork(vm.rpcUrl("bsc_mainnet"));
        // Load environment variables
        address oapp = BSC_OAPP; // Your OApp contract address

        // Destination chain configurations
        uint32 dstEid5 = BASE_EID; // First destination EID
        uint32 dstEid2 = ARB_EID; // Second destination EID
        uint32 dstEid3 = KAIA_EID; // Third destination EID
        uint32 dstEid4 = POL_EID; // Fourth destination EID
        uint32 dstEid1 = BSC_EID; // Fifth destination EID

        // Build options using OptionsBuilder
        bytes memory options1 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(80000, 0);
        bytes memory options2 = OptionsBuilder.newOptions().addExecutorLzReceiveOption(100000, 0);

        // Create enforced options array
        EnforcedOptionParam[] memory enforcedOptions;
        enforcedOptions = new EnforcedOptionParam[](5);
        // Set enforced options for first destination
        enforcedOptions[0] = EnforcedOptionParam({eid: dstEid1, msgType: SEND, options: options1});
        // Set enforced options for second destination
        enforcedOptions[1] = EnforcedOptionParam({eid: dstEid2, msgType: SEND, options: options2});
        // Set enforced options for third destination
        enforcedOptions[2] = EnforcedOptionParam({eid: dstEid3, msgType: SEND, options: options2});
        // Set enforced options for fourth destination
        enforcedOptions[3] = EnforcedOptionParam({eid: dstEid4, msgType: SEND, options: options2});
        // Set enforced options for fifth destination
        enforcedOptions[4] = EnforcedOptionParam({eid: dstEid5, msgType: SEND, options: options2});

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MyOApp(oapp).setEnforcedOptions(enforcedOptions);
        vm.stopBroadcast();

        console.log("deployed on ChainId: ", block.chainid);
        console.log("Enforced options set successfully!");
        console.log("Destination 1 EID:", dstEid1, "Gas:", 80000);
        console.log("Destination 2 EID:", dstEid2, "Gas:", 100000);
        console.log("Destination 3 EID:", dstEid3, "Gas:", 100000);
        console.log("Destination 4 EID:", dstEid4, "Gas:", 100000);
        console.log("Destination 5 EID:", dstEid5, "Gas:", 100000);
    }
}

// RUN
// forge script SetEnforcedOptions --broadcast -vvv
