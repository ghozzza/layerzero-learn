// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {ElevatedMinterBurner} from "../src/ElevatedMinterBurner.sol";
import {MyMintBurnOFTAdapterDecimal0} from "../src/MyMintBurnOFTAdapterDecimal0.sol";
import {MyMintBurnOFTAdapterDecimal2} from "../src/MyMintBurnOFTAdapterDecimal2.sol";
import {IMintableBurnable} from "@layerzerolabs/oft-evm/contracts/interfaces/IMintableBurnable.sol";
import {Helper} from "./Helper.sol";
import {SrcEidLib} from "../src/SrcEidLib.sol";

contract DeployOApp is Script, Helper {
    ElevatedMinterBurner public minterBurner;
    SrcEidLib public srcEidLib;
    MyMintBurnOFTAdapterDecimal0 public oappDecimal0;
    MyMintBurnOFTAdapterDecimal2 public oappDecimal2;

    address owner = vm.envAddress("PUBLIC_KEY");

    function setUp() public {
        // vm.createSelectFork(vm.rpcUrl("arb_sepolia"));
        // vm.createSelectFork(vm.rpcUrl("base_sepolia"));
    }

    function run() public {
        // deployBASE();
        // deployARB();
        // deployKAIA();
        // deployPOL();
        deployBSC();
    }

    function deployBASE() public {
        address endpoint = BASE_LZ_ENDPOINT;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
        vm.startBroadcast(privateKey);
        uint32[] memory srcEids = new uint32[](5);
        srcEids[0] = BASE_EID;
        srcEids[1] = ARB_EID;
        srcEids[2] = KAIA_EID;
        srcEids[3] = POL_EID;
        srcEids[4] = BSC_EID;
        uint8[] memory decimals = new uint8[](5);
        decimals[0] = 2;
        decimals[1] = 2;
        decimals[2] = 2;
        decimals[3] = 0;
        decimals[4] = 0;
        srcEidLib = new SrcEidLib(srcEids, decimals, owner);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(BASE_IDRX), owner);
        oappDecimal2 = new MyMintBurnOFTAdapterDecimal2(
            BASE_IDRX, IMintableBurnable(BASE_IDRX), endpoint, owner, address(srcEidLib)
        );
        minterBurner.setOperator(address(oappDecimal2), true);
        vm.stopBroadcast();

        console.log("address public BASE_OAPP =", address(oappDecimal2), ";");
        console.log("address public BASE_MINTER_BURNER =", address(minterBurner), ";");
    }

    function deployARB() public {
        address endpoint = ARB_LZ_ENDPOINT;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
        vm.startBroadcast(privateKey);
        uint32[] memory srcEids = new uint32[](5);
        srcEids[0] = BASE_EID;
        srcEids[1] = ARB_EID;
        srcEids[2] = KAIA_EID;
        srcEids[3] = POL_EID;
        srcEids[4] = BSC_EID;
        uint8[] memory decimals = new uint8[](5);
        decimals[0] = 2;
        decimals[1] = 2;
        decimals[2] = 2;
        decimals[3] = 0;
        decimals[4] = 0;
        srcEidLib = new SrcEidLib(srcEids, decimals, owner);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(ARB_IDRX), owner);
        oappDecimal2 =
            new MyMintBurnOFTAdapterDecimal2(ARB_IDRX, IMintableBurnable(ARB_IDRX), endpoint, owner, address(srcEidLib));
        minterBurner.setOperator(address(oappDecimal2), true);
        vm.stopBroadcast();

        console.log("address public ARB_OAPP =", address(oappDecimal2), ";");
        console.log("address public ARB_MINTER_BURNER =", address(minterBurner), ";");
    }

    function deployKAIA() public {
        address endpoint = KAIA_LZ_ENDPOINT;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("kaia_mainnet"));
        vm.startBroadcast(privateKey);
        uint32[] memory srcEids = new uint32[](5);
        srcEids[0] = BASE_EID;
        srcEids[1] = ARB_EID;
        srcEids[2] = KAIA_EID;
        srcEids[3] = POL_EID;
        srcEids[4] = BSC_EID;
        uint8[] memory decimals = new uint8[](5);
        decimals[0] = 2;
        decimals[1] = 2;
        decimals[2] = 2;
        decimals[3] = 0;
        decimals[4] = 0;
        srcEidLib = new SrcEidLib(srcEids, decimals, owner);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(KAIA_IDRX), owner);
        oappDecimal2 = new MyMintBurnOFTAdapterDecimal2(
            KAIA_IDRX, IMintableBurnable(KAIA_IDRX), endpoint, owner, address(srcEidLib)
        );
        minterBurner.setOperator(address(oappDecimal2), true);
        vm.stopBroadcast();

        console.log("address public KAIA_OAPP =", address(oappDecimal2), ";");
        console.log("address public KAIA_MINTER_BURNER =", address(minterBurner), ";");
    }

    function deployPOL() public {
        address endpoint = POL_LZ_ENDPOINT;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("pol_mainnet"));
        vm.startBroadcast(privateKey);
        uint32[] memory srcEids = new uint32[](5);
        srcEids[0] = BASE_EID;
        srcEids[1] = ARB_EID;
        srcEids[2] = KAIA_EID;
        srcEids[3] = POL_EID;
        srcEids[4] = BSC_EID;
        uint8[] memory decimals = new uint8[](5);
        decimals[0] = 2;
        decimals[1] = 2;
        decimals[2] = 2;
        decimals[3] = 0;
        decimals[4] = 0;
        srcEidLib = new SrcEidLib(srcEids, decimals, owner);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(POL_IDRX), owner);
        oappDecimal2 =
            new MyMintBurnOFTAdapterDecimal2(POL_IDRX, IMintableBurnable(POL_IDRX), endpoint, owner, address(srcEidLib));
        minterBurner.setOperator(address(oappDecimal2), true);
        vm.stopBroadcast();

        console.log("address public POL_OAPP =", address(oappDecimal2), ";");
        console.log("address public POL_MINTER_BURNER =", address(minterBurner), ";");
    }

    function deployBSC() public {
        address endpoint = BSC_LZ_ENDPOINT;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("bsc_mainnet"));
        vm.startBroadcast(privateKey);
        uint32[] memory srcEids = new uint32[](5);
        srcEids[0] = BASE_EID;
        srcEids[1] = ARB_EID;
        srcEids[2] = KAIA_EID;
        srcEids[3] = POL_EID;
        srcEids[4] = BSC_EID;
        uint8[] memory decimals = new uint8[](5);
        decimals[0] = 2;
        decimals[1] = 2;
        decimals[2] = 2;
        decimals[3] = 0;
        decimals[4] = 0;
        srcEidLib = new SrcEidLib(srcEids, decimals, owner);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(BSC_IDRX), owner);
        oappDecimal2 =
            new MyMintBurnOFTAdapterDecimal2(BSC_IDRX, IMintableBurnable(BSC_IDRX), endpoint, owner, address(srcEidLib));
        minterBurner.setOperator(address(oappDecimal2), true);
        vm.stopBroadcast();

        console.log("address public BSC_OAPP =", address(oappDecimal2), ";");
        console.log("address public BSC_MINTER_BURNER =", address(minterBurner), ";");
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
