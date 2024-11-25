# Which tx in block 257,343 spends the coinbase output of block 256,128?

BLOCK_HASH=$(bitcoin-cli getblockhash 256128)
# 0000000000000007440fc4df4d953acbf67ad26adb2d7dff7bee90318b41e6c6
COINBASE_TXID=$(bitcoin-cli getblock $BLOCK_HASH | jq -r '.tx[0]')
# 611c5a0972d28e421a2308cb2a2adb8f369bb003b96eb04a3ec781bf295b74bc

BLOCK_HASH=$(bitcoin-cli getblockhash 257343)
# 0000000000000004f3fb306baa0638ffc181bc6b9752f9325612559c04d57bf9
bitcoin-cli getblock $BLOCK_HASH 2 | COINBASE_TXID=$COINBASE_TXID jq -r '.tx[] | select([.vin[].txid == $ENV.COINBASE_TXID] | any) | .txid'
# 90d10b04417f2698fa8fed92ca5c951d26613a1737da69a7450f8c7706ba8783
