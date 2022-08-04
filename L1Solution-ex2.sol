// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./contracts/L1/interfaces/IStarknetCore.sol";


contract L1Solution{

    function ret(uint _l2Address) public pure returns (uint)
    {
        return uint256(uint160(_l2Address));
    }
    
    function solve(address _coreAddress, uint _l2Contract, uint _selectorUint, uint _l2Address) public {
        uint256[] memory payload = new uint256[](1);
        payload[0] = _l2Address;

        IStarknetCore(_coreAddress).sendMessageToL2(
            _l2Contract,
            _selectorUint,
            payload
        );
    }
}


// parameters passed for solving (some params may change based on your wallet address):
// 0xde29d060D45901Fb19ED6C6e959EB22d8626708e, 0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99, 897827374043036985111827446442422621836496526085876968148369565281492581228, 0x06a3b22E6059dd35205B94D2081550d3c9B6D4E59A29aA12D755E4C36bC5378E