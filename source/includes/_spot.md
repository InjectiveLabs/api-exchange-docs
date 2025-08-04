# - Chain Exchange for Spot
Includes all messages related to spot markets.


## L3SpotOrderBook

Get the level 3 aggregated order book for a spot market

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/64_L3SpotOrderBook.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/64_L3SpotOrderBook.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    orderbook = await client.fetch_l3_spot_orderbook(
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
    )
    print(orderbook)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/64_L3SpotOrderBook/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/64_L3SpotOrderBook/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

	res, err := chainClient.FetchL3SpotOrderbook(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryFullSpotOrderbookRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">market id</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryFullSpotOrderbookResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">Bids</td><td class="type-td td_text">TrimmedLimitOrder array</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">Asks</td><td class="type-td td_text">TrimmedLimitOrder array</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">seq</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the current orderbook sequence number</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/TrimmedLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the subaccount ID</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SpotMarkets

Retrieves a list of spot markets

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/10_SpotMarkets.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/10_SpotMarkets.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    spot_markets = await client.fetch_chain_spot_markets(
        status="Active",
        market_ids=["0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"],
    )
    print(spot_markets)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/10_SpotMarkets/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/10_SpotMarkets/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	status := "Active"
	marketIds := []string{"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"}

	res, err := chainClient.FetchChainSpotMarkets(ctx, status, marketIds)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySpotMarketsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">string</td><td class="description-td td_text">Status of the market, for convenience it is set to string - not enum</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">Filter by market IDs</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
	"markets": [
		{
			"ticker": "INJ/USDT",
			"base_denom": "inj",
			"quote_denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
			"maker_fee_rate": "-0.000100000000000000",
			"taker_fee_rate": "0.000500000000000000",
			"relayer_fee_share_rate": "0.400000000000000000",
			"market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
			"status": 1,
			"min_price_tick_size": "0.001000000000000000",
			"min_quantity_tick_size": "0.001000000000000000",
			"min_notional": "0.000000000001000000",
			"base_decimals": 18,
			"quote_decimals": 6
		}
	]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySpotMarketsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">markets</td><td class="type-td td_text">SpotMarket array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/SpotMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">string</td><td class="description-td td_text">A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.</td></tr>
<tr ><td class="parameter-td td_text">base_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Coin denom used for the base asset</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Coin used for the quote asset</td></tr>
<tr ><td class="parameter-td td_text">maker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">maker_fee_rate defines the fee percentage makers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">taker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">taker_fee_rate defines the fee percentage takers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">relayer_fee_share_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">relayer_fee_share_rate defines the percentage of the transaction fee shared with the relayer in a derivative market</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Unique market ID.</td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">MarketStatus</td><td class="description-td td_text">Status of the market</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_price_tick_size defines the minimum tick size that the price required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_quantity_tick_size defines the minimum tick size of the quantity required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_notional defines the minimum notional (in quote asset) required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">admin</td><td class="type-td td_text">string</td><td class="description-td td_text">current market admin</td></tr>
<tr ><td class="parameter-td td_text">admin_permissions</td><td class="type-td td_text">uint32</td><td class="description-td td_text">level of admin permissions</td></tr>
<tr ><td class="parameter-td td_text">base_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">base token decimals</td></tr>
<tr ><td class="parameter-td td_text">quote_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">quote token decimals</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MarketStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MarketStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Active</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Paused</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Demolished</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Expired</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AdminPermission**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/adminPermission.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">1</td><td class="name-td td_text">Ticker Permission</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Min Price Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Min Quantity Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Min Notional Permission</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">Initial Margin Ratio Permission</td></tr>
<tr ><td class="code-td td_num">32</td><td class="name-td td_text">Maintenance Margin Ratio Permission</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SpotMarket

Retrieves a spot market by ticker

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/11_SpotMarket.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/11_SpotMarket.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    spot_market = await client.fetch_chain_spot_market(
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
    )
    print(spot_market)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/11_SpotMarket/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/11_SpotMarket/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

	res, err := chainClient.FetchChainSpotMarket(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySpotMarketRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Market ID for the market</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
	"market": {
		"ticker": "INJ/USDT",
		"base_denom": "inj",
		"quote_denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
		"maker_fee_rate": "-0.000100000000000000",
		"taker_fee_rate": "0.000500000000000000",
		"relayer_fee_share_rate": "0.400000000000000000",
		"market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
		"status": 1,
		"min_price_tick_size": "0.001000000000000000",
		"min_quantity_tick_size": "0.001000000000000000",
		"min_notional": "0.000000000001000000",
		"base_decimals": 18,
		"quote_decimals": 6
	}
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySpotMarketResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market</td><td class="type-td td_text">SpotMarket</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/SpotMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">string</td><td class="description-td td_text">A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.</td></tr>
<tr ><td class="parameter-td td_text">base_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Coin denom used for the base asset</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Coin used for the quote asset</td></tr>
<tr ><td class="parameter-td td_text">maker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">maker_fee_rate defines the fee percentage makers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">taker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">taker_fee_rate defines the fee percentage takers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">relayer_fee_share_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">relayer_fee_share_rate defines the percentage of the transaction fee shared with the relayer in a derivative market</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Unique market ID.</td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">MarketStatus</td><td class="description-td td_text">Status of the market</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_price_tick_size defines the minimum tick size that the price required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_quantity_tick_size defines the minimum tick size of the quantity required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_notional defines the minimum notional (in quote asset) required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">admin</td><td class="type-td td_text">string</td><td class="description-td td_text">current market admin</td></tr>
<tr ><td class="parameter-td td_text">admin_permissions</td><td class="type-td td_text">uint32</td><td class="description-td td_text">level of admin permissions</td></tr>
<tr ><td class="parameter-td td_text">base_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">base token decimals</td></tr>
<tr ><td class="parameter-td td_text">quote_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">quote token decimals</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MarketStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MarketStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Active</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Paused</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Demolished</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Expired</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AdminPermission**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/adminPermission.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">1</td><td class="name-td td_text">Ticker Permission</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Min Price Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Min Quantity Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Min Notional Permission</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">Initial Margin Ratio Permission</td></tr>
<tr ><td class="code-td td_num">32</td><td class="name-td td_text">Maintenance Margin Ratio Permission</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## FullSpotMarkets

Retrieves a list of spot markets with extra information

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/12_FullSpotMarkets.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/12_FullSpotMarkets.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    spot_markets = await client.fetch_chain_full_spot_markets(
        status="Active",
        market_ids=["0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"],
        with_mid_price_and_tob=True,
    )
    print(spot_markets)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/12_FullSpotMarkets/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/12_FullSpotMarkets/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	status := "Active"
	marketIds := []string{"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"}
	withMidPriceAndTob := true

	res, err := chainClient.FetchChainFullSpotMarkets(ctx, status, marketIds, withMidPriceAndTob)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryFullSpotMarketsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">string</td><td class="description-td td_text">Status of the market, for convenience it is set to string - not enum</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">Filter by market IDs</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">with_mid_price_and_tob</td><td class="type-td td_text">bool</td><td class="description-td td_text">Flag to return the markets mid price and top of the book buy and sell orders.</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
	"markets": [
		{
			"market": {
				"ticker": "INJ/USDT",
				"base_denom": "inj",
				"quote_denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
				"maker_fee_rate": "-0.000100000000000000",
				"taker_fee_rate": "0.000500000000000000",
				"relayer_fee_share_rate": "0.400000000000000000",
				"market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
				"status": 1,
				"min_price_tick_size": "0.001000000000000000",
				"min_quantity_tick_size": "0.001000000000000000",
				"min_notional": "0.000000000001000000",
				"base_decimals": 18,
				"quote_decimals": 6
			},
			"mid_price_and_tob": {
				"mid_price": "29.433500000000000000",
				"best_buy_price": "29.414000000000000000",
				"best_sell_price": "29.453000000000000000"
			}
		}
	]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryFullSpotMarketsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">markets</td><td class="type-td td_text">FullSpotMarket array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**FullSpotMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/FullSpotMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market</td><td class="type-td td_text">SpotMarket</td><td class="description-td td_text">spot market details</td></tr>
<tr ><td class="parameter-td td_text">mid_price_and_tob</td><td class="type-td td_text">MidPriceAndTOB</td><td class="description-td td_text">mid_price_and_tob defines the mid price for this market and the best ask and bid orders</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/SpotMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">string</td><td class="description-td td_text">A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.</td></tr>
<tr ><td class="parameter-td td_text">base_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Coin denom used for the base asset</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Coin used for the quote asset</td></tr>
<tr ><td class="parameter-td td_text">maker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">maker_fee_rate defines the fee percentage makers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">taker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">taker_fee_rate defines the fee percentage takers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">relayer_fee_share_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">relayer_fee_share_rate defines the percentage of the transaction fee shared with the relayer in a derivative market</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Unique market ID.</td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">MarketStatus</td><td class="description-td td_text">Status of the market</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_price_tick_size defines the minimum tick size that the price required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_quantity_tick_size defines the minimum tick size of the quantity required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_notional defines the minimum notional (in quote asset) required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">admin</td><td class="type-td td_text">string</td><td class="description-td td_text">current market admin</td></tr>
<tr ><td class="parameter-td td_text">admin_permissions</td><td class="type-td td_text">uint32</td><td class="description-td td_text">level of admin permissions</td></tr>
<tr ><td class="parameter-td td_text">base_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">base token decimals</td></tr>
<tr ><td class="parameter-td td_text">quote_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">quote token decimals</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MarketStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MarketStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Active</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Paused</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Demolished</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Expired</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MidPriceAndTOB**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MidPriceAndTOB.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">mid_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">mid price of the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">best_buy_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">best buy price of the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">best_sell_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">best sell price of the market (in human readable format)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AdminPermission**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/adminPermission.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">1</td><td class="name-td td_text">Ticker Permission</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Min Price Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Min Quantity Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Min Notional Permission</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">Initial Margin Ratio Permission</td></tr>
<tr ><td class="code-td td_num">32</td><td class="name-td td_text">Maintenance Margin Ratio Permission</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## FullSpotMarket

Retrieves a spot market with extra information

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/13_FullSpotMarket.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/13_FullSpotMarket.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    spot_market = await client.fetch_chain_full_spot_market(
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        with_mid_price_and_tob=True,
    )
    print(spot_market)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/13_FullSpotMarket/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/13_FullSpotMarket/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	withMidPriceAndTob := true

	res, err := chainClient.FetchChainFullSpotMarket(ctx, marketId, withMidPriceAndTob)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryFullSpotMarketRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Market ID for the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">with_mid_price_and_tob</td><td class="type-td td_text">bool</td><td class="description-td td_text">Flag to return the markets mid price and top of the book buy and sell orders.</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
	"market": {
		"market": {
			"ticker": "INJ/USDT",
			"base_denom": "inj",
			"quote_denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
			"maker_fee_rate": "-0.000100000000000000",
			"taker_fee_rate": "0.000500000000000000",
			"relayer_fee_share_rate": "0.400000000000000000",
			"market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
			"status": 1,
			"min_price_tick_size": "0.001000000000000000",
			"min_quantity_tick_size": "0.001000000000000000",
			"min_notional": "0.000000000001000000",
			"base_decimals": 18,
			"quote_decimals": 6
		},
		"mid_price_and_tob": {
			"mid_price": "29.433500000000000000",
			"best_buy_price": "29.414000000000000000",
			"best_sell_price": "29.453000000000000000"
		}
	}
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryFullSpotMarketResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market</td><td class="type-td td_text">FullSpotMarket</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**FullSpotMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/FullSpotMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market</td><td class="type-td td_text">SpotMarket</td><td class="description-td td_text">spot market details</td></tr>
<tr ><td class="parameter-td td_text">mid_price_and_tob</td><td class="type-td td_text">MidPriceAndTOB</td><td class="description-td td_text">mid_price_and_tob defines the mid price for this market and the best ask and bid orders</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/SpotMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">string</td><td class="description-td td_text">A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.</td></tr>
<tr ><td class="parameter-td td_text">base_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Coin denom used for the base asset</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Coin used for the quote asset</td></tr>
<tr ><td class="parameter-td td_text">maker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">maker_fee_rate defines the fee percentage makers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">taker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">taker_fee_rate defines the fee percentage takers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">relayer_fee_share_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">relayer_fee_share_rate defines the percentage of the transaction fee shared with the relayer in a derivative market</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Unique market ID.</td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">MarketStatus</td><td class="description-td td_text">Status of the market</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_price_tick_size defines the minimum tick size that the price required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_quantity_tick_size defines the minimum tick size of the quantity required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_notional defines the minimum notional (in quote asset) required for orders in the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">admin</td><td class="type-td td_text">string</td><td class="description-td td_text">current market admin</td></tr>
<tr ><td class="parameter-td td_text">admin_permissions</td><td class="type-td td_text">uint32</td><td class="description-td td_text">level of admin permissions</td></tr>
<tr ><td class="parameter-td td_text">base_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">base token decimals</td></tr>
<tr ><td class="parameter-td td_text">quote_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">quote token decimals</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MarketStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MarketStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Active</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Paused</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Demolished</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Expired</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MidPriceAndTOB**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MidPriceAndTOB.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">mid_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">mid price of the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">best_buy_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">best buy price of the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">best_sell_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">best sell price of the market (in human readable format)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AdminPermission**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/adminPermission.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">1</td><td class="name-td td_text">Ticker Permission</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Min Price Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Min Quantity Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Min Notional Permission</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">Initial Margin Ratio Permission</td></tr>
<tr ><td class="code-td td_num">32</td><td class="name-td td_text">Maintenance Margin Ratio Permission</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SpotOrderBook

Retrieves a spot market's orderbook by marketID

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/14_SpotOrderbook.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/14_SpotOrderbook.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    pagination = PaginationOption(limit=2)

    orderbook = await client.fetch_chain_spot_orderbook(
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        order_side="Buy",
        pagination=pagination,
    )
    print(orderbook)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/14_SpotOrderbook/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/14_SpotOrderbook/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"cosmossdk.io/math"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	v2 "github.com/InjectiveLabs/sdk-go/chain/exchange/types/v2"
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	limit := uint64(2)
	orderSide := v2.OrderSide_Buy
	limitCumulativeNotional := math.LegacyDec{}
	limitCumulativeQuantity := math.LegacyDec{}

	res, err := chainClient.FetchChainSpotOrderbook(ctx, marketId, limit, orderSide, limitCumulativeNotional, limitCumulativeQuantity)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySpotOrderbookRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Market ID for the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">limit</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the maximum number of orderbook entries to return per side (optional)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">order_side</td><td class="type-td td_text">OrderSide</td><td class="description-td td_text">the order side to return the orderbook entries for (optional)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">limit_cumulative_notional</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">limits the number of entries to return per side based on the cumulative notional (in human readable format)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">limit_cumulative_quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">limits the number of entries to return per side based on the cumulative quantity (in human readable format)</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderSide**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderSide.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Side_Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Buy</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Sell</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
    "buysPriceLevel": [
        {
            "p": "29.414",
            "q": "27.651"
        },
        {
            "p": "29.394",
            "q": "27.714"
        }
    ],
    "sellsPriceLevel": []
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySpotOrderbookResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">buys_price_level</td><td class="type-td td_text">Level array</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">sells_price_level</td><td class="type-td td_text">Level array</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">seq</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the current orderbook sequence number</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Level**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/Level.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">p</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">q</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity (in human readable format)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## TraderSpotOrders

Retrieves a trader's spot orders

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/15_TraderSpotOrders.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/15_TraderSpotOrders.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    subaccount_id = address.get_subaccount_id(index=0)

    orders = await client.fetch_chain_trader_spot_orders(
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        subaccount_id=subaccount_id,
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/15_TraderSpotOrders/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/15_TraderSpotOrders/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	subaccountId := chainClient.Subaccount(senderAddress, 0)

	res, err := chainClient.FetchChainTraderSpotOrders(ctx, marketId, subaccountId.Hex())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryTraderSpotOrdersRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Market ID for the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">SubaccountID of the trader</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
	"orders": [
		{
			"price": "21.000000000000000000",
			"quantity": "2.000000000000000000",
			"fillable": "2.000000000000000000",
			"isBuy": true,
			"order_hash": "0x4a547afd5fbe957223afdce1eef3a11a3e09be114310323b510dcc79dc18aca7"
		}
	]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryTraderSpotOrdersResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">orders</td><td class="type-td td_text">TrimmedSpotLimitOrder array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedSpotLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/TrimmedSpotLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">fillable</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the amount of the quantity remaining fillable (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">isBuy</td><td class="type-td td_text">bool</td><td class="description-td td_text">true if the order is a buy</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash (optional)</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID (optional)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## AccountAddressSpotOrders

Retrieves all account address spot orders

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/16_AccountAddressSpotOrders.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/16_AccountAddressSpotOrders.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    orders = await client.fetch_chain_account_address_spot_orders(
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        account_address=address.to_acc_bech32(),
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/16_AccountAddressSpotOrders/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/16_AccountAddressSpotOrders/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

	res, err := chainClient.FetchChainAccountAddressSpotOrders(ctx, marketId, senderAddress.String())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryAccountAddressSpotOrdersRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Market ID for the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">string</td><td class="description-td td_text">Account address of the trader</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
	"orders": [
		{
			"price": "21.000000000000000000",
			"quantity": "2.000000000000000000",
			"fillable": "2.000000000000000000",
			"isBuy": true,
			"order_hash": "0x4a547afd5fbe957223afdce1eef3a11a3e09be114310323b510dcc79dc18aca7"
		}
	]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryAccountAddressSpotOrdersResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">orders</td><td class="type-td td_text">TrimmedSpotLimitOrder array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedSpotLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/TrimmedSpotLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">fillable</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the amount of the quantity remaining fillable (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">isBuy</td><td class="type-td td_text">bool</td><td class="description-td td_text">true if the order is a buy</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash (optional)</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID (optional)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SpotOrdersByHashes

Retrieves spot orders corresponding to specified order hashes for a given subaccount ID and market ID

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/17_SpotOrdersByHashes.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/17_SpotOrdersByHashes.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    subaccount_id = address.get_subaccount_id(index=0)

    orders = await client.fetch_chain_spot_orders_by_hashes(
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        subaccount_id=subaccount_id,
        order_hashes=["0x57a01cd26f1e2080860af3264e865d7c9c034a701e30946d01c1dc7a303cf2c1"],
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/17_SpotOrdersByHashes/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/17_SpotOrdersByHashes/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	subaccountId := chainClient.Subaccount(senderAddress, 0)
	orderHashes := []string{"0x57a01cd26f1e2080860af3264e865d7c9c034a701e30946d01c1dc7a303cf2c1"}

	res, err := chainClient.FetchChainSpotOrdersByHashes(ctx, marketId, subaccountId.Hex(), orderHashes)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySpotOrdersByHashesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Market ID for the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">SubaccountID of the trader</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_hashes</td><td class="type-td td_text">string array</td><td class="description-td td_text">the order hashes</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
	"orders": [
		{
			"price": "21.000000000000000000",
			"quantity": "2.000000000000000000",
			"fillable": "2.000000000000000000",
			"isBuy": true,
			"order_hash": "0x57a01cd26f1e2080860af3264e865d7c9c034a701e30946d01c1dc7a303cf2c1"
		}
	]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySpotOrdersByHashesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">orders</td><td class="type-td td_text">TrimmedSpotLimitOrder array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedSpotLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/TrimmedSpotLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">fillable</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the amount of the quantity remaining fillable (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">isBuy</td><td class="type-td td_text">bool</td><td class="description-td td_text">true if the order is a buy</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash (optional)</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID (optional)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## TraderSpotTransientOrders

Retrieves a trader's transient spot orders

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/19_TraderSpotTransientOrders.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/19_TraderSpotTransientOrders.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    subaccount_id = address.get_subaccount_id(index=0)

    orders = await client.fetch_chain_trader_spot_transient_orders(
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        subaccount_id=subaccount_id,
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/19_TraderSpotTransientOrders/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/19_TraderSpotTransientOrders/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	subaccountId := chainClient.Subaccount(senderAddress, 0)

	res, err := chainClient.FetchChainTraderSpotTransientOrders(ctx, marketId, subaccountId.Hex())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryTraderSpotOrdersRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Market ID for the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">SubaccountID of the trader</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
	"orders": [
		{
			"price": "21.000000000000000000",
			"quantity": "2.000000000000000000",
			"fillable": "2.000000000000000000",
			"isBuy": true,
			"order_hash": "0x57a01cd26f1e2080860af3264e865d7c9c034a701e30946d01c1dc7a303cf2c1"
		}
	]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryTraderSpotOrdersResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">orders</td><td class="type-td td_text">TrimmedSpotLimitOrder array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedSpotLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/TrimmedSpotLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">fillable</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the amount of the quantity remaining fillable (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">isBuy</td><td class="type-td td_text">bool</td><td class="description-td td_text">true if the order is a buy</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash (optional)</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID (optional)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SpotMidPriceAndTOB

Retrieves a spot market's mid-price

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/query/20_SpotMidPriceAndTOB.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/query/20_SpotMidPriceAndTOB.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    prices = await client.fetch_spot_mid_price_and_tob(
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
    )
    print(prices)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/query/20_SpotMidPriceAndTOB/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/query/20_SpotMidPriceAndTOB/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

	res, err := chainClient.FetchSpotMidPriceAndTOB(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySpotMidPriceAndTOBRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Market ID for the market</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
    "midPrice": "29.4335",
    "bestBuyPrice": "29.414",
    "bestSellPrice": "29.453"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySpotMidPriceAndTOBResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">mid_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">mid price of the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">best_buy_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">best buy price of the market (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">best_sell_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">best sell price of the market</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgInstantSpotMarketLaunch

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/3_MsgInstantSpotMarketLaunch.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/3_MsgInstantSpotMarketLaunch.py -->
```py
import asyncio
import json
import os
from decimal import Decimal

import dotenv

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    await client.initialize_tokens_from_chain_denoms()
    composer = await client.composer()

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=configured_private_key,
        gas_price=gas_price,
        client=client,
        composer=composer,
    )

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    message = composer.msg_instant_spot_market_launch(
        sender=address.to_acc_bech32(),
        ticker="INJ/USDC",
        base_denom="inj",
        quote_denom="factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/usdc",
        min_price_tick_size=Decimal("0.001"),
        min_quantity_tick_size=Decimal("0.01"),
        min_notional=Decimal("1"),
        base_decimals=18,
        quote_decimals=6,
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(json.dumps(result, indent=2))

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)
    message_broadcaster.update_gas_price(gas_price=gas_price)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/3_MsgInstantSpotMarketLaunch/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/3_MsgInstantSpotMarketLaunch/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	"cosmossdk.io/math"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	exchangev2types "github.com/InjectiveLabs/sdk-go/chain/exchange/types/v2"
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
	)
	if err != nil {
		panic(err)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	gasPrice := chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)

	minPriceTickSize := math.LegacyMustNewDecFromStr("0.01")
	minQuantityTickSize := math.LegacyMustNewDecFromStr("0.001")
	minNotional := math.LegacyMustNewDecFromStr("1")

	msg := &exchangev2types.MsgInstantSpotMarketLaunch{
		Sender:              senderAddress.String(),
		Ticker:              "INJ/USDC",
		BaseDenom:           "inj",
		QuoteDenom:          "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/usdc",
		MinPriceTickSize:    minPriceTickSize,
		MinQuantityTickSize: minQuantityTickSize,
		MinNotional:         minNotional,
		BaseDecimals:        18,
		QuoteDecimals:       6,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(ctx, msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", "\t")
	fmt.Print(string(str))

	gasPrice = chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgInstantSpotMarketLaunch.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">the sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">string</td><td class="description-td td_text">Ticker for the spot market.</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">base_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">type of coin to use as the base currency</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">type of coin to use as the quote currency</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_price_tick_size defines the minimum tick size of the order's price (in human readable format)</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_quantity_tick_size defines the minimum tick size of the order's quantity (in human readable format)</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_notional defines the minimum notional (in quote asset) required for orders in the market (in human readable format)</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">base_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">base token decimals</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quote_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">quote token decimals</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/BroadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tx_response</td><td class="type-td td_text">types.TxResponse</td><td class="description-td td_text">tx_response is the queried TxResponses.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/TxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">int64</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">txhash</td><td class="type-td td_text">string</td><td class="description-td td_text">The transaction hash.</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">string</td><td class="description-td td_text">Namespace for the Code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Response code.</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">string</td><td class="description-td td_text">Result bytes, if any.</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">string</td><td class="description-td td_text">The output of the application's logger (raw string). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLogs</td><td class="description-td td_text">The output of the application's logger (typed). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">string</td><td class="description-td td_text">Additional information. May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas requested for transaction.</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas consumed by transaction.</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">types.Any</td><td class="description-td td_text">The request transaction bytes.</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">string</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time.</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">v1.Event array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.  Since: cosmos-sdk 0.42.11, 0.44.5, 0.45</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/ABCIMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">uint32</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvents</td><td class="description-td td_text">Events contains a slice of Event objects that were emitted during some execution.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgCreateSpotLimitOrder

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/6_MsgCreateSpotLimitOrder.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/6_MsgCreateSpotLimitOrder.py -->
```py
import asyncio
import json
import os
import uuid
from decimal import Decimal

import dotenv

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=configured_private_key,
        gas_price=gas_price,
        client=client,
        composer=composer,
    )

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    cid = str(uuid.uuid4())

    # prepare tx msg
    msg = composer.msg_create_spot_limit_order(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=Decimal("7.523"),
        quantity=Decimal("0.01"),
        order_type="BUY",
        cid=cid,
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([msg])
    print("---Transaction Response---")
    print(json.dumps(result, indent=2))

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)
    message_broadcaster.update_gas_price(gas_price=gas_price)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/6_MsgCreateSpotLimitOrder/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/6_MsgCreateSpotLimitOrder/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	txtypes "github.com/cosmos/cosmos-sdk/types/tx"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"

	exchangev2types "github.com/InjectiveLabs/sdk-go/chain/exchange/types/v2"
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
		fmt.Println(err)
		return
	}
	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClientV2(
		clientCtx,
		network,
	)

	if err != nil {
		panic(err)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	gasPrice := chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)

	defaultSubaccountID := chainClient.DefaultSubaccount(senderAddress)

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

	amount := decimal.NewFromFloat(2)
	price := decimal.NewFromFloat(22.55)

	order := chainClient.CreateSpotOrderV2(
		defaultSubaccountID,
		&chainclient.SpotOrderData{
			OrderType:    int32(exchangev2types.OrderType_BUY), //BUY SELL BUY_PO SELL_PO
			Quantity:     amount,
			Price:        price,
			FeeRecipient: senderAddress.String(),
			MarketId:     marketId,
			Cid:          uuid.NewString(),
		},
	)

	msg := exchangev2types.MsgCreateSpotLimitOrder{
		Sender: senderAddress.String(),
		Order:  *order,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	_, response, err := chainClient.BroadcastMsg(ctx, txtypes.BroadcastMode_BROADCAST_MODE_SYNC, &msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", "\t")
	fmt.Print(string(str))

	gasPrice = chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgCreateSpotLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">the sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">SpotOrder</td><td class="description-td td_text">the order details</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/SpotOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">market_id represents the unique ID of the market</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">order_info contains the information of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">order types</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">trigger_price is the trigger price used by stop/take orders (in human readable format) (optional)</td></tr>
<tr ><td class="parameter-td td_text">expiration_block</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration block is the block number at which the order will expire</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">bytes32 subaccount ID that created the order</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient</td><td class="type-td td_text">string</td><td class="description-td td_text">address fee_recipient address that will receive fees for the order</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID (optional)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">BUY</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">SELL</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STOP_BUY</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STOP_SELL</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">TAKE_BUY</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">TAKE_SELL</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">BUY_PO</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SELL_PO</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">BUY_ATOMIC</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">SELL_ATOMIC</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
---Simulation Response---
[order_hash: "0xee49d8060469fd6824d65a0f7099b02fe23fcb7302dd21800905cf0cd285bd82"
]
---Transaction Response---
txhash: "C56626C351E66EBAF085E84DF6422E84043DD6A1B81316367FE3976D762000FE"
raw_log: "[]"

gas wanted: 104011
gas fee: 0.0000520055 INJ
```

```go
simulated order hash:  0x73d8e846abdfffd3d42ff2c190a650829a5af52b3337287319b4f2c54eb7ce80
DEBU[0001] broadcastTx with nonce 3492                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5212740  fn=func1 src="client/chain/chain.go:619" txHash=B62F7CC6DE3297EC4376C239AF93DB33193A89FA99FAC27C9E25AD5579B9BAD7
DEBU[0003] nonce incremented to 3493                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  129912                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000064956 INJ
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/BroadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tx_response</td><td class="type-td td_text">types.TxResponse</td><td class="description-td td_text">tx_response is the queried TxResponses.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/TxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">int64</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">txhash</td><td class="type-td td_text">string</td><td class="description-td td_text">The transaction hash.</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">string</td><td class="description-td td_text">Namespace for the Code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Response code.</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">string</td><td class="description-td td_text">Result bytes, if any.</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">string</td><td class="description-td td_text">The output of the application's logger (raw string). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLogs</td><td class="description-td td_text">The output of the application's logger (typed). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">string</td><td class="description-td td_text">Additional information. May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas requested for transaction.</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas consumed by transaction.</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">types.Any</td><td class="description-td td_text">The request transaction bytes.</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">string</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time.</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">v1.Event array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.  Since: cosmos-sdk 0.42.11, 0.44.5, 0.45</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/ABCIMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">uint32</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvents</td><td class="description-td td_text">Events contains a slice of Event objects that were emitted during some execution.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgCreateSpotMarketOrder

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/7_MsgCreateSpotMarketOrder.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/7_MsgCreateSpotMarketOrder.py -->
```py
import asyncio
import json
import os
import uuid
from decimal import Decimal

import dotenv

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    private_key_in_hexa = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    message_broadcaster = MsgBroadcasterWithPk.new_using_gas_heuristics(
        network=network,
        private_key=private_key_in_hexa,
        gas_price=gas_price,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.msg_create_spot_market_order(
        market_id=market_id,
        sender=address.to_acc_bech32(),
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=Decimal("10.522"),
        quantity=Decimal("0.01"),
        order_type="BUY",
        cid=str(uuid.uuid4()),
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([msg])
    print("---Transaction Response---")
    print(json.dumps(result, indent=2))

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)
    message_broadcaster.update_gas_price(gas_price=gas_price)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/7_MsgCreateSpotMarketOrder/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/7_MsgCreateSpotMarketOrder/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	txtypes "github.com/cosmos/cosmos-sdk/types/tx"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"

	exchangev2types "github.com/InjectiveLabs/sdk-go/chain/exchange/types/v2"
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
	)

	if err != nil {
		panic(err)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	gasPrice := chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)

	defaultSubaccountID := chainClient.DefaultSubaccount(senderAddress)

	marketId := "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
	amount := decimal.NewFromFloat(0.1)
	price := decimal.NewFromFloat(22)

	order := chainClient.CreateSpotOrderV2(
		defaultSubaccountID,
		&chainclient.SpotOrderData{
			OrderType:    int32(exchangev2types.OrderType_SELL), //BUY SELL
			Quantity:     amount,
			Price:        price,
			FeeRecipient: senderAddress.String(),
			MarketId:     marketId,
			Cid:          uuid.NewString(),
		},
	)

	msg := exchangev2types.MsgCreateSpotMarketOrder{
		Sender: senderAddress.String(),
		Order:  *order,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	_, response, err := chainClient.BroadcastMsg(ctx, txtypes.BroadcastMode_BROADCAST_MODE_SYNC, &msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", "\t")
	fmt.Print(string(str))

	gasPrice = chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgCreateSpotMarketOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">the sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">SpotOrder</td><td class="description-td td_text">the order details</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/SpotOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">market_id represents the unique ID of the market</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">order_info contains the information of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">order types</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">trigger_price is the trigger price used by stop/take orders (in human readable format) (optional)</td></tr>
<tr ><td class="parameter-td td_text">expiration_block</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration block is the block number at which the order will expire</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">bytes32 subaccount ID that created the order</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient</td><td class="type-td td_text">string</td><td class="description-td td_text">address fee_recipient address that will receive fees for the order</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID (optional)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">BUY</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">SELL</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STOP_BUY</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STOP_SELL</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">TAKE_BUY</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">TAKE_SELL</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">BUY_PO</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SELL_PO</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">BUY_ATOMIC</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">SELL_ATOMIC</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
---Simulation Response---
[order_hash: "0x7c6552c5f5ffd3adc2cb5fe9f2bc1eed4741952f698c84e9dc73c6f45b6af8b4"
]
---Transaction Response---
txhash: "9BBD3666A052FA11AF572F4D788C3C7D8B44F60CF0F0375EE40B84DA2408114A"
raw_log: "[]"

gas wanted: 104352
gas fee: 0.000052176 INJ
```

```go
simulated order hash 0xfa9038ef2e59035a8f3368438aa4533fce90d8bbd3bee6c37e4cc06e8d1d0e6a
DEBU[0001] broadcastTx with nonce 3493                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5212834  fn=func1 src="client/chain/chain.go:619" txHash=14ABC252192D7286429730F9A29AB1BA67608B5EA7ACD7AD4D8F174C9B3852B3
DEBU[0004] nonce incremented to 3494                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  130596                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000065298 INJ
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/BroadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tx_response</td><td class="type-td td_text">types.TxResponse</td><td class="description-td td_text">tx_response is the queried TxResponses.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/TxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">int64</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">txhash</td><td class="type-td td_text">string</td><td class="description-td td_text">The transaction hash.</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">string</td><td class="description-td td_text">Namespace for the Code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Response code.</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">string</td><td class="description-td td_text">Result bytes, if any.</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">string</td><td class="description-td td_text">The output of the application's logger (raw string). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLogs</td><td class="description-td td_text">The output of the application's logger (typed). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">string</td><td class="description-td td_text">Additional information. May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas requested for transaction.</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas consumed by transaction.</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">types.Any</td><td class="description-td td_text">The request transaction bytes.</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">string</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time.</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">v1.Event array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.  Since: cosmos-sdk 0.42.11, 0.44.5, 0.45</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/ABCIMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">uint32</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvents</td><td class="description-td td_text">Events contains a slice of Event objects that were emitted during some execution.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgCancelSpotOrder

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/8_MsgCancelSpotOrder.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/8_MsgCancelSpotOrder.py -->
```py
import asyncio
import json
import os

import dotenv

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    private_key_in_hexa = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    message_broadcaster = MsgBroadcasterWithPk.new_using_gas_heuristics(
        network=network,
        private_key=private_key_in_hexa,
        gas_price=gas_price,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    order_hash = "0x52888d397d5ae821869c8acde5823dfd8018802d2ef642d3aa639e5308173fcf"

    # prepare tx msg
    msg = composer.msg_cancel_spot_order(
        sender=address.to_acc_bech32(), market_id=market_id, subaccount_id=subaccount_id, order_hash=order_hash
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([msg])
    print("---Transaction Response---")
    print(json.dumps(result, indent=2))

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)
    message_broadcaster.update_gas_price(gas_price=gas_price)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/8_MsgCancelSpotOrder/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/8_MsgCancelSpotOrder/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	txtypes "github.com/cosmos/cosmos-sdk/types/tx"

	exchangev2types "github.com/InjectiveLabs/sdk-go/chain/exchange/types/v2"
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
	)

	if err != nil {
		panic(err)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	gasPrice := chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)

	msg := exchangev2types.MsgCancelSpotOrder{
		Sender:       senderAddress.String(),
		MarketId:     "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
		SubaccountId: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
		OrderHash:    "0xc1dd07efb7cf3a90c3d09da958fa22d96a5787eba3dbec56b63902c482accbd4",
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	_, response, err := chainClient.BroadcastMsg(ctx, txtypes.BroadcastMode_BROADCAST_MODE_SYNC, &msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", "\t")
	fmt.Print(string(str))

	gasPrice = chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgCancelSpotOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">the sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the market ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the subaccount ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash (optional)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID (optional)</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "3ABF365B8D90D44749AFF74FC510D792581202F98ABB406219B72E71315A64D4"
raw_log: "[]"

gas wanted: 102720
gas fee: 0.00005136 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3494                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5212920  fn=func1 src="client/chain/chain.go:619" txHash=14C2CB0592C5E950587D2041E97E337452A28F2A11220CC3E66624E5BAA73245
DEBU[0002] nonce incremented to 3495                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  127363                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000636815 INJ
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/BroadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tx_response</td><td class="type-td td_text">types.TxResponse</td><td class="description-td td_text">tx_response is the queried TxResponses.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/TxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">int64</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">txhash</td><td class="type-td td_text">string</td><td class="description-td td_text">The transaction hash.</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">string</td><td class="description-td td_text">Namespace for the Code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Response code.</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">string</td><td class="description-td td_text">Result bytes, if any.</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">string</td><td class="description-td td_text">The output of the application's logger (raw string). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLogs</td><td class="description-td td_text">The output of the application's logger (typed). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">string</td><td class="description-td td_text">Additional information. May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas requested for transaction.</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas consumed by transaction.</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">types.Any</td><td class="description-td td_text">The request transaction bytes.</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">string</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time.</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">v1.Event array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.  Since: cosmos-sdk 0.42.11, 0.44.5, 0.45</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/ABCIMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">uint32</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvents</td><td class="description-td td_text">Events contains a slice of Event objects that were emitted during some execution.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgBatchUpdateOrders

MsgBatchUpdateOrders allows for the atomic cancellation and creation of spot and derivative limit orders, along with a new order cancellation mode. Upon execution, order cancellations (if any) occur first, followed by order creations (if any).

Users can cancel all limit orders in a given spot or derivative market for a given subaccountID by specifying the associated marketID in the SpotMarketIdsToCancelAll and DerivativeMarketIdsToCancelAll. Users can also cancel individual limit orders in SpotOrdersToCancel or DerivativeOrdersToCancel, but must ensure that marketIDs in these individual order cancellations are not already provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll.

Further note that if no marketIDs are provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll, then the SubaccountID in the Msg should be left empty.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/9_MsgBatchUpdateOrders.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/9_MsgBatchUpdateOrders.py -->
```py
import asyncio
import json
import os
import uuid
from decimal import Decimal

import dotenv

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    private_key_in_hexa = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    message_broadcaster = MsgBroadcasterWithPk.new_using_gas_heuristics(
        network=network,
        private_key=private_key_in_hexa,
        gas_price=gas_price,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    derivative_market_id_create = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    spot_market_id_create = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

    derivative_market_id_cancel = "0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff"
    derivative_market_id_cancel_2 = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    spot_market_id_cancel = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    spot_market_id_cancel_2 = "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0"

    derivative_orders_to_cancel = [
        composer.create_order_data_without_mask(
            market_id=derivative_market_id_cancel,
            subaccount_id=subaccount_id,
            order_hash="0x48690013c382d5dbaff9989db04629a16a5818d7524e027d517ccc89fd068103",
        ),
        composer.create_order_data_without_mask(
            market_id=derivative_market_id_cancel_2,
            subaccount_id=subaccount_id,
            order_hash="0x7ee76255d7ca763c56b0eab9828fca89fdd3739645501c8a80f58b62b4f76da5",
        ),
    ]

    spot_orders_to_cancel = [
        composer.create_order_data_without_mask(
            market_id=spot_market_id_cancel,
            subaccount_id=subaccount_id,
            cid="0e5c3ad5-2cc4-4a2a-bbe5-b12697739163",
        ),
        composer.create_order_data_without_mask(
            market_id=spot_market_id_cancel_2,
            subaccount_id=subaccount_id,
            order_hash="0x222daa22f60fe9f075ed0ca583459e121c23e64431c3fbffdedda04598ede0d2",
        ),
    ]

    derivative_orders_to_create = [
        composer.derivative_order(
            market_id=derivative_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal(25000),
            quantity=Decimal(0.1),
            margin=composer.calculate_margin(
                quantity=Decimal(0.1), price=Decimal(25000), leverage=Decimal(1), is_reduce_only=False
            ),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.derivative_order(
            market_id=derivative_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal(50000),
            quantity=Decimal(0.01),
            margin=composer.calculate_margin(
                quantity=Decimal(0.01), price=Decimal(50000), leverage=Decimal(1), is_reduce_only=False
            ),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    spot_orders_to_create = [
        composer.spot_order(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("3"),
            quantity=Decimal("55"),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.spot_order(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("300"),
            quantity=Decimal("55"),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    # prepare tx msg
    msg = composer.msg_batch_update_orders(
        sender=address.to_acc_bech32(),
        derivative_orders_to_create=derivative_orders_to_create,
        spot_orders_to_create=spot_orders_to_create,
        derivative_orders_to_cancel=derivative_orders_to_cancel,
        spot_orders_to_cancel=spot_orders_to_cancel,
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([msg])
    print("---Transaction Response---")
    print(json.dumps(result, indent=2))

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)
    message_broadcaster.update_gas_price(gas_price=gas_price)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/9_MsgBatchUpdateOrders/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/9_MsgBatchUpdateOrders/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	txtypes "github.com/cosmos/cosmos-sdk/types/tx"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"

	exchangev2types "github.com/InjectiveLabs/sdk-go/chain/exchange/types/v2"
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
		fmt.Println(err)
		return
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClientV2(
		clientCtx,
		network,
	)

	if err != nil {
		fmt.Println(err)
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	gasPrice := chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)

	defaultSubaccountID := chainClient.DefaultSubaccount(senderAddress)

	smarketId := "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
	samount := decimal.NewFromFloat(2)
	sprice := decimal.NewFromFloat(22.5)
	smarketIds := []string{"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"}

	spot_order := chainClient.CreateSpotOrderV2(
		defaultSubaccountID,
		&chainclient.SpotOrderData{
			OrderType:    int32(exchangev2types.OrderType_BUY), //BUY SELL BUY_PO SELL_PO
			Quantity:     samount,
			Price:        sprice,
			FeeRecipient: senderAddress.String(),
			MarketId:     smarketId,
			Cid:          uuid.NewString(),
		},
	)

	dmarketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	damount := decimal.NewFromFloat(0.01)
	dprice := decimal.RequireFromString("31000") //31,000
	dleverage := decimal.RequireFromString("2")
	dmarketIds := []string{"0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"}

	derivative_order := chainClient.CreateDerivativeOrderV2(
		defaultSubaccountID,
		&chainclient.DerivativeOrderData{
			OrderType:    int32(exchangev2types.OrderType_BUY), //BUY SELL BUY_PO SELL_PO
			Quantity:     damount,
			Price:        dprice,
			Leverage:     dleverage,
			FeeRecipient: senderAddress.String(),
			MarketId:     dmarketId,
			IsReduceOnly: false,
			Cid:          uuid.NewString(),
		},
	)

	msg := exchangev2types.MsgBatchUpdateOrders{
		Sender:                         senderAddress.String(),
		SubaccountId:                   defaultSubaccountID.Hex(),
		SpotOrdersToCreate:             []*exchangev2types.SpotOrder{spot_order},
		DerivativeOrdersToCreate:       []*exchangev2types.DerivativeOrder{derivative_order},
		SpotMarketIdsToCancelAll:       smarketIds,
		DerivativeMarketIdsToCancelAll: dmarketIds,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	_, response, err := chainClient.BroadcastMsg(ctx, txtypes.BroadcastMode_BROADCAST_MODE_SYNC, &msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", "\t")
	fmt.Print(string(str))

	gasPrice = chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgBatchUpdateOrders.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">the sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">subaccount_id only used for the spot_market_ids_to_cancel_all and derivative_market_ids_to_cancel_all (optional)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">spot_market_ids_to_cancel_all</td><td class="type-td td_text">string array</td><td class="description-td td_text">the market IDs to cancel all spot orders for (optional)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_market_ids_to_cancel_all</td><td class="type-td td_text">string array</td><td class="description-td td_text">the market IDs to cancel all derivative orders for (optional)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">spot_orders_to_cancel</td><td class="type-td td_text">OrderData array</td><td class="description-td td_text">the spot orders to cancel</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_orders_to_cancel</td><td class="type-td td_text">OrderData array</td><td class="description-td td_text">the derivative orders to cancel</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">spot_orders_to_create</td><td class="type-td td_text">SpotOrder array</td><td class="description-td td_text">the spot orders to create</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_orders_to_create</td><td class="type-td td_text">DerivativeOrder array</td><td class="description-td td_text">the derivative orders to create</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">binary_options_orders_to_cancel</td><td class="type-td td_text">OrderData array</td><td class="description-td td_text">the binary options orders to cancel</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">binary_options_market_ids_to_cancel_all</td><td class="type-td td_text">string array</td><td class="description-td td_text">the market IDs to cancel all binary options orders for (optional)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">binary_options_orders_to_create</td><td class="type-td td_text">DerivativeOrder array</td><td class="description-td td_text">the binary options orders to create</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderData**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderData.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the market ID</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the subaccount ID</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash (optional - either the order_hash or the cid should be provided)</td></tr>
<tr ><td class="parameter-td td_text">order_mask</td><td class="type-td td_text">int32</td><td class="description-td td_text">the order mask (bitwise combination of OrderMask enum values)</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID (optional - either the order_hash or the cid should be provided)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/SpotOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">market_id represents the unique ID of the market</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">order_info contains the information of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">order types</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">trigger_price is the trigger price used by stop/take orders (in human readable format) (optional)</td></tr>
<tr ><td class="parameter-td td_text">expiration_block</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration block is the block number at which the order will expire</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/DerivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">market_id represents the unique ID of the market</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">order_info contains the information of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">order types</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">margin is the margin used by the limit order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">trigger_price is the trigger price used by stop/take orders (in human readable format) (optional)</td></tr>
<tr ><td class="parameter-td td_text">expiration_block</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration block is the block number at which the order will expire</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderMask**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderMask.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNUSED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">ANY</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">REGULAR</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">CONDITIONAL</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">DIRECTION_BUY_OR_HIGHER</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">DIRECTION_SELL_OR_LOWER</td></tr>
<tr ><td class="code-td td_num">32</td><td class="name-td td_text">TYPE_MARKET</td></tr>
<tr ><td class="code-td td_num">64</td><td class="name-td td_text">TYPE_LIMIT</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">bytes32 subaccount ID that created the order</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient</td><td class="type-td td_text">string</td><td class="description-td td_text">address fee_recipient address that will receive fees for the order</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID (optional)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">BUY</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">SELL</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STOP_BUY</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STOP_SELL</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">TAKE_BUY</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">TAKE_SELL</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">BUY_PO</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SELL_PO</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">BUY_ATOMIC</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">SELL_ATOMIC</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
---Simulation Response---
[spot_cancel_success: false
spot_cancel_success: false
derivative_cancel_success: false
derivative_cancel_success: false
spot_order_hashes: "0x3f5b5de6ec72b250c58e0a83408dbc1990cee369999036e3469e19b80fa9002e"
spot_order_hashes: "0x7d8580354e120b038967a180f73bc3aba0f49db9b6d2cb5c4cec85e8cab3e218"
derivative_order_hashes: "0x920a4ea4144c46d1e1084ca5807e4f5608639ce00f97139d5b44e628d487e15e"
derivative_order_hashes: "0x11d75d0c2ce8a07f352523be2e3456212c623397d0fc1a2f688b97a15c04372c"
]
---Transaction Response---
txhash: "4E29226884DCA22E127471588F39E0BB03D314E1AA27ECD810D24C4078D52DED"
raw_log: "[]"

gas wanted: 271213
gas fee: 0.0001356065 INJ
```

```go
simulated spot order hashes [0xd9f30c7e700202615c2775d630b9fb276572d883fa480b6394abbddcb79c8109]
simulated derivative order hashes [0xb2bea3b15c204699a9ee945ca49650001560518d1e54266adac580aa061fedd4]
DEBU[0001] broadcastTx with nonce 3507                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5214679  fn=func1 src="client/chain/chain.go:619" txHash=CF53E0B31B9E28E0D6D8F763ECEC2D91E38481321EA24AC86F6A8774C658AF44
DEBU[0003] nonce incremented to 3508                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  659092                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000329546 INJ
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/BroadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tx_response</td><td class="type-td td_text">types.TxResponse</td><td class="description-td td_text">tx_response is the queried TxResponses.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/TxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">int64</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">txhash</td><td class="type-td td_text">string</td><td class="description-td td_text">The transaction hash.</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">string</td><td class="description-td td_text">Namespace for the Code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Response code.</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">string</td><td class="description-td td_text">Result bytes, if any.</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">string</td><td class="description-td td_text">The output of the application's logger (raw string). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLogs</td><td class="description-td td_text">The output of the application's logger (typed). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">string</td><td class="description-td td_text">Additional information. May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas requested for transaction.</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas consumed by transaction.</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">types.Any</td><td class="description-td td_text">The request transaction bytes.</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">string</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time.</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">v1.Event array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.  Since: cosmos-sdk 0.42.11, 0.44.5, 0.45</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/ABCIMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">uint32</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvents</td><td class="description-td td_text">Events contains a slice of Event objects that were emitted during some execution.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgUpdateSpotMarket

Modifies certain market fields. It can only be sent by the market's admin.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/24_MsgUpdateSpotMarket.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/24_MsgUpdateSpotMarket.py -->
```py
import asyncio
import json
import os
from decimal import Decimal

import dotenv

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    await client.initialize_tokens_from_chain_denoms()
    composer = await client.composer()

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=configured_private_key,
        gas_price=gas_price,
        client=client,
        composer=composer,
    )

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    message = composer.msg_update_spot_market(
        admin=address.to_acc_bech32(),
        market_id="0x215970bfdea5c94d8e964a759d3ce6eae1d113900129cc8428267db5ccdb3d1a",
        new_ticker="INJ/USDC 2",
        new_min_price_tick_size=Decimal("0.01"),
        new_min_quantity_tick_size=Decimal("0.01"),
        new_min_notional=Decimal("2"),
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(json.dumps(result, indent=2))

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)
    message_broadcaster.update_gas_price(gas_price=gas_price)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/24_MsgUpdateSpotMarket/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/24_MsgUpdateSpotMarket/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	"cosmossdk.io/math"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	exchangev2types "github.com/InjectiveLabs/sdk-go/chain/exchange/types/v2"
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
	)
	if err != nil {
		panic(err)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	gasPrice := chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)

	minPriceTickSize := math.LegacyMustNewDecFromStr("0.01")
	minQuantityTickSize := math.LegacyMustNewDecFromStr("0.01")
	minNotional := math.LegacyMustNewDecFromStr("2")

	msg := &exchangev2types.MsgUpdateSpotMarket{
		Admin:                  senderAddress.String(),
		MarketId:               "0x215970bfdea5c94d8e964a759d3ce6eae1d113900129cc8428267db5ccdb3d1a",
		NewTicker:              "INJ/USDC 2",
		NewMinPriceTickSize:    minPriceTickSize,
		NewMinQuantityTickSize: minQuantityTickSize,
		NewMinNotional:         minNotional,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(ctx, msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", "\t")
	fmt.Print(string(str))

	gasPrice = chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgUpdateSpotMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">admin</td><td class="type-td td_text">string</td><td class="description-td td_text">current admin address of the associated market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">id of the market to be updated</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">new_ticker</td><td class="type-td td_text">string</td><td class="description-td td_text">(optional) updated ticker value</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">new_min_price_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">(optional) updated min price tick size value (in human readable format)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">new_min_quantity_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">(optional) updated min quantity tick size value (in human readable format)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">new_min_notional</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">(optional) updated min notional (in human readable format)</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "5AF048ADCE6AF753256F03AF2404A5B78C4C3E7E42A91F0B5C9994372E8AC2FE"
raw_log: "[]"

gas wanted: 106585
gas fee: 0.0000532925 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3503                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5214406  fn=func1 src="client/chain/chain.go:619"
txHash=31FDA89C3122322C0559B5766CDF892FD0AA12469017CF8BF88B53441464ECC4
DEBU[0002] nonce incremented to 3504                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  133614                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000066807 INJ
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/BroadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tx_response</td><td class="type-td td_text">types.TxResponse</td><td class="description-td td_text">tx_response is the queried TxResponses.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/TxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">int64</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">txhash</td><td class="type-td td_text">string</td><td class="description-td td_text">The transaction hash.</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">string</td><td class="description-td td_text">Namespace for the Code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Response code.</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">string</td><td class="description-td td_text">Result bytes, if any.</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">string</td><td class="description-td td_text">The output of the application's logger (raw string). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLogs</td><td class="description-td td_text">The output of the application's logger (typed). May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">string</td><td class="description-td td_text">Additional information. May be non-deterministic.</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas requested for transaction.</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">int64</td><td class="description-td td_text">Amount of gas consumed by transaction.</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">types.Any</td><td class="description-td td_text">The request transaction bytes.</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">string</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time.</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">v1.Event array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.  Since: cosmos-sdk 0.42.11, 0.44.5, 0.45</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/ABCIMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">uint32</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvents</td><td class="description-td td_text">Events contains a slice of Event objects that were emitted during some execution.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## LocalOrderHashComputation

This function computes order hashes locally for SpotOrder and DerivativeOrder. For more information, see the [note below](#spot-note-on-localorderhashcomputation-for-hfts-api-traders). 

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/1_LocalOrderHash.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/1_LocalOrderHash.py -->
```py
import asyncio
import json
import os
import uuid
from decimal import Decimal

import dotenv

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.constant import GAS_FEE_BUFFER_AMOUNT
from pyinjective.core.network import Network
from pyinjective.orderhash import OrderHashManager
from pyinjective.transaction import Transaction
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())
    subaccount_id = address.get_subaccount_id(index=0)
    subaccount_id_2 = address.get_subaccount_id(index=1)

    order_hash_manager = OrderHashManager(address=address, network=network, subaccount_indexes=[0, 1, 2, 7])

    # prepare trade info
    spot_market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    deriv_market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    spot_orders = [
        composer.spot_order(
            market_id=spot_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("0.524"),
            quantity=Decimal("0.01"),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.spot_order(
            market_id=spot_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("27.92"),
            quantity=Decimal("0.01"),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    derivative_orders = [
        composer.derivative_order(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal(10500),
            quantity=Decimal(0.01),
            margin=composer.calculate_margin(
                quantity=Decimal(0.01), price=Decimal(10500), leverage=Decimal(2), is_reduce_only=False
            ),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.derivative_order(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal(65111),
            quantity=Decimal(0.01),
            margin=composer.calculate_margin(
                quantity=Decimal(0.01), price=Decimal(65111), leverage=Decimal(2), is_reduce_only=False
            ),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    # prepare tx msg
    spot_msg = composer.msg_batch_create_spot_limit_orders(sender=address.to_acc_bech32(), orders=spot_orders)

    deriv_msg = composer.msg_batch_create_derivative_limit_orders(
        sender=address.to_acc_bech32(), orders=derivative_orders
    )

    # compute order hashes
    order_hashes = order_hash_manager.compute_order_hashes(
        spot_orders=spot_orders, derivative_orders=derivative_orders, subaccount_index=0
    )

    print("computed spot order hashes", order_hashes.spot)
    print("computed derivative order hashes", order_hashes.derivative)

    # build tx 1
    tx = (
        Transaction()
        .with_messages(spot_msg, deriv_msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    base_gas = 85000
    gas_limit = base_gas + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
    gas_fee = "{:.18f}".format((gas_price * gas_limit) / pow(10, 18)).rstrip("0")
    fee = [
        composer.coin(
            amount=gas_price * gas_limit,
            denom=network.fee_denom,
        )
    ]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.broadcast_tx_sync_mode(tx_raw_bytes)
    print(json.dumps(res, indent=2))
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

    # compute order hashes
    order_hashes = order_hash_manager.compute_order_hashes(
        spot_orders=spot_orders, derivative_orders=derivative_orders, subaccount_index=0
    )

    print("computed spot order hashes", order_hashes.spot)
    print("computed derivative order hashes", order_hashes.derivative)

    # build tx 2
    tx = (
        Transaction()
        .with_messages(spot_msg, deriv_msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    base_gas = 85000
    gas_limit = base_gas + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
    gas_fee = "{:.18f}".format((gas_price * gas_limit) / pow(10, 18)).rstrip("0")
    fee = [
        composer.coin(
            amount=gas_price * gas_limit,
            denom=network.fee_denom,
        )
    ]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.broadcast_tx_sync_mode(tx_raw_bytes)
    print(json.dumps(res, indent=2))
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

    spot_orders = [
        composer.spot_order(
            market_id=spot_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=Decimal("1.524"),
            quantity=Decimal("0.01"),
            order_type="BUY_PO",
            cid=str(uuid.uuid4()),
        ),
        composer.spot_order(
            market_id=spot_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=Decimal("27.92"),
            quantity=Decimal("0.01"),
            order_type="SELL_PO",
            cid=str(uuid.uuid4()),
        ),
    ]

    derivative_orders = [
        composer.derivative_order(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=Decimal(25111),
            quantity=Decimal(0.01),
            margin=composer.calculate_margin(
                quantity=Decimal(0.01), price=Decimal(25111), leverage=Decimal("1.5"), is_reduce_only=False
            ),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.derivative_order(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=Decimal(65111),
            quantity=Decimal(0.01),
            margin=composer.calculate_margin(
                quantity=Decimal(0.01), price=Decimal(25111), leverage=Decimal(2), is_reduce_only=False
            ),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    # prepare tx msg
    spot_msg = composer.msg_batch_create_spot_limit_orders(sender=address.to_acc_bech32(), orders=spot_orders)

    deriv_msg = composer.msg_batch_create_derivative_limit_orders(
        sender=address.to_acc_bech32(), orders=derivative_orders
    )

    # compute order hashes
    order_hashes = order_hash_manager.compute_order_hashes(
        spot_orders=spot_orders, derivative_orders=derivative_orders, subaccount_index=1
    )

    print("computed spot order hashes", order_hashes.spot)
    print("computed derivative order hashes", order_hashes.derivative)

    # build tx 3
    tx = (
        Transaction()
        .with_messages(spot_msg, deriv_msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    base_gas = 85000
    gas_limit = base_gas + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
    gas_fee = "{:.18f}".format((gas_price * gas_limit) / pow(10, 18)).rstrip("0")
    fee = [
        composer.coin(
            amount=gas_price * gas_limit,
            denom=network.fee_denom,
        )
    ]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.broadcast_tx_sync_mode(tx_raw_bytes)
    print(json.dumps(res, indent=2))
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/1_LocalOrderHash/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/1_LocalOrderHash/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	txtypes "github.com/cosmos/cosmos-sdk/types/tx"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"

	exchangev2types "github.com/InjectiveLabs/sdk-go/chain/exchange/types/v2"
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

	// initialize grpc client
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
	)

	if err != nil {
		panic(err)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	gasPrice := chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)

	// prepare tx msg
	defaultSubaccountID := chainClient.Subaccount(senderAddress, 1)

	spotOrder := chainClient.CreateSpotOrderV2(
		defaultSubaccountID,
		&chainclient.SpotOrderData{
			OrderType:    int32(exchangev2types.OrderType_BUY),
			Quantity:     decimal.NewFromFloat(2),
			Price:        decimal.NewFromFloat(22.55),
			FeeRecipient: senderAddress.String(),
			MarketId:     "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
			Cid:          uuid.NewString(),
		},
	)

	derivativeOrder := chainClient.CreateDerivativeOrderV2(
		defaultSubaccountID,
		&chainclient.DerivativeOrderData{
			OrderType:    int32(exchangev2types.OrderType_BUY),
			Quantity:     decimal.NewFromFloat(2),
			Price:        decimal.RequireFromString("31"),
			Leverage:     decimal.RequireFromString("2.5"),
			FeeRecipient: senderAddress.String(),
			MarketId:     "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
			Cid:          uuid.NewString(),
		},
	)

	msg := exchangev2types.MsgBatchCreateSpotLimitOrders{
		Sender: senderAddress.String(),
		Orders: []exchangev2types.SpotOrder{*spotOrder},
	}

	msg1 := exchangev2types.MsgBatchCreateDerivativeLimitOrders{
		Sender: senderAddress.String(),
		Orders: []exchangev2types.DerivativeOrder{*derivativeOrder},
	}

	// compute local order hashes
	orderHashes, err := chainClient.ComputeOrderHashes(msg.Orders, msg1.Orders, defaultSubaccountID)

	if err != nil {
		fmt.Println(err)
	}

	fmt.Println("computed spot order hashes: ", orderHashes.Spot)
	fmt.Println("computed derivative order hashes: ", orderHashes.Derivative)

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	_, response, err := chainClient.BroadcastMsg(ctx, txtypes.BroadcastMode_BROADCAST_MODE_SYNC, &msg, &msg1)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", "\t")
	fmt.Print(string(str))

	gasPrice = chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
computed spot order hashes ['0xa2d59cca00bade680a552f02deeb43464df21c73649191d64c6436313b311cba', '0xab78219e6c494373262a310d73660198c7a4c91196c0f6bb8808c81d8fb54a11']
computed derivative order hashes ['0x38d432c011f4a62c6b109615718b26332e7400a86f5e6f44e74a8833b7eed992', '0x66a921d83e6931513df9076c91a920e5e943837e2b836ad370b5cf53a1ed742c']
txhash: "604757CD9024FFF2DDCFEED6FC070E435AC09A829DB2E81AD4AD65B33E987A8B"
raw_log: "[]"

gas wanted: 196604
gas fee: 0.000098302 INJ
```

```go
computed spot order hashes:  [0x0103ca50d0d033e6b8528acf28a3beb3fd8bac20949fc1ba60a2da06c53ad94f]
computed derivative order hashes:  [0x15334a7a0f1c2f98b9369f79b9a62a1f357d3e63b46a8895a4cec0ca375ddbbb 0xc26c8f74f56eade275e518f73597dd8954041bfbae3951ed4d7efeb0d060edbd]
DEBU[0001] broadcastTx with nonce 3488                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5212331  fn=func1 src="client/chain/chain.go:619" txHash=19D8D81BB1DF59889E00EAA600A01079BA719F00A4A43CCC1B56580A1BBD6455
DEBU[0003] nonce incremented to 3489                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  271044                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000135522 INJ
```

## Note on LocalOrderHashComputation for HFTs/API Traders

`LocalOrderHashComputation` returns a locally computed transaction hash for spot and derivative orders, which is useful when the user needs the transaction hash faster than orders can be streamed through `StreamOrdersHistory` (there is extra latency since the order must be included by a block, and the block must be indexed by the Indexer). While the hash can also be obtained through transaction simulation, the process adds a layer of latency and can only be used for one transaction per block (simulation relies on a nonce based on the state machine which does not change until the transaction is included in a block).

On Injective, subaccount nonces are used to calculate order hashes. The subaccount nonce is incremented with each order so that order hashes remain unique.

For strategies employing high frequency trading, order hashes should be calculated locally before transactions are broadcasted. This is possible as long as the subaccount nonce is cached/tracked locally instead of queried from the chain. Similarly, the account sequence (like nonce on Ethereum) should be cached if more than one transaction per block is desired. The `LocalOrderHashComputation` implementation can be found [here](https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/orderhash.py). Refer to the [above API example](#spot-localorderhashcomputation) for usage.

There are two caveats to be mindful of when taking this approach:

**1. Gas must be manually calculated instead of fetched from simulation**

* To avoid latency issues from simulation, it's best to completely omit simulation for fetching gas and order hash.
* To calculate gas, a constant value should be set for the base transaction object. The tx object consists of a constant set of attributes such as memo, sequence, etc., so gas should be the same as long as the amount of data being transmitted remains constant (i.e. gas may change if the memo size is very large). The gas can then be increased per order creation/cancellation.
* These constants can be found through simulating a transaction with a single order and a separate transaction with two orders, then solving the linear equations to obtain the base gas and the per-order gas amounts.

``` python
  class GasLimitConstant:
      base = 65e3
      extra = 20e3
      spot_order = 60e3
      spot_cancel = 40e3
```

* An extra 20,000 buffer can be added to the gas calculation to ensure the transaction is not rejected during execution on the validator node. Transactions often require a bit more gas depending on the operations; for example, a post-only order could cross the order book and get cancelled, which would cost a different amount of gas than if that order was posted in the book as a limit order. See example on right:
* Note: In cosmos-sdk v0.46, a gas refund capability was added through the PostHandler functionality. In theory, this means that gas constants can be set much higher such that transactions never fail; however, because v0.46 was not compatible with CosmWasm during the last chain upgrade, the refund capability is not implemented on Injective. This may change in the future, but as of now, gas is paid in its entirety as set.

**2. In the event a transaction fails, the account sequence and subaccount nonce must both be refreshed**

* If the client receives a sequence mismatch error (code 32), a refresh in sequence and subaccount nonce will likely resolve the error.

``` python
  res = await self.client.broadcast_tx_sync_mode(tx_raw_bytes)
  if res.code == 32:
      await client.fetch_account(address.to_acc_bech32())
```

* To refresh the cached account sequence, updated account data can be fetched using the client. See example on right, using the Python client:
* To refresh the cached subaccount nonce, the [`OrderHashManager`](https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/orderhash.py#L47) can be reinitialized since the subaccount nonce is fetched from the chain during init.
