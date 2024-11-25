# How many new outputs were created by block 123,456?

BLOCK_HASH=$(bitcoin-cli getblockhash 123456) # 0000000000002917ed80650c6174aac8dfc46f5fe36480aaef682ff6cd83c3ca
bitcoin-cli getblock $BLOCK_HASH 2 |  jq '[.tx[].vout[]] | length'
# 24
