// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

// import "./IStarknetCore.sol";

contract L1Solution{

    address public STARKNET_CORE = 0xde29d060D45901Fb19ED6C6e959EB22d8626708e;
    uint256 public L2_EVALUATOR_ADDRESS = 0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99;
    
    function consumeMessage(uint _l2WalletAddr) public {
        uint[] memory payload = new uint[](1);
        payload[0] = _l2WalletAddr;

        IStarknetCore(STARKNET_CORE).consumeMessageFromL2(
            uint256(L2_EVALUATOR_ADDRESS),
            payload
        );
    }

}



interface IStarknetCore {
    function sendMessageToL2(
        uint256 to_address,
        uint256 selector,
        uint256[] calldata payload
    ) external returns (bytes32);

    
    function consumeMessageFromL2(
        uint256 fromAddress,
        uint256[] calldata payload
    ) external returns (bytes32);

    function l2ToL1Messages(bytes32 msgHash) external view returns (uint256);
}

