// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {IMintableBurnable} from "@layerzerolabs/oft-evm/contracts/interfaces/IMintableBurnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract ElevatedMinterBurner is IMintableBurnable, Ownable {
    IMintableBurnable public immutable TOKEN;
    mapping(address => bool) public operators;

    modifier onlyOperators() {
        _onlyOperators();
        _;
    }

    function _onlyOperators() internal view {
        require(operators[msg.sender] || msg.sender == owner(), "Not authorized");
    }

    constructor(IMintableBurnable _token, address _owner) Ownable(_owner) {
        TOKEN = _token;
    }

    function setOperator(address _operator, bool _status) external onlyOwner {
        operators[_operator] = _status;
    }

    function burn(address _from, uint256 _amount) external override onlyOperators returns (bool) {
        return TOKEN.burn(_from, _amount);
    }

    function mint(address _to, uint256 _amount) external override onlyOperators returns (bool) {
        return TOKEN.mint(_to, _amount);
    }
}
