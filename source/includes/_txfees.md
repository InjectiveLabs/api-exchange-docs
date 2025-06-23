# - TXFees

The txfees module for Injective provides the required functionality to support fee market as per EIP-1559.


## GetEipBaseFee

Retrieves the current chain gas price

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/txfees/query/1_GetEipBaseFee.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/txfees/query/1_GetEipBaseFee.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    metadata = await client.fetch_eip_base_fee()
    print(json.dumps(metadata, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/txfees/query/1_GetEipBaseFee/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/txfees/query/1_GetEipBaseFee/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	tmClient, err := rpchttp.New(network.TmEndpoint)
	if err != nil {
		panic(err)
	}

	senderAddress, cosmosKeyring, err := chainclient.InitCosmosKeyring(
		os.Getenv("HOME")+"/.injectived",
		"injectived",
		"file",
		"inj-user",
		"12345678",
		"5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e", // keyring will be used if pk not provided
		false,
	)

	if err != nil {
		panic(err)
	}

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)

	if err != nil {
		panic(err)
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClientV2(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	res, err := chainClient.FetchEipBaseFee(ctx)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
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
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">base_fee</td><td class="type-td td_text">EipBaseFee</td><td class="description-td td_text">The current chain gas price</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**EipBaseFee**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txfees/eipBaseFee.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">base_fee</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The current chain gas price</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
