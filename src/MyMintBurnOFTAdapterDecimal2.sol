// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {MintBurnOFTAdapter} from "@layerzerolabs/oft-evm/contracts/MintBurnOFTAdapter.sol";
import {IMintableBurnable} from "@layerzerolabs/oft-evm/contracts/interfaces/IMintableBurnable.sol";
import {ISrcEidLib} from "./interfaces/ISrcEidLib.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract MyMintBurnOFTAdapterDecimal2 is MintBurnOFTAdapter {
    address srcEidLib;
    address tokenOFT;

    constructor(
        address _token, // Your existing ERC20 token with mint/burn exposed
        IMintableBurnable _minterBurner, // Contract with mint/burn privileges
        address _lzEndpoint, // Local LayerZero endpoint
        address _owner, // Contract owner
        address _srcEidLib // SrcEidLib contract
    ) MintBurnOFTAdapter(_token, _minterBurner, _lzEndpoint, _owner) Ownable(_owner) {
        srcEidLib = _srcEidLib;
        tokenOFT = _token;
    }

    function sharedDecimals() public view override returns (uint8) {
        return 2;
    }

    function setSrcEidLib(address _srcEidLib) public onlyOwner {
        srcEidLib = _srcEidLib;
    }

    function _credit(address _to, uint256 _amountLD, uint32 srcEid)
        internal
        virtual
        override
        returns (uint256 amountReceivedLD)
    {
        if (_to == address(0x0)) _to = address(0xdead); // _mint(...) does not support address(0x0)
        uint256 realizedAmount = (_amountLD * 10 ** IERC20Metadata(tokenOFT).decimals()) / 10 ** ISrcEidLib(srcEidLib).srcDecimals(srcEid);
        minterBurner.mint(_to, realizedAmount);
        // In the case of NON-default OFTAdapter, the amountLD MIGHT not be equal to amountReceivedLD.
        return realizedAmount;
    }
}
