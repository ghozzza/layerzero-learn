// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {MyOFT} from "../src/MyOFT.sol";
import {Helper} from "./Helper.sol";

contract MintToken is Script, Helper {
    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function run() public {
        vm.startBroadcast(vm.envUint("TESTNET_PRIVATE_KEY"));
        // balance before mint
        console.log("balance before mint: ", MyOFT(BASE_USDT).balanceOf(vm.envAddress("TESTNET_PUBLIC_KEY")));
        console.log("balance before mint: ", MyOFT(BASE_IDRX).balanceOf(vm.envAddress("TESTNET_PUBLIC_KEY")));
        MyOFT(BASE_USDT).mint(vm.envAddress("TESTNET_PUBLIC_KEY"), 10_000e6);
        MyOFT(BASE_IDRX).mint(vm.envAddress("TESTNET_PUBLIC_KEY"), 10_000e6);
        // balance after mint
        console.log("balance after mint: ", MyOFT(BASE_USDT).balanceOf(vm.envAddress("TESTNET_PUBLIC_KEY")));
        console.log("balance after mint: ", MyOFT(BASE_IDRX).balanceOf(vm.envAddress("TESTNET_PUBLIC_KEY")));
        vm.stopBroadcast();
    }
}

// RUN
// forge script MintToken --broadcast -vvv