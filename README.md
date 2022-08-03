# StarkNet messaging bridge

Welcome! This is an automated workshop that will explain how to use the StarkNet L1 <-> L2 messaging bridge to create powerful cross layer applications.

It is aimed at developers that:

- Understand Cairo syntax
- Understand the Solidity syntax
- Understand the ERC20 token standard
- Understand the ERC721 standard

# Notes
1. In the payload usually the first element is `payload[0] = uint256(uint160(msg.sender));`
2. `consumeMessageFromL2` reverts if there is no message from L2 as requested in the payload
3. `send_message_to_l1` requires following info: recepient on l1, payload size and the payload. 
4. When `consumeMessageL2` is called, the *StarkNet Core Contract* verifies that the hash corresponds to a stored message and that the caller is indeed the recipient on L1. If yes, the reference count of the message hash in the StarkNet Core Contract decreases by 1.
5. For an `@l1Handler` function, the first parameter is the address of the contract on L1 which sent the message. The payload sent in calldata starts from index = 1. 

### Articles & documentation

- [Messaging Mechanism | StarkNet Docs](https://docs.starknet.io/docs/L1%3C%3EL2%20Communication/messaging-mechanism)
- [Interacting with L1 contracts | StarkNet Documentation](https://starknet.io/docs/hello_starknet/l1l2.html)
- Sample Project: [StarkNet graffiti | GitHub](https://github.com/l-henri/StarkNet-graffiti)
- [Thread on StarkNet ⇄ Ethereum Messaging | Twitter](https://twitter.com/HenriLieutaud/status/1466324729829154822)
