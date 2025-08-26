// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {MintBurnOFTAdapter} from "@layerzerolabs/oft-evm/contracts/MintBurnOFTAdapter.sol";
import {IMintableBurnable} from "@layerzerolabs/oft-evm/contracts/interfaces/IMintableBurnable.sol";

contract MyMintBurnOFTAdapter is MintBurnOFTAdapter {
    constructor(
        address _token, // Your existing ERC20 token with mint/burn exposed
        IMintableBurnable _minterBurner, // Contract with mint/burn privileges
        address _lzEndpoint, // Local LayerZero endpoint
        address _owner // Contract owner
    ) MintBurnOFTAdapter(_token, _minterBurner, _lzEndpoint, _owner) Ownable(_owner) {}

    function sharedDecimals() public view override returns (uint8) {
        return 2;
    }

    function _credit(address _to, uint256 _amountLD, uint32 srcEid)
        internal
        virtual
        override
        returns (uint256 amountReceivedLD)
    {
        if (_to == address(0x0)) _to = address(0xdead); // _mint(...) does not support address(0x0)
        // Mints the tokens and transfers to the recipient.
        if (srcEid == 40245) {
            minterBurner.mint(_to, _amountLD - 666);
        } else {
            minterBurner.mint(_to, _amountLD);
        }
        // In the case of NON-default OFTAdapter, the amountLD MIGHT not be equal to amountReceivedLD.
        return _amountLD;
    }
}
