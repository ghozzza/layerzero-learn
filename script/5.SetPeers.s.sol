// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {MyOApp} from "../src/MyOApp.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero OApp Peer Configuration Script
/// @notice Sets up peer connections between OApp deployments on different chains
contract SetPeers is Script, Helper {

    function run() external {
        deployBASE();
        deployARB();
        deployKAIA();
        deployPOL();
        deployBSC();
    }

    function deployBASE() public {
        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
        // Load environment variables
        address oapp = BASE_OAPP; // Your OApp contract address
        // Example: Set peers for different chains
        // Format: (chain EID, peer address in bytes32)
        (uint32 eid1, bytes32 peer1) = (BASE_EID, bytes32(uint256(uint160(BASE_OAPP))));
        (uint32 eid2, bytes32 peer2) = (ARB_EID, bytes32(uint256(uint160(ARB_OAPP))));
        (uint32 eid3, bytes32 peer3) = (KAIA_EID, bytes32(uint256(uint160(KAIA_OAPP))));
        (uint32 eid4, bytes32 peer4) = (POL_EID, bytes32(uint256(uint160(POL_OAPP))));
        (uint32 eid5, bytes32 peer5) = (BSC_EID, bytes32(uint256(uint160(BSC_OAPP))));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // Set peers for each chain
        MyOApp(oapp).setPeer(eid1, peer1);
        MyOApp(oapp).setPeer(eid2, peer2);
        MyOApp(oapp).setPeer(eid3, peer3);
        MyOApp(oapp).setPeer(eid4, peer4);
        MyOApp(oapp).setPeer(eid5, peer5);
        vm.stopBroadcast();
    }

    function deployARB() public {
        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
        // Load environment variables
        address oapp = ARB_OAPP; // Your OApp contract address
        // Example: Set peers for different chains
        // Format: (chain EID, peer address in bytes32)
        (uint32 eid1, bytes32 peer1) = (BASE_EID, bytes32(uint256(uint160(BASE_OAPP))));
        (uint32 eid2, bytes32 peer2) = (ARB_EID, bytes32(uint256(uint160(ARB_OAPP))));
        (uint32 eid3, bytes32 peer3) = (KAIA_EID, bytes32(uint256(uint160(KAIA_OAPP))));
        (uint32 eid4, bytes32 peer4) = (POL_EID, bytes32(uint256(uint160(POL_OAPP))));
        (uint32 eid5, bytes32 peer5) = (BSC_EID, bytes32(uint256(uint160(BSC_OAPP))));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // Set peers for each chain
        MyOApp(oapp).setPeer(eid1, peer1);
        MyOApp(oapp).setPeer(eid2, peer2);
        MyOApp(oapp).setPeer(eid3, peer3);
        MyOApp(oapp).setPeer(eid4, peer4);
        MyOApp(oapp).setPeer(eid5, peer5);
        vm.stopBroadcast();
    }

    function deployKAIA() public {
        vm.createSelectFork(vm.rpcUrl("kaia_mainnet"));
        // Load environment variables
        address oapp = KAIA_OAPP; // Your OApp contract address
        // Example: Set peers for different chains
        // Format: (chain EID, peer address in bytes32)
        (uint32 eid1, bytes32 peer1) = (BASE_EID, bytes32(uint256(uint160(BASE_OAPP))));
        (uint32 eid2, bytes32 peer2) = (ARB_EID, bytes32(uint256(uint160(ARB_OAPP))));
        (uint32 eid3, bytes32 peer3) = (KAIA_EID, bytes32(uint256(uint160(KAIA_OAPP))));
        (uint32 eid4, bytes32 peer4) = (POL_EID, bytes32(uint256(uint160(POL_OAPP))));
        (uint32 eid5, bytes32 peer5) = (BSC_EID, bytes32(uint256(uint160(BSC_OAPP))));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // Set peers for each chain
        MyOApp(oapp).setPeer(eid1, peer1);
        MyOApp(oapp).setPeer(eid2, peer2);
        MyOApp(oapp).setPeer(eid3, peer3);
        MyOApp(oapp).setPeer(eid4, peer4);
        MyOApp(oapp).setPeer(eid5, peer5);
        vm.stopBroadcast();
    }

    function deployPOL() public {
        vm.createSelectFork(vm.rpcUrl("pol_mainnet"));
        // Load environment variables
        address oapp = POL_OAPP; // Your OApp contract address
        // Example: Set peers for different chains
        // Format: (chain EID, peer address in bytes32)
        (uint32 eid1, bytes32 peer1) = (BASE_EID, bytes32(uint256(uint160(BASE_OAPP))));
        (uint32 eid2, bytes32 peer2) = (ARB_EID, bytes32(uint256(uint160(ARB_OAPP))));
        (uint32 eid3, bytes32 peer3) = (KAIA_EID, bytes32(uint256(uint160(KAIA_OAPP))));
        (uint32 eid4, bytes32 peer4) = (POL_EID, bytes32(uint256(uint160(POL_OAPP))));
        (uint32 eid5, bytes32 peer5) = (BSC_EID, bytes32(uint256(uint160(BSC_OAPP))));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // Set peers for each chain
        MyOApp(oapp).setPeer(eid1, peer1);
        MyOApp(oapp).setPeer(eid2, peer2);
        MyOApp(oapp).setPeer(eid3, peer3);
        MyOApp(oapp).setPeer(eid4, peer4);
        MyOApp(oapp).setPeer(eid5, peer5);
        vm.stopBroadcast();
    }

    function deployBSC() public {
        vm.createSelectFork(vm.rpcUrl("bsc_mainnet"));
        // Load environment variables
        address oapp = BSC_OAPP; // Your OApp contract address
        // Example: Set peers for different chains
        // Format: (chain EID, peer address in bytes32)
        (uint32 eid1, bytes32 peer1) = (BASE_EID, bytes32(uint256(uint160(BASE_OAPP))));
        (uint32 eid2, bytes32 peer2) = (ARB_EID, bytes32(uint256(uint160(ARB_OAPP))));
        (uint32 eid3, bytes32 peer3) = (KAIA_EID, bytes32(uint256(uint160(KAIA_OAPP))));
        (uint32 eid4, bytes32 peer4) = (POL_EID, bytes32(uint256(uint160(POL_OAPP))));
        (uint32 eid5, bytes32 peer5) = (BSC_EID, bytes32(uint256(uint160(BSC_OAPP))));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // Set peers for each chain
        MyOApp(oapp).setPeer(eid1, peer1);
        MyOApp(oapp).setPeer(eid2, peer2);
        MyOApp(oapp).setPeer(eid3, peer3);
        MyOApp(oapp).setPeer(eid4, peer4);
        MyOApp(oapp).setPeer(eid5, peer5);
        vm.stopBroadcast();
    }
}

// RUN
// forge script SetPeers --broadcast -vvv
