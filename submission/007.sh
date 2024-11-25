# Only one single output remains unspent from block 123,321. What address was it sent to?

BLOCK_HASH=$(bitcoin-cli getblockhash 123321)
# 0000000000005e5c28343b9ffd104931077012d0ce93e57a4a4082771f2de3da

bitcoin-cli getblock $BLOCK_HASH 2 | jq -c -r '.tx[] | .txid as $txid | [.vout[].n] | map({txid: $txid, vout: .}) | .[]' | while read i; do
    TXID=$(echo $i | jq -r '.txid')
    # 097e521fee933133729cfc34424c4277b36240b13ae4b01fda17756da1848c1e

    VOUT=$(echo $i | jq -r '.vout')
    # 0
    
    TXOUT_RESULT=$(bitcoin-cli gettxout $TXID $VOUT)
    if [[ $TXOUT_RESULT ]]; then
        
        echo $TXOUT_RESULT | jq -r '.scriptPubKey.address'
        # 1FPDNNmgwEnKuF7GQzSqUcVQdzSRhz4pgX
    fi
done
