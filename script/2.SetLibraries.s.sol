// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {ILayerZeroEndpointV2} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import {Helper} from "./Helper.sol";

/// @title LayerZero Library Configuration Script
/// @notice Sets up send and receive libraries for OApp messaging
contract SetLibraries is Script, Helper {
    uint32 dstEid0 = BASE_EID; // Destination chain EID
    uint32 dstEid1 = ARB_EID; // Destination chain EID
    uint32 dstEid2 = KAIA_EID; // Destination chain EID
    uint32 dstEid3 = POL_EID; // Destination chain EID
    uint32 dstEid4 = BSC_EID; // Destination chain EID

    function run() external {
        deployBASE();
        // deployARB();
        // deployKAIA();
        // deployPOL();
        // deployBSC();
    }

    function deployBASE() public {
        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address endpoint = BASE_LZ_ENDPOINT; // LayerZero Endpoint address
        address oapp = BASE_OAPP; // Your OApp contract address
        address sendLib = BASE_SEND_LIB; // SendUln302 address
        address receiveLib = BASE_RECEIVE_LIB; // ReceiveUln302 address
        uint32 srcEid = BASE_EID; // Source chain EID
        uint32 gracePeriod = uint32(0); // Grace period for library switch

        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid1, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid2, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid3, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid4, // Destination chain EID
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

    function deployARB() public {
        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address endpoint = ARB_LZ_ENDPOINT; // LayerZero Endpoint address
        address oapp = ARB_OAPP; // Your OApp contract address
        address sendLib = ARB_SEND_LIB; // SendUln302 address
        address receiveLib = ARB_RECEIVE_LIB; // ReceiveUln302 address
        uint32 srcEid = ARB_EID; // Source chain EID
        uint32 gracePeriod = uint32(0); // Grace period for library switch

        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid0, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid2, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid3, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid4, // Destination chain EID
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

    function deployKAIA() public {
        vm.createSelectFork(vm.rpcUrl("kaia_mainnet"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address endpoint = KAIA_LZ_ENDPOINT; // LayerZero Endpoint address
        address oapp = KAIA_OAPP; // Your OApp contract address
        address sendLib = KAIA_SEND_LIB; // SendUln302 address
        address receiveLib = KAIA_RECEIVE_LIB; // ReceiveUln302 address
        uint32 srcEid = KAIA_EID; // Source chain EID
        uint32 gracePeriod = uint32(0); // Grace period for library switch

        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid0, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid1, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid3, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid4, // Destination chain EID
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

    function deployPOL() public {
        vm.createSelectFork(vm.rpcUrl("pol_mainnet"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address endpoint = POL_LZ_ENDPOINT; // LayerZero Endpoint address
        address oapp = POL_OAPP; // Your OApp contract address
        address sendLib = POL_SEND_LIB; // SendUln302 address
        address receiveLib = POL_RECEIVE_LIB; // ReceiveUln302 address
        uint32 srcEid = POL_EID; // Source chain EID
        uint32 gracePeriod = uint32(0); // Grace period for library switch

        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid0, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid1, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid2, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid4, // Destination chain EID
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

    function deployBSC() public {
        vm.createSelectFork(vm.rpcUrl("bsc_mainnet"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address endpoint = BSC_LZ_ENDPOINT; // LayerZero Endpoint address
        address oapp = BSC_OAPP; // Your OApp contract address
        address sendLib = BSC_SEND_LIB; // SendUln302 address
        address receiveLib = BSC_RECEIVE_LIB; // ReceiveUln302 address
        uint32 srcEid = BSC_EID; // Source chain EID
        uint32 gracePeriod = uint32(0); // Grace period for library switch

        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid0, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid1, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid2, // Destination chain EID
            sendLib // SendUln302 address
        );
        ILayerZeroEndpointV2(endpoint).setSendLibrary(
            oapp, // OApp address
            dstEid3, // Destination chain EID
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
