// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Helper} from "./Helper.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract ReadDecimal is Script, Helper {
    function setUp() public {
        // base
        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
    }

    function run() public view {
        console.log("IDRX decimal: ", IERC20Metadata(BASE_IDRX).decimals());
        console.log("USDT decimal: ", IERC20Metadata(BASE_USDT).decimals());
    }
}

// RUN
// forge script ReadDecimal --broadcast -vvv