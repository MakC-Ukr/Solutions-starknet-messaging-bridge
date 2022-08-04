from starkware.cairo.lang.vm.crypto import pedersen_hash
from starkware.cairo.common.hash_state import compute_hash_on_elements
from starkware.crypto.signature.fast_pedersen_hash import pedersen_hash
from typing import List


def calculate_transaction_hash_common(
    tx_hash_prefix,
    version,
    contract_address,
    entry_point_selector,
    calldata,
    max_fee,
    chain_id,
    additional_data,
    hash_function=pedersen_hash,
) -> int:
    calldata_hash = compute_hash_on_elements(data=calldata, hash_func=hash_function)
    data_to_hash = [
        tx_hash_prefix,
        version,
        contract_address,
        entry_point_selector,
        calldata_hash,
        max_fee,
        chain_id,
        *additional_data,
    ]

    return compute_hash_on_elements(
        data=data_to_hash,
        hash_func=hash_function,
    )


def tx_hash_from_message(
    from_address: str, to_address: int, selector: int, nonce: int, payload: List[int]
) -> str:
    int_hash = calculate_transaction_hash_common(
        tx_hash_prefix=510926345461491391292786,    # int.from_bytes(b"l1_handler", "big")
        version=0,
        contract_address=to_address,
        entry_point_selector=selector,
        calldata=[int(from_address, 16), *payload],
        max_fee=0,
        chain_id=1536727068981429685321,  # StarknetChainId.TESTNET.value
        additional_data=[nonce],
    )
    return hex(int_hash)


print(
    tx_hash_from_message(
        from_address="0x779b989d7358acd6ce64237f16bbef09f35f6ecc",
        to_address=1524569076953457512425355396075576585145183562308719695739798372277154230742,
        selector=1285101517810983806491589552491143496277809242732141897358598292095611420389,
        nonce=69106,
        payload=[
            1393428179030720295440092695193628168230707649901849797435563042612822742693,
            11819812303435348947619,
            0,
        ],
    )
)
