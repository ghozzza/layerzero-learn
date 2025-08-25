// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {MyOFT} from "../src/MyOFT.sol";
import {MyOFTUSDT} from "../src/MyOFTUSDT.sol";
import {MyOFTIDRX} from "../src/MyOFTIDRX.sol";
import {Helper} from "./Helper.sol";

contract DeployOFT is Script, Helper {
    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function run() public {
        address owner = vm.envAddress("TESTNET_PUBLIC_KEY");
        uint256 privateKey = vm.envUint("TESTNET_PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        vm.startBroadcast(privateKey);
        console.log("deployed on ChainId: ", block.chainid);
        MyOFTUSDT oapp = new MyOFTUSDT("USD Tether", "USDT", owner);
        console.log("USDT deployed on Address: ", address(oapp));
        MyOFTIDRX oapp2 = new MyOFTIDRX("IDRX", "IDRX", owner);
        console.log("IDRX deployed on Address: ", address(oapp2));
        vm.stopBroadcast();

        vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        vm.startBroadcast(privateKey);
        console.log("deployed on ChainId: ", block.chainid);
        MyOFTUSDT oapp3 = new MyOFTUSDT("USD Tether", "USDT", owner);
        console.log("USDT deployed on Address: ", address(oapp3));
        MyOFTIDRX oapp4 = new MyOFTIDRX("IDRX", "IDRX", owner);
        console.log("IDRX deployed on Address: ", address(oapp4));
        vm.stopBroadcast();
    }
}
//   deployed on ChainId:  421614
//   USDT deployed on Address:  0x9850120Abfa32efc9E345583Bc22A70C07cCC2c9
//   IDRX deployed on Address:  0xd4221928D1bA8881560da1a528b8495248c5bE46
//   deployed on ChainId:  84532
//   USDT deployed on Address:  0x0320aC8A299b3da6469bE3Da9ED6c84D09309418
//   IDRX deployed on Address:  0x47E64F8615718d1A3FA34efe7E7b96aA9ac8B7F4
// RUN
// forge script DeployOFT --broadcast -vvv --verify
