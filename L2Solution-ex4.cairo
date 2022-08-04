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
func l1_assigned_var_storage() -> (l1_ass: felt):
end

#
# Declaring getters
# Public variables should be declared explicitly with a getter
#


@view
func l1_assigned_var{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (l1_user: felt):
    let (msg:felt) = l1_assigned_var_storage.read()
    return (l1_user = msg)
end


# ######## External functions
# These functions are callable by other contracts
#

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    l1_assigned_var_storage.write(69) 
    return ()
end

@l1_handler 
func receive_msg_l2{
    syscall_ptr : felt*, 
    pedersen_ptr : HashBuiltin*, 
    range_check_ptr}(from_address : felt, rand_value : felt):
    l1_assigned_var_storage.write(rand_value)
    return ()
end