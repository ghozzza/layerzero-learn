// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {ElevatedMinterBurner} from "../src/ElevatedMinterBurner.sol";
import {MyMintBurnOFTAdapter} from "../src/MyMintBurnOFTAdapter.sol";
import {IMintableBurnable} from "@layerzerolabs/oft-evm/contracts/interfaces/IMintableBurnable.sol";
import {Helper} from "./Helper.sol";

contract DeployOApp is Script, Helper {
    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function run() public {
        address endpoint = block.chainid == 421614 ? ARB_LZ_ENDPOINT : BASE_LZ_ENDPOINT;
        address owner = vm.envAddress("TESTNET_PUBLIC_KEY");

        uint256 privateKey = vm.envUint("TESTNET_PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        ElevatedMinterBurner minterBurner = new ElevatedMinterBurner(IMintableBurnable(ARB_IDRX), owner);
        MyMintBurnOFTAdapter oapp = new MyMintBurnOFTAdapter(ARB_IDRX, IMintableBurnable(ARB_IDRX), endpoint, owner);
        minterBurner.setOperator(address(oapp), true);
        vm.stopBroadcast();
        console.log("MinterBurner deployed to:", address(minterBurner));
        console.log("MyOApp deployed to:", address(oapp));
    }

    // RUN
    // forge script DeployOApp --broadcast -vvv --verify
    // (BASE)
    //  MinterBurner deployed to: 0x9A2FC5f9c7F587752b6224aa86A1b159E19ADA23
    //  MyOApp deployed to: 0x50df5e25AB60e150f753B9444D160a80f0279559
    // (ARB)
    //  MinterBurner deployed to: 0xfBE9993eb6A2DE7631aF90A9C288624A4553b679
    //  MyOApp deployed to: 0xb63c53cab400622Bb1E6aD65E098E7faC7CA7e9d
}
