# - Chain Exchange for Binary Options
Includes all messages related to binary options.


## BinaryOptionsMarkets

Retrieves binary options markets

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/query/53_BinaryOptionsMarkets.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/query/53_BinaryOptionsMarkets.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    markets = await client.fetch_chain_binary_options_markets(status="Active")
    print(markets)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/exchange/query/53_BinaryOptionsMarkets/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/exchange/query/53_BinaryOptionsMarkets/example.go -->
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

	res, err := chainClient.FetchChainBinaryOptionsMarkets(ctx, status)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryBinaryMarketsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">string</td><td class="description-td td_text">Status of the market, for convenience it is set to string - not enum</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
	"markets": [
		{
			"ticker": "TIA/USDT PERP",
			"oracle_symbol": "TIA/USDT PERP",
			"oracle_provider": "Frontrunner",
			"oracle_type": 11,
			"expiration_timestamp": 17115165000022,
			"settlement_timestamp": 17115201000022,
			"admin": "inj1xyfrl7wrsczv7ah5tvvpcwnp3vlc3n9terc9d6",
			"quote_denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
			"market_id": "0x5cced3de7c6df18b87d94b18f4b2065f8efcac44c3abecf3f2ed489af8c0c15e",
			"maker_fee_rate": "0.000500000000000000",
			"taker_fee_rate": "0.001000000000000000",
			"relayer_fee_share_rate": "0.400000000000000000",
			"status": 1,
			"min_price_tick_size": "0.000000010000000000",
			"min_quantity_tick_size": "0.010000000000000000",
			"min_notional": "0.000000000000000000",
			"quote_decimals": 6
		},
		{
			"ticker": "INJ/USDT",
			"oracle_symbol": "INJ/USDT",
			"oracle_provider": "Frontrunner",
			"oracle_type": 11,
			"expiration_timestamp": 17116342000091,
			"settlement_timestamp": 17116378000091,
			"admin": "inj1xyfrl7wrsczv7ah5tvvpcwnp3vlc3n9terc9d6",
			"quote_denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
			"market_id": "0xddd038d16922db1671a998285e387f016ad302a6643732fcac93dc42ac927e39",
			"maker_fee_rate": "0.000500000000000000",
			"taker_fee_rate": "0.001000000000000000",
			"relayer_fee_share_rate": "0.400000000000000000",
			"status": 1,
			"min_price_tick_size": "0.000000010000000000",
			"min_quantity_tick_size": "0.010000000000000000",
			"min_notional": "0.000000000000000000",
			"quote_decimals": 6
		}
	]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QueryBinaryMarketsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">markets</td><td class="type-td td_text">BinaryOptionsMarket array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BinaryOptionsMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/BinaryOptionsMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">string</td><td class="description-td td_text">Ticker for the derivative contract.</td></tr>
<tr ><td class="parameter-td td_text">oracle_symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle symbol</td></tr>
<tr ><td class="parameter-td td_text">oracle_provider</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle Provider</td></tr>
<tr ><td class="parameter-td td_text">oracle_type</td><td class="type-td td_text">types.OracleType</td><td class="description-td td_text">Oracle type</td></tr>
<tr ><td class="parameter-td td_text">oracle_scale_factor</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Scale factor for oracle prices.</td></tr>
<tr ><td class="parameter-td td_text">expiration_timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration timestamp</td></tr>
<tr ><td class="parameter-td td_text">settlement_timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration timestamp</td></tr>
<tr ><td class="parameter-td td_text">admin</td><td class="type-td td_text">string</td><td class="description-td td_text">admin of the market</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Address of the quote currency denomination for the binary options contract</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Unique market ID.</td></tr>
<tr ><td class="parameter-td td_text">maker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">maker_fee_rate defines the maker fee rate of a binary options market</td></tr>
<tr ><td class="parameter-td td_text">taker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">taker_fee_rate defines the taker fee rate of a derivative market</td></tr>
<tr ><td class="parameter-td td_text">relayer_fee_share_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">relayer_fee_share_rate defines the percentage of the transaction fee shared with the relayer in a derivative market</td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">MarketStatus</td><td class="description-td td_text">Status of the market</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_price_tick_size defines the minimum tick size that the price and margin required for orders in the market</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_quantity_tick_size defines the minimum tick size of the quantity required for orders in the market</td></tr>
<tr ><td class="parameter-td td_text">settlement_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_notional defines the minimum notional (in quote asset) required for orders in the market</td></tr>
<tr ><td class="parameter-td td_text">admin_permissions</td><td class="type-td td_text">uint32</td><td class="description-td td_text">level of admin permissions</td></tr>
<tr ><td class="parameter-td td_text">quote_decimals</td><td class="type-td td_text">uint32</td><td class="description-td td_text">quote token decimals</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OracleType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/oracle/v1beta1/OracleType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Band</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">PriceFeed</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Coinbase</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Chainlink</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">Razor</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">Dia</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">API3</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Uma</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">Pyth</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">BandIBC</td></tr>
<tr ><td class="code-td td_num">11</td><td class="name-td td_text">Provider</td></tr>
<tr ><td class="code-td td_num">12</td><td class="name-td td_text">Stork</td></tr></tbody></table>
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


