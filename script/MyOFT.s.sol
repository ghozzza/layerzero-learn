// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {Helper} from "./Helper.sol";
import {MyOFT} from "../src/MyOFT.sol";
import {MyOApp} from "../src/MyOApp.sol";

contract MyOFTScript is Script, Helper {
    MyOFT public myOFT;
    MyOApp public myOApp;

    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
    }

    function run() public {
        vm.createSelectFork(vm.rpcUrl("base_sepolia"));

        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        myOFT = new MyOFT("MyOFT", "MYOFT", BASE_LZ_ENDPOINT, vm.envAddress("PUBLIC_KEY"));
        address bOFT = address(myOFT);
        console.log("deployed on ChainId: ", block.chainid);
        console.log("deployed on Address: ", address(myOFT));
        vm.stopBroadcast();

        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        vm.startBroadcast(privateKey);

        myOFT = new MyOFT("MyOFT", "MYOFT", ARB_LZ_ENDPOINT, vm.envAddress("PUBLIC_KEY"));
        address aOFT = address(myOFT);
        console.log("deployed on ChainId: ", block.chainid);
        console.log("deployed on Address: ", address(myOFT));
        vm.stopBroadcast();

        console.log("Deployment complete!");
        console.log("Base OFT Address: ", bOFT);
        console.log("Arbitrum OFT Address: ", aOFT);

        console.log("Base OApp Address: ", address(myOApp));
    }

    // RUN
    // forge script MyOFTScript --broadcast -vvv --verify
    //   Base OFT Address:  0xD34D467B53387edb750E484FCfc5E2BB70fd0411
    //   Arbitrum OFT Address:  0x7471a1D2448461278A63e180481898F44B5Fa6d3

    // forge verify-contract 0x2A8106Fadfc5613659781a90903A979290e9104E src/MyOFT.sol:MyOFT \
    //   --chain base-sepolia
    //   --etherscan-api-key $ETHERSCAN_API_KEY \
}
