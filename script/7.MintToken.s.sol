// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {MyOFT} from "../src/MyOFT.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {Helper} from "./Helper.sol";

contract MintToken is Script, Helper {
    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
    }

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // balance before mint
        console.log("balance before mint: ", MyOFT(BASE_USDT).balanceOf(vm.envAddress("PUBLIC_KEY")));
        console.log("balance before mint: ", MyOFT(BASE_IDRX).balanceOf(vm.envAddress("PUBLIC_KEY")));
        MyOFT(BASE_USDT).mint(vm.envAddress("PUBLIC_KEY"), 10_000 * 10 ** IERC20Metadata(BASE_USDT).decimals());
        MyOFT(BASE_IDRX).mint(vm.envAddress("PUBLIC_KEY"), 10_000 * 10 ** IERC20Metadata(BASE_IDRX).decimals());
        // balance after mint
        console.log("balance after mint: ", MyOFT(BASE_USDT).balanceOf(vm.envAddress("PUBLIC_KEY")));
        console.log("balance after mint: ", MyOFT(BASE_IDRX).balanceOf(vm.envAddress("PUBLIC_KEY")));
        vm.stopBroadcast();
    }
}

// RUN
// forge script MintToken --broadcast -vvv
