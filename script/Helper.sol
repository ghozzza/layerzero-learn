// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

contract Helper {
    // ***** TESTNET *****
    // address public ARB_LZ_ENDPOINT = 0x6EDCE65403992e310A62460808c4b910D972f10f;
    // address public BASE_LZ_ENDPOINT = 0x6EDCE65403992e310A62460808c4b910D972f10f;

    // address public BASE_SEND_LIB = 0xC1868e054425D378095A003EcbA3823a5D0135C9;
    // address public ARB_SEND_LIB = 0x4f7cd4DA19ABB31b0eC98b9066B9e857B1bf9C0E;

    // address public BASE_RECEIVE_LIB = 0x12523de19dc41c91F7d2093E0CFbB76b17012C8d;
    // address public ARB_RECEIVE_LIB = 0x75Db67CDab2824970131D5aa9CECfC9F69c69636;

    // uint32 public BASE_EID = 40245;
    // uint32 public ARB_EID = 40231;

    // address public BASE_DVN1 = 0xdf04ABb599c7B37dD5FfC0f8E94f6898120874eF; // BitGo
    // address public BASE_DVN2 = 0xe1a12515F9AB2764b887bF60B923Ca494EBbB2d6; // LayerZeroLabs

    // address public ARB_DVN1 = 0x500e6064CB1fE164974CC0a4fe9151928c870BbE; // BitGo
    // address public ARB_DVN2 = 0x53f488E93b4f1b60E8E83aa374dBe1780A1EE8a8; // LayerZeroLabs

    // address public BASE_EXECUTOR = 0x8A3D588D9f6AC041476b094f97FF94ec30169d3D;

    // address public ARB_EXECUTOR = 0x5Df3a1cEbBD9c8BA7F8dF51Fd632A9aef8308897;
    // *******************

    // ***** MAINNET *****
    address public ARB_LZ_ENDPOINT = 0x1a44076050125825900e736c501f859c50fE728c;
    address public BASE_LZ_ENDPOINT = 0x1a44076050125825900e736c501f859c50fE728c;
    address public KAIA_LZ_ENDPOINT = 0x1a44076050125825900e736c501f859c50fE728c;
    address public POL_LZ_ENDPOINT = 0x1a44076050125825900e736c501f859c50fE728c;
    address public BSC_LZ_ENDPOINT = 0x1a44076050125825900e736c501f859c50fE728c;

    address public ARB_SEND_LIB = 0x975bcD720be66659e3EB3C0e4F1866a3020E493A;
    address public BASE_SEND_LIB = 0xB5320B0B3a13cC860893E2Bd79FCd7e13484Dda2;
    address public KAIA_SEND_LIB = 0x9714Ccf1dedeF14BaB5013625DB92746C1358cb4;
    address public POL_SEND_LIB = 0x6c26c61a97006888ea9E4FA36584c7df57Cd9dA3;
    address public BSC_SEND_LIB = 0x9F8C645f2D0b2159767Bd6E0839DE4BE49e823DE;

    address public ARB_RECEIVE_LIB = 0x7B9E184e07a6EE1aC23eAe0fe8D6Be2f663f05e6;
    address public BASE_RECEIVE_LIB = 0xc70AB6f32772f59fBfc23889Caf4Ba3376C84bAf;
    address public KAIA_RECEIVE_LIB = 0x937AbA873827BF883CeD83CA557697427eAA46Ee;
    address public POL_RECEIVE_LIB = 0x1322871e4ab09Bc7f5717189434f97bBD9546e95;
    address public BSC_RECEIVE_LIB = 0x9F8C645f2D0b2159767Bd6E0839DE4BE49e823DE;

    uint32 public ARB_EID = 30110;
    uint32 public BASE_EID = 30184;
    uint32 public KAIA_EID = 30150;
    uint32 public POL_EID = 30109;
    uint32 public BSC_EID = 30102;

    address public ARB_DVN1 = 0x0711dd777AE626ef5E0a4F50e199C7a0E0666857; // BitGo
    address public ARB_DVN2 = 0x2f55C492897526677C5B68fb199ea31E2c126416; // LayerZeroLabs

    address public BASE_DVN1 = 0x133e9fB2D339D8428476A714B1113B024343811E; // BitGo
    address public BASE_DVN2 = 0x9e059a54699a285714207b43B055483E78FAac25; // LayerZeroLabs

    // address public KAIA_DVN1 = 0x28af4dADbc5066e994986E8bb105240023dC44B6; // BCW Group
    address public KAIA_DVN1 = 0x1154d04d07aee26ff2c200bd373eb76a7e5694d6; // Canary
    address public KAIA_DVN2 = 0xc80233AD8251E668BecbC3B0415707fC7075501e; // LayerZeroLabs

    address public POL_DVN1 = 0x02152F4624596602dCBB8B8EAD2988Ad44EDc865; // BitGo
    address public POL_DVN2 = 0x23DE2FE932d9043291f870324B74F820e11dc81A; // LayerZeroLabs

    address public BSC_DVN1 = 0xa2CEB887f545400B8247Dfb7E9cCAda7abAbBDE8; // BitGo
    address public BSC_DVN2 = 0xfD6865c841c2d64565562fCc7e05e619A30615f0; // LayerZeroLabs

    address public ARB_EXECUTOR = 0x31CAe3B7fB82d847621859fb1585353c5720660D;

    address public BASE_EXECUTOR = 0x2CCA08ae69E0C44b18a57Ab2A87644234dAebaE4;

    address public KAIA_EXECUTOR = 0xe149187a987F129FD3d397ED04a60b0b89D1669f;

    address public POL_EXECUTOR = 0xCd3F213AD101472e1713C72B1697E727C803885b;

    address public BSC_EXECUTOR = 0x3ebD570ed38B1b3b4BC886999fcF507e9D584859;

    // ** SELF DEPLOYED Mainnet **
    address public ARB_USDT = 0x881842D66378b06D9CAb6Ab60F57BAeAcE96a6dF;
    address public ARB_IDRX = 0x0646f9BE4d5118765F4edCFa456c2F0d2180bA3c; // done

    address public BASE_USDT = 0xA769d6492d58840fc1DF124fA4fd3a96B5ef0E71;
    address public BASE_IDRX = 0x9ceEf5A1a46d5016226e61535aA52E4101cc9853; // done

    address public KAIA_USDT = 0xA769d6492d58840fc1DF124fA4fd3a96B5ef0E71;
    address public KAIA_IDRX = 0x9ceEf5A1a46d5016226e61535aA52E4101cc9853; // done

    address public POL_USDT = 0xA769d6492d58840fc1DF124fA4fd3a96B5ef0E71;
    address public POL_IDRX = 0x9ceEf5A1a46d5016226e61535aA52E4101cc9853; // done

    address public BSC_USDT = 0xA769d6492d58840fc1DF124fA4fd3a96B5ef0E71;
    address public BSC_IDRX = 0x9ceEf5A1a46d5016226e61535aA52E4101cc9853; // done

    address public BASE_OAPP = 0xb4C0000dba17E1298Eff76F1750C54Dec7967e18;
    address public BASE_MINTER_BURNER = 0x27E2FC01cbe5A211Fa98e5eC25C9A32aAe992b1B; // done

    address public ARB_OAPP = 0x49da57BBA8CF2A3A574EA2eB2d50f29a96d2f377;
    address public ARB_MINTER_BURNER = 0x9234310cC050a8A84ccF7a7421e982c4b648ea7C; // done

    address public KAIA_OAPP = 0xb4C0000dba17E1298Eff76F1750C54Dec7967e18;
    address public KAIA_MINTER_BURNER = 0x27E2FC01cbe5A211Fa98e5eC25C9A32aAe992b1B; // done

    address public POL_OAPP = 0xb4C0000dba17E1298Eff76F1750C54Dec7967e18;
    address public POL_MINTER_BURNER = 0x27E2FC01cbe5A211Fa98e5eC25C9A32aAe992b1B; // done

    address public BSC_OAPP = 0xb4C0000dba17E1298Eff76F1750C54Dec7967e18;
    address public BSC_MINTER_BURNER = 0x27E2FC01cbe5A211Fa98e5eC25C9A32aAe992b1B; // done
        // *******************
        // *******************

    // ** SELF DEPLOYED TESTNET **
    // address public BASE_OAPP = 0x50df5e25AB60e150f753B9444D160a80f0279559;
    // address public ARB_OAPP = 0xb63c53cab400622Bb1E6aD65E098E7faC7CA7e9d;

    // address public BASE_MINTER_BURNER = 0x9A2FC5f9c7F587752b6224aa86A1b159E19ADA23;
    // address public ARB_MINTER_BURNER = 0xfBE9993eb6A2DE7631aF90A9C288624A4553b679;

    // address public BASE_OAPP = 0xEA08358cbd061E8F9bC1dd14aEC530d5Ef943198;
    // address public BASE_MINTER_BURNER = 0x5Be174028c20256068C95b133031BD422FcF2d72;

    // address public ARB_OAPP = 0x2C2E4C8aD8d88663BA8e052c84fB1017224752cF;
    // address public ARB_MINTER_BURNER = 0xAe27f785Fb2cD6d04c2d3D16B1BD1C21d8B4161a;

    // address public BASE_OAPP = 0x3BC24c85aFE8b53368E69dbB74c1130bf4545FB0;
    // address public BASE_MINTER_BURNER = 0x466a36D7B83EA1e6CC08548E71D6e4e611929ef3;

    // address public ARB_OAPP = 0x64001099241E7D98d413dF25B8D6a1C196231117;
    // address public ARB_MINTER_BURNER = 0x88728dFdbd742553DDD005D43D6C8eB19B681118;

    // address public KAIA_OAPP;
    // address public KAIA_MINTER_BURNER;

    // address public POL_OAPP;
    // address public POL_MINTER_BURNER;

    // address public BSC_OAPP;
    // address public BSC_MINTER_BURNER;

    // address public ARB_USDT = 0x9850120Abfa32efc9E345583Bc22A70C07cCC2c9;
    // address public ARB_IDRX = 0xd4221928D1bA8881560da1a528b8495248c5bE46;

    // address public BASE_USDT = 0x0320aC8A299b3da6469bE3Da9ED6c84D09309418;
    // address public BASE_IDRX = 0x47E64F8615718d1A3FA34efe7E7b96aA9ac8B7F4;

    // address public ARB_USDT = 0x8aeC29Ff4bd2b9d226F95BF32A2dF2C2908315da;
    // address public ARB_IDRX = 0xA40Aea01A98e50Cf34A4Ec6fecB79F9fBE8Ae007;

    // address public BASE_USDT = 0x918DB59Ab880Cc3c27d182c813ebE3f400436979;
    // address public BASE_IDRX = 0xE95642E030b5D27d03dd255cC855a576fBc4f83d;

    // address public KAIA_USDT;
    // address public KAIA_IDRX;

    // address public POL_USDT;
    // address public POL_IDRX;

    // address public BSC_USDT;
    // address public BSC_IDRX;
    // *******************
}
