# - Chain TXFees

The txfees module for Injective provides the required functionality to support fee market as per EIP-1559.


## GetEipBaseFee

Retrieves the current chain gas price

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/txfees/query/1_GetEipBaseFee.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/txfees/query/1_GetEipBaseFee/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters

### Response Parameters
> Response Example:

``` json
{
    "baseFee": {
        "baseFee": "160000000000000000000000000"
    }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txfees/queryEipBaseFeeResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**EipBaseFee**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txfees/eipBaseFee.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->
