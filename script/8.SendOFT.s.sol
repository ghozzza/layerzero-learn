// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import {MyOFT} from "../src/MyOFT.sol";
import {SendParam} from "@layerzerolabs/oft-evm/contracts/interfaces/IOFT.sol";
import {OptionsBuilder} from "@layerzerolabs/oapp-evm/contracts/oapp/libs/OptionsBuilder.sol";
import {MessagingFee} from "@layerzerolabs/oapp-evm/contracts/oapp/OApp.sol";
import {Helper} from "./Helper.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract SendOFT is Script, Helper {
    using OptionsBuilder for bytes;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function addressToBytes32(address _addr) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(_addr)));
    }

    function run() external {
        // Load environment variables
        address oftAddress = BASE_OAPP;
        address toAddress = vm.envAddress("TESTNET_PUBLIC_KEY");
        uint256 tokensToSend = 1_000 * 10 ** IERC20Metadata(BASE_IDRX).decimals();
        uint32 dstEid = ARB_EID;
        uint256 privateKey = vm.envUint("TESTNET_PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        MyOFT oft = MyOFT(oftAddress);

        // Build send parameters
        bytes memory extraOptions = OptionsBuilder.newOptions().addExecutorLzReceiveOption(65000, 0);
        SendParam memory sendParam = SendParam({
            dstEid: dstEid,
            to: addressToBytes32(toAddress),
            amountLD: tokensToSend,
            minAmountLD: tokensToSend * 95 / 100, // 5% slippage tolerance
            extraOptions: extraOptions,
            composeMsg: "",
            oftCmd: ""
        });

        // Get fee quote
        MessagingFee memory fee = oft.quoteSend(sendParam, false);

        console.log("Sending tokens...");
        console.log("Fee amount:", fee.nativeFee);
        console.log("eth before", address(toAddress).balance);
        console.log("IDRX Balance before", IERC20(BASE_IDRX).balanceOf(toAddress));
        // Send tokens
        IERC20(BASE_IDRX).approve(oftAddress, tokensToSend);
        oft.send{value: fee.nativeFee}(sendParam, fee, msg.sender);

        console.log("eth after", address(toAddress).balance);
        console.log("IDRX Balance after", IERC20(BASE_IDRX).balanceOf(toAddress));

        vm.stopBroadcast();
    }
}

// RUN
// forge script SendOFT --broadcast -vvv --verify
// 80430535722449
