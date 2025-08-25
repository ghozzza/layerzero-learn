// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {MockUSDT} from "../src/MockUSDT.sol";
import {MockIDRX} from "../src/MockIDRX.sol";
import {Helper} from "./Helper.sol";

contract DeployMock is Script, Helper {
    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
    }

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MockUSDT usdt = new MockUSDT();
        MockIDRX idrx = new MockIDRX();
        vm.stopBroadcast();

        console.log("MockUSDT deployed on Address: ", address(usdt));
        console.log("MockIDRX deployed on Address: ", address(idrx));
    }
}
// RUN
// forge script DeployMock --broadcast -vvv --verify