// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {MyOFTUSDT} from "../src/MyOFTUSDT.sol";
import {MyOFTIDRX2} from "../src/MyOFTIDRX2.sol";
import {MyOFTIDRX0} from "../src/MyOFTIDRX0.sol";
import {Helper} from "./Helper.sol";

contract DeployOFT is Script, Helper {
    address owner = vm.envAddress("PUBLIC_KEY");
    uint256 privateKey = vm.envUint("PRIVATE_KEY");

    function run() public {
        deployARB();
        deployBASE();
        deployKAIA();
        // deployPOL();
        // deployBSC();
    }

    function deployARB() public {
        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
        vm.startBroadcast(privateKey);
        console.log("deployed on ChainId: ", block.chainid);
        MyOFTUSDT oapp = new MyOFTUSDT("USD Tether", "USDT", owner);
        console.log("address public ARB_USDT =", address(oapp), ";");
        MyOFTIDRX2 oapp2 = new MyOFTIDRX2("IDRX", "IDRX", owner);
        console.log("address public ARB_IDRX =", address(oapp2), ";");
        vm.stopBroadcast();
    }

    function deployBASE() public {
        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
        vm.startBroadcast(privateKey);
        console.log("deployed on ChainId: ", block.chainid);
        MyOFTUSDT oapp = new MyOFTUSDT("USD Tether", "USDT", owner);
        console.log("address public BASE_USDT =", address(oapp), ";");
        MyOFTIDRX2 oapp2 = new MyOFTIDRX2("IDRX", "IDRX", owner);
        console.log("address public BASE_IDRX =", address(oapp2), ";");
        vm.stopBroadcast();
    }

    function deployKAIA() public {
        vm.createSelectFork(vm.rpcUrl("kaia_mainnet"));
        vm.startBroadcast(privateKey);
        console.log("deployed on ChainId: ", block.chainid);
        MyOFTUSDT oapp = new MyOFTUSDT("USD Tether", "USDT", owner);
        console.log("address public KAIA_USDT =", address(oapp), ";");
        MyOFTIDRX2 oapp2 = new MyOFTIDRX2("IDRX", "IDRX", owner);
        console.log("address public KAIA_IDRX =", address(oapp2), ";");
        vm.stopBroadcast();
    }

    function deployPOL() public {
        vm.createSelectFork(vm.rpcUrl("pol_mainnet"));
        vm.startBroadcast(privateKey);
        console.log("deployed on ChainId: ", block.chainid);
        MyOFTUSDT oapp = new MyOFTUSDT("USD Tether", "USDT", owner);
        console.log("address public POL_USDT =", address(oapp), ";");
        MyOFTIDRX0 oapp0 = new MyOFTIDRX0("IDRX", "IDRX", owner);
        console.log("address public POL_IDRX =", address(oapp0), ";");
        vm.stopBroadcast();
    }

    function deployBSC() public {
        vm.createSelectFork(vm.rpcUrl("bsc_mainnet"));
        vm.startBroadcast(privateKey);
        console.log("deployed on ChainId: ", block.chainid);
        MyOFTUSDT oapp = new MyOFTUSDT("USD Tether", "USDT", owner);
        console.log("address public BSC_USDT =", address(oapp), ";");
        MyOFTIDRX0 oapp0 = new MyOFTIDRX0("IDRX", "IDRX", owner);
        console.log("address public BSC_IDRX =", address(oapp0), ";");
        vm.stopBroadcast();
    }
}
// PASS TO -> CHAIN_IDRX || CHAIN_USDT
// RUN
// forge script DeployOFT --broadcast -vvv --verify --verifier etherscan --etherscan-api-key $ETHERSCAN_API_KEY
// forge script DeployOFT --broadcast -vvv --verify
