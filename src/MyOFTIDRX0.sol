// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @notice Standard ERC-20 token with mint and burn functionality.
contract MyOFTIDRX0 is ERC20, Ownable {
    constructor(string memory _name, string memory _symbol, address _owner) ERC20(_name, _symbol) Ownable(_owner) {}

    function mint(address _to, uint256 _amount) public returns (bool) {
        _mint(_to, _amount);
        return true;
    }

    function burn(address _from, uint256 _amount) public returns (bool) {
        _burn(_from, _amount);
        return true;
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }
}
