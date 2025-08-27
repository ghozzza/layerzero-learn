// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {MyOFT} from "../src/MyOFT.sol";
import {MyOFTUSDT} from "../src/MyOFTUSDT.sol";
import {MyOFTIDRX2} from "../src/MyOFTIDRX2.sol";
import {Helper} from "./Helper.sol";

contract DeployOFT is Script, Helper {
    address owner = vm.envAddress("PUBLIC_KEY");
    uint256 privateKey = vm.envUint("PRIVATE_KEY");

    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function run() public {
        // deployARB();
        // deployBASE();
        // deployKAIA();
        // deployPOL();
        deployBSC();
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
        MyOFTIDRX2 oapp2 = new MyOFTIDRX2("IDRX", "IDRX", owner);
        console.log("address public POL_IDRX =", address(oapp2), ";");
        vm.stopBroadcast();
    }

    function deployBSC() public {
        vm.createSelectFork(vm.rpcUrl("bsc_mainnet"));
        vm.startBroadcast(privateKey);
        console.log("deployed on ChainId: ", block.chainid);
        MyOFTUSDT oapp = new MyOFTUSDT("USD Tether", "USDT", owner);
        console.log("address public BSC_USDT =", address(oapp), ";");
        MyOFTIDRX2 oapp2 = new MyOFTIDRX2("IDRX", "IDRX", owner);
        console.log("address public BSC_IDRX =", address(oapp2), ";");
        vm.stopBroadcast();
    }
}
// PASS TO -> CHAIN_IDRX || CHAIN_USDT
// RUN
// forge script DeployOFT --broadcast -vvv --verify

// verify
// 0x47E64F8615718d1A3FA34efe7E7b96aA9ac8B7F4

// forge verify-contract 0x47E64F8615718d1A3FA34efe7E7b96aA9ac8B7F4 src/MyOFTIDRX.sol:MyOFTIDRX --chain-id 84532 --etherscan-api-key 285CY8ZFXPCHJA8VEEVHH3HPAHF59D6R1J
// forge verify-contract 0xd4221928D1bA8881560da1a528b8495248c5bE46 src/MyOFTIDRX.sol:MyOFTIDRX --chain-id 421614 --verifier etherscan --etherscan-api-key 285CY8ZFXPCHJA8VEEVHH3HPAHF59D6R1J
