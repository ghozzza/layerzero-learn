// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {Helper} from "./Helper.sol";
import {MintBurnOFT} from "../src/MintBurnOFT.sol";

contract MintBurnOFTScript is Script, Helper {
    MintBurnOFT public mintBurnOFT;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        // Note: MintBurnOFT requires an existing ERC20 token and minter/burner contract
        // These parameters need to be updated with actual deployed contract addresses
        address existingToken = address(0); // Replace with your ERC20 token address
        address minterBurner = address(0);  // Replace with your minter/burner contract address
        
        // Uncomment and update addresses when ready to deploy:
        // mintBurnOFT = new MintBurnOFT(
        //     existingToken,     // Your existing ERC20 token
        //     IMintableBurnable(minterBurner), // Contract with mint/burn privileges
        //     BASE_LZ_ENDPOINT,  // LayerZero endpoint
        //     vm.envAddress("PUBLIC_KEY") // Owner
        // );

        console.log("MintBurnOFT deployment script ready");
        console.log("Please update existingToken and minterBurner addresses before deployment");
        console.log("ChainId: ", block.chainid);
        vm.stopBroadcast();
    }

    // RUN
    // forge script MintBurnOFTScript --broadcast -vvv --verify
    // Note: Update token and minter addresses before running
}
