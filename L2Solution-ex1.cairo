# ######## Messaging bridge evaluator

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1




#
# Declaring storage vars
# Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
#


@storage_var
func msg_from_l2() -> (msg : felt):
end

#
# Declaring getters
# Public variables should be declared explicitly with a getter
#

@view
func get_msg_from_l2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (_msg:felt):
    let (msg:felt) = msg_from_l2.read()
    return (msg)
end

# ######## External functions
# These functions are callable by other contracts
#

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    return ()
end

@l1_handler
func ex2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    from_address : felt, l2_user : felt
):
    msg_from_l2.write(l2_user)
    return ()
end



@external
func create_l1_nft_message{
    syscall_ptr : felt*, 
    pedersen_ptr : HashBuiltin*, 
    range_check_ptr}(l1_user: felt):
    
    let (message_payload : felt*) = alloc()
    assert message_payload[0] = l1_user
    let l1_contract_address : felt = 0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E
    send_message_to_l1(to_address=l1_contract_address, payload_size=1, payload=message_payload)
    return ()
end
