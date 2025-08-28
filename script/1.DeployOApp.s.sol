// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {ElevatedMinterBurner} from "../src/ElevatedMinterBurner.sol";
import {MyMintBurnOFTAdapterDecimal0} from "../src/MyMintBurnOFTAdapterDecimal0.sol";
import {MyMintBurnOFTAdapterDecimal2} from "../src/MyMintBurnOFTAdapterDecimal2.sol";
import {IMintableBurnable} from "@layerzerolabs/oft-evm/contracts/interfaces/IMintableBurnable.sol";
import {Helper} from "./Helper.sol";
import {SrcEidLib} from "../src/SrcEidLib.sol";
import {ISrcEidLib} from "../src/interfaces/ISrcEidLib.sol";

contract DeployOApp is Script, Helper {
    ElevatedMinterBurner public minterBurner;
    SrcEidLib public srcEidLib;
    MyMintBurnOFTAdapterDecimal0 public oappDecimal0;
    MyMintBurnOFTAdapterDecimal2 public oappDecimal2;

    address owner = vm.envAddress("PUBLIC_KEY");

    function run() public {
        // deployBASE();
        // deployARB();
        deployKAIA();
        // deployPOL();
        // deployBSC();
    }

    function srcEidInfo() public view returns (ISrcEidLib.SrcEidInfo[] memory) {
        ISrcEidLib.SrcEidInfo[] memory srcEidInfos = new ISrcEidLib.SrcEidInfo[](5);
        srcEidInfos[0] = ISrcEidLib.SrcEidInfo({eid: BASE_EID, decimals: 2});
        srcEidInfos[1] = ISrcEidLib.SrcEidInfo({eid: ARB_EID, decimals: 2});
        srcEidInfos[2] = ISrcEidLib.SrcEidInfo({eid: KAIA_EID, decimals: 2});
        srcEidInfos[3] = ISrcEidLib.SrcEidInfo({eid: POL_EID, decimals: 0});
        srcEidInfos[4] = ISrcEidLib.SrcEidInfo({eid: BSC_EID, decimals: 0});
        return srcEidInfos;
    }

    function deployBASE() public {
        address endpoint = BASE_LZ_ENDPOINT;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("base_mainnet"));
        vm.startBroadcast(privateKey);
        ISrcEidLib.SrcEidInfo[] memory srcEidInfos = srcEidInfo();
        srcEidLib = new SrcEidLib(srcEidInfos, owner);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(BASE_IDRX), owner);
        oappDecimal2 = new MyMintBurnOFTAdapterDecimal2(
            BASE_IDRX, IMintableBurnable(BASE_IDRX), endpoint, owner, address(srcEidLib)
        );
        minterBurner.setOperator(address(oappDecimal2), true);
        vm.stopBroadcast();

        console.log("address public BASE_SRC_EID_LIB =", address(srcEidLib), ";");
        console.log("address public BASE_OAPP =", address(oappDecimal2), ";");
        console.log("address public BASE_MINTER_BURNER =", address(minterBurner), ";");
    }

    function deployARB() public {
        address endpoint = ARB_LZ_ENDPOINT;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
        vm.startBroadcast(privateKey);
        ISrcEidLib.SrcEidInfo[] memory srcEidInfos = srcEidInfo();
        srcEidLib = new SrcEidLib(srcEidInfos, owner);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(ARB_IDRX), owner);
        oappDecimal2 =
            new MyMintBurnOFTAdapterDecimal2(ARB_IDRX, IMintableBurnable(ARB_IDRX), endpoint, owner, address(srcEidLib));
        minterBurner.setOperator(address(oappDecimal2), true);
        vm.stopBroadcast();

        console.log("address public ARB_SRC_EID_LIB =", address(srcEidLib), ";");
        console.log("address public ARB_OAPP =", address(oappDecimal2), ";");
        console.log("address public ARB_MINTER_BURNER =", address(minterBurner), ";");
    }

    function deployKAIA() public {
        address endpoint = KAIA_LZ_ENDPOINT;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("kaia_mainnet"));
        vm.startBroadcast(privateKey);
        ISrcEidLib.SrcEidInfo[] memory srcEidInfos = srcEidInfo();
        srcEidLib = new SrcEidLib(srcEidInfos, owner);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(KAIA_IDRX), owner);
        oappDecimal2 = new MyMintBurnOFTAdapterDecimal2(
            KAIA_IDRX, IMintableBurnable(KAIA_IDRX), endpoint, owner, address(srcEidLib)
        );
        minterBurner.setOperator(address(oappDecimal2), true);
        vm.stopBroadcast();

        console.log("address public KAIA_SRC_EID_LIB =", address(srcEidLib), ";");
        console.log("address public KAIA_OAPP =", address(oappDecimal2), ";");
        console.log("address public KAIA_MINTER_BURNER =", address(minterBurner), ";");
    }

    function deployPOL() public {
        address endpoint = POL_LZ_ENDPOINT;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("pol_mainnet"));
        vm.startBroadcast(privateKey);
        ISrcEidLib.SrcEidInfo[] memory srcEidInfos = srcEidInfo();
        srcEidLib = new SrcEidLib(srcEidInfos, owner);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(POL_IDRX), owner);
        oappDecimal0 =
            new MyMintBurnOFTAdapterDecimal0(POL_IDRX, IMintableBurnable(POL_IDRX), endpoint, owner, address(srcEidLib));
        minterBurner.setOperator(address(oappDecimal0), true);
        vm.stopBroadcast();

        console.log("address public POL_SRC_EID_LIB =", address(srcEidLib), ";");
        console.log("address public POL_OAPP =", address(oappDecimal0), ";");
        console.log("address public POL_MINTER_BURNER =", address(minterBurner), ";");
    }

    function deployBSC() public {
        address endpoint = BSC_LZ_ENDPOINT;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("bsc_mainnet"));
        vm.startBroadcast(privateKey);
        ISrcEidLib.SrcEidInfo[] memory srcEidInfos = srcEidInfo();
        srcEidLib = new SrcEidLib(srcEidInfos, owner);
        minterBurner = new ElevatedMinterBurner(IMintableBurnable(BSC_IDRX), owner);
        oappDecimal0 =
            new MyMintBurnOFTAdapterDecimal0(BSC_IDRX, IMintableBurnable(BSC_IDRX), endpoint, owner, address(srcEidLib));
        minterBurner.setOperator(address(oappDecimal0), true);
        vm.stopBroadcast();

        console.log("address public BSC_SRC_EID_LIB =", address(srcEidLib), ";");
        console.log("address public BSC_OAPP =", address(oappDecimal0), ";");
        console.log("address public BSC_MINTER_BURNER =", address(minterBurner), ";");
    }
    // RUN
    // forge script DeployOApp --broadcast -vvv --verify --verifier etherscan --etherscan-api-key $ETHERSCAN_API_KEY
    // forge script DeployOApp --broadcast -vvv --verify
}
