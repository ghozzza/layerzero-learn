// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {Helper} from "./Helper.sol";
import {IOFT} from "../src/interfaces/IOFT.sol";
import {OptionsBuilder} from "../lib/devtools/packages/oapp-evm/contracts/oapp/libs/OptionsBuilder.sol";

contract Shortcut_getQuoteFee is Script, Helper {
    using OptionsBuilder for bytes;

    address public myOft = 0x2A8106Fadfc5613659781a90903A979290e9104E;
    uint256 public amount = 1e6;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function run() public view {
        bytes memory options = OptionsBuilder.newOptions().addExecutorLzReceiveOption(200000, 0);
        IOFT.SendParam memory sendParam = IOFT.SendParam({
            dstEid: uint32(421614), // Arbitrum Sepolia
            to: bytes32(uint256(uint160(vm.envAddress("PUBLIC_KEY")))),
            amountLD: amount,
            minAmountLD: amount,
            extraOptions: options,
            composeMsg: "",
            oftCmd: ""
        });

        IOFT.MessagingFee memory fee = IOFT(myOft).quoteSend(sendParam, false);

        console.log("nativeFee: ", fee.nativeFee);
    }

    // RUN
    // forge script Shortcut_getQuoteFee --broadcast -vvv
}
