// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {ElevatedMinterBurner} from "../src/ElevatedMinterBurner.sol";
import {MyMintBurnOFTAdapter} from "../src/MyMintBurnOFTAdapter.sol";
import {IMintableBurnable} from "@layerzerolabs/oft-evm/contracts/interfaces/IMintableBurnable.sol";
import {Helper} from "./Helper.sol";

contract DeployOApp is Script, Helper {
    ElevatedMinterBurner public minterBurner;
    MyMintBurnOFTAdapter public oapp;

    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function run() public {
        address endpoint;
        address owner;
        uint256 privateKey;

        vm.createSelectFork(vm.rpcUrl("base_sepolia"));
        endpoint = BASE_LZ_ENDPOINT;
        owner = vm.envAddress("TESTNET_PUBLIC_KEY");

        privateKey = vm.envUint("TESTNET_PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(BASE_IDRX), owner);
        oapp = new MyMintBurnOFTAdapter(BASE_IDRX, IMintableBurnable(BASE_IDRX), endpoint, owner);
        minterBurner.setOperator(address(oapp), true);
        vm.stopBroadcast();
        console.log("=== BASE ===");
        console.log("MinterBurner deployed to:", address(minterBurner));
        console.log("MyOApp deployed to:", address(oapp));

        console.log("============================================================================================");
        console.log("============================================================================================");

        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        endpoint = ARB_LZ_ENDPOINT;
        owner = vm.envAddress("TESTNET_PUBLIC_KEY");

        privateKey = vm.envUint("TESTNET_PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(ARB_IDRX), owner);
        oapp = new MyMintBurnOFTAdapter(ARB_IDRX, IMintableBurnable(ARB_IDRX), endpoint, owner);
        minterBurner.setOperator(address(oapp), true);
        vm.stopBroadcast();
        console.log("=== ARB ===");
        console.log("MinterBurner deployed to:", address(minterBurner));
        console.log("MyOApp deployed to:", address(oapp));
    }

    // RUN
    // forge script DeployOApp --broadcast -vvv --verify --verifier etherscan --etherscan-api-key 285CY8ZFXPCHJA8VEEVHH3HPAHF59D6R1J
    //   === BASE ===
    //   MinterBurner deployed to: 0x466a36D7B83EA1e6CC08548E71D6e4e611929ef3
    //   MyOApp deployed to: 0x3BC24c85aFE8b53368E69dbB74c1130bf4545FB0
    //   ============================================================================================
    //   ============================================================================================
    //   === ARB ===
    //   MinterBurner deployed to: 0x88728dFdbd742553DDD005D43D6C8eB19B681118
    //   MyOApp deployed to: 0x64001099241E7D98d413dF25B8D6a1C196231117
}