## MsgInstantBinaryOptionsMarketLaunch

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/exchange/13_MsgInstantBinaryOptionsMarketLaunch/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/exchange/13_MsgInstantBinaryOptionsMarketLaunch/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	"cosmossdk.io/math"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	exchangev2types "github.com/InjectiveLabs/sdk-go/chain/exchange/types/v2"
	oracletypes "github.com/InjectiveLabs/sdk-go/chain/oracle/types"
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

	gasPrice := chainClient.CurrentChainGasPrice()
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)

	minPriceTickSize := math.LegacyMustNewDecFromStr("0.01")
	minQuantityTickSize := math.LegacyMustNewDecFromStr("0.001")

	msg := &exchangev2types.MsgInstantBinaryOptionsMarketLaunch{
		Sender:              senderAddress.String(),
		Ticker:              "UFC-KHABIB-TKO-05/30/2023",
		OracleSymbol:        "UFC-KHABIB-TKO-05/30/2023",
		OracleProvider:      "UFC",
		OracleType:          oracletypes.OracleType_Provider,
		OracleScaleFactor:   6,
		MakerFeeRate:        math.LegacyMustNewDecFromStr("0.0005"),
		TakerFeeRate:        math.LegacyMustNewDecFromStr("0.0010"),
		ExpirationTimestamp: 1680730982,
		SettlementTimestamp: 1690730982,
		Admin:               senderAddress.String(),
		QuoteDenom:          "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
		MinPriceTickSize:    minPriceTickSize,
		MinQuantityTickSize: minQuantityTickSize,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", "\t")
	fmt.Print(string(str))

	gasPrice = chainClient.CurrentChainGasPrice()
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgInstantBinaryOptionsMarketLaunch.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">string</td><td class="description-td td_text">Ticker for the derivative contract.</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle symbol</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_provider</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle Provider</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_type</td><td class="type-td td_text">types1.OracleType</td><td class="description-td td_text">Oracle type</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_scale_factor</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Scale factor for oracle prices.</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">maker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">maker_fee_rate defines the trade fee rate for makers on the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">taker_fee_rate</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">taker_fee_rate defines the trade fee rate for takers on the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">expiration_timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration timestamp</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">settlement_timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration timestamp</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">admin</td><td class="type-td td_text">string</td><td class="description-td td_text">admin of the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Address of the quote currency denomination for the binary options contract</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_price_tick_size defines the minimum tick size that the price and margin required for orders in the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_quantity_tick_size defines the minimum tick size of the quantity required for orders in the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">min_notional defines the minimum notional (in quote asset) required for orders in the market</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OracleType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/oracle/v1beta1/OracleType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Band</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">PriceFeed</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Coinbase</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Chainlink</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">Razor</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">Dia</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">API3</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Uma</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">Pyth</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">BandIBC</td></tr>
<tr ><td class="code-td td_num">11</td><td class="name-td td_text">Provider</td></tr>
<tr ><td class="code-td td_num">12</td><td class="name-td td_text">Stork</td></tr></tbody></table>
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


## MsgCreateBinaryOptionsLimitOrder

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/14_MsgCreateBinaryOptionsLimitOrder.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/14_MsgCreateBinaryOptionsLimitOrder.py -->
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
    market_id = "0x767e1542fbc111e88901e223e625a4a8eb6d630c96884bbde672e8bc874075bb"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.msg_create_binary_options_limit_order(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=Decimal("0.5"),
        quantity=Decimal("1"),
        margin=Decimal("0.5"),
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgCreateBinaryOptionsLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">DerivativeOrder</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/DerivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">market_id represents the unique ID of the market</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">order_info contains the information of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">order types</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">margin is the margin used by the limit order</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">trigger_price is the trigger price used by stop/take orders</td></tr>
<tr ><td class="parameter-td td_text">expiration_block</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration block is the block number at which the order will expire</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">bytes32 subaccount ID that created the order</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient</td><td class="type-td td_text">string</td><td class="description-td td_text">address fee_recipient address that will receive fees for the order</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
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
[order_hash: "0xc1e1a8e81659360c3092043a000786f23fce5f3b8a355da32227c3e8eafb1fde"
]
---Transaction Response---
txhash: "7955AE8D7EA90E85F07E776372369E92952A0A86DC9BCBDBA3132447DB738282"
raw_log: "[]"

gas wanted: 121249
gas fee: 0.0000606245 INJ
```

```go

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


## MsgCreateBinaryOptionsMarketOrder

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/15_MsgCreateBinaryOptionsMarketOrder.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/15_MsgCreateBinaryOptionsMarketOrder.py -->
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
    market_id = "0x00617e128fdc0c0423dd18a1ff454511af14c4db6bdd98005a99cdf8fdbf74e9"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.msg_create_binary_options_market_order(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=Decimal("0.5"),
        quantity=Decimal(1),
        margin=composer.calculate_margin(
            quantity=Decimal(1), price=Decimal("0.5"), leverage=Decimal(1), is_reduce_only=False
        ),
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgCreateBinaryOptionsMarketOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">DerivativeOrder</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/DerivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">market_id represents the unique ID of the market</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">order_info contains the information of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">order types</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">margin is the margin used by the limit order</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">trigger_price is the trigger price used by stop/take orders</td></tr>
<tr ><td class="parameter-td td_text">expiration_block</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration block is the block number at which the order will expire</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">bytes32 subaccount ID that created the order</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient</td><td class="type-td td_text">string</td><td class="description-td td_text">address fee_recipient address that will receive fees for the order</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
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
[order_hash: "0x1d4ebeaa75bb6a5232ef20cf9ff10eedc470be8f716fb4b3a57780fb1247b4dc"
]
---Transaction Response---
txhash: "FE91A0828F1900FB9FD202BF872B66580A89E663062B3DF13874328A7F6CF797"
raw_log: "[]"

gas wanted: 107903
gas fee: 0.0000539515 INJ
```

```go

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


## MsgCancelBinaryOptionsOrder

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/16_MsgCancelBinaryOptionsOrder.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/16_MsgCancelBinaryOptionsOrder.py -->
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
    market_id = "0x00617e128fdc0c0423dd18a1ff454511af14c4db6bdd98005a99cdf8fdbf74e9"
    order_hash = "a975fbd72b874bdbf5caf5e1e8e2653937f33ce6dd14d241c06c8b1f7b56be46"

    # prepare tx msg
    msg = composer.msg_cancel_binary_options_order(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        order_hash=order_hash,
        is_buy=True,
        is_market_order=False,
        is_conditional=False,
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgCancelBinaryOptionsOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_mask</td><td class="type-td td_text">int32</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
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

### Response Parameters
> Response Example:

``` python
---Transaction Response---
txhash: "4B85368A96A67BB9B6DABB8B730A824051E0E4C9243F5970DF1512B98FCF2D67"
raw_log: "[]"

gas wanted: 111303
gas fee: 0.0000556515 INJ
```

```go

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


## MsgAdminUpdateBinaryOptionsMarket

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/22_MsgAdminUpdateBinaryOptionsMarket.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/22_MsgAdminUpdateBinaryOptionsMarket.py -->
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

    # prepare trade info
    market_id = "0xfafec40a7b93331c1fc89c23f66d11fbb48f38dfdd78f7f4fc4031fad90f6896"
    status = "Demolished"
    settlement_price = Decimal(1)
    expiration_timestamp = 1685460582
    settlement_timestamp = 1690730982

    # prepare tx msg
    msg = composer.msg_admin_update_binary_options_market(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        settlement_price=settlement_price,
        expiration_timestamp=expiration_timestamp,
        settlement_timestamp=settlement_timestamp,
        status=status,
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgAdminUpdateBinaryOptionsMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">settlement_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">new price at which market will be settled</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">expiration_timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration timestamp</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">settlement_timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration timestamp</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">MarketStatus</td><td class="description-td td_text">Status of the market</td><td class="required-td td_text">Yes</td></tr></tbody></table>
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

### Response Parameters
> Response Example:

``` python
---Transaction Response---
txhash: "4B85368A96A67BB9B6DABB8B730A824051E0E4C9243F5970DF1512B98FCF2D67"
raw_log: "[]"

gas wanted: 111303
gas fee: 0.0000556515 INJ
```

```go

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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/9_MsgBatchUpdateOrders.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/exchange/9_MsgBatchUpdateOrders.py -->
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/exchange/9_MsgBatchUpdateOrders/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/exchange/9_MsgBatchUpdateOrders/example.go -->
```go
package main

import (
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	gasPrice := chainClient.CurrentChainGasPrice()
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

	msg := new(exchangev2types.MsgBatchUpdateOrders)
	msg.Sender = senderAddress.String()
	msg.SubaccountId = defaultSubaccountID.Hex()
	msg.SpotOrdersToCreate = []*exchangev2types.SpotOrder{spot_order}
	msg.DerivativeOrdersToCreate = []*exchangev2types.DerivativeOrder{derivative_order}
	msg.SpotMarketIdsToCancelAll = smarketIds
	msg.DerivativeMarketIdsToCancelAll = dmarketIds

	simRes, err := chainClient.SimulateMsg(clientCtx, msg)

	if err != nil {
		fmt.Println(err)
		return
	}

	MsgBatchUpdateOrdersResponse := exchangev2types.MsgBatchUpdateOrdersResponse{}
	MsgBatchUpdateOrdersResponse.Unmarshal(simRes.Result.MsgResponses[0].Value)

	fmt.Println("simulated spot order hashes", MsgBatchUpdateOrdersResponse.SpotOrderHashes)

	fmt.Println("simulated derivative order hashes", MsgBatchUpdateOrdersResponse.DerivativeOrderHashes)

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	err = chainClient.QueueBroadcastMsg(msg)

	if err != nil {
		fmt.Println(err)
		return
	}

	time.Sleep(time.Second * 5)

	gasFee, err := chainClient.GetGasFee()

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println("gas fee:", gasFee, "INJ")

	gasPrice = chainClient.CurrentChainGasPrice()
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgBatchUpdateOrders.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">subaccount_id only used for the spot_market_ids_to_cancel_all and derivative_market_ids_to_cancel_all.</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">spot_market_ids_to_cancel_all</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">derivative_market_ids_to_cancel_all</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">spot_orders_to_cancel</td><td class="type-td td_text">OrderData array</td><td class="description-td td_num"></td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_orders_to_cancel</td><td class="type-td td_text">OrderData array</td><td class="description-td td_num"></td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">spot_orders_to_create</td><td class="type-td td_text">SpotOrder array</td><td class="description-td td_num"></td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_orders_to_create</td><td class="type-td td_text">DerivativeOrder array</td><td class="description-td td_num"></td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">binary_options_orders_to_cancel</td><td class="type-td td_text">OrderData array</td><td class="description-td td_num"></td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">binary_options_market_ids_to_cancel_all</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">binary_options_orders_to_create</td><td class="type-td td_text">DerivativeOrder array</td><td class="description-td td_num"></td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderData**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/OrderData.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">order_mask</td><td class="type-td td_text">int32</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/SpotOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">market_id represents the unique ID of the market</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">order_info contains the information of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">order types</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">trigger_price is the trigger price used by stop/take orders</td></tr>
<tr ><td class="parameter-td td_text">expiration_block</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration block is the block number at which the order will expire</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/DerivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">market_id represents the unique ID of the market</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">order_info contains the information of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">order types</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">margin is the margin used by the limit order</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">trigger_price is the trigger price used by stop/take orders</td></tr>
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
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price of the order</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity of the order</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
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
