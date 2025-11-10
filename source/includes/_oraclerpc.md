# - InjectiveOracleRPC
InjectiveOracleRPC defines the gRPC API of the Exchange Oracle provider.


## OracleList

Get a list of all oracles.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/oracle_rpc/3_OracleList.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/oracle_rpc/3_OracleList.py -->
```py
import asyncio
import json

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    oracle_list = await client.fetch_oracle_list()
    print(json.dumps(oracle_list, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/oracle/3_OracleList/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/oracle/3_OracleList/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("mainnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	res, err := exchangeClient.GetOracleList(ctx)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "oracles":[
      {
         "symbol":"BTC",
         "oracleType":"bandibc",
         "price":"16835.93",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"ETH",
         "oracleType":"bandibc",
         "price":"1251.335",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"INJ",
         "oracleType":"bandibc",
         "price":"1.368087992",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"USDT",
         "oracleType":"bandibc",
         "price":"0.999785552",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"FRNT/USDT",
         "baseSymbol":"FRNT",
         "quoteSymbol":"USDT",
         "oracleType":"pricefeed",
         "price":"0.5"
      },
      {
         "symbol":"0xb327d9cf0ecd793a175fa70ac8d2dc109d4462758e556962c4a87b02ec4f3f15",
         "baseSymbol":"0xb327d9cf0ecd793a175fa70ac8d2dc109d4462758e556962c4a87b02ec4f3f15",
         "quoteSymbol":"0xb327d9cf0ecd793a175fa70ac8d2dc109d4462758e556962c4a87b02ec4f3f15",
         "oracleType":"pyth",
         "price":"7.33638432"
      },
      {
         "symbol":"0xecf553770d9b10965f8fb64771e93f5690a182edc32be4a3236e0caaa6e0581a",
         "baseSymbol":"0xecf553770d9b10965f8fb64771e93f5690a182edc32be4a3236e0caaa6e0581a",
         "quoteSymbol":"0xecf553770d9b10965f8fb64771e93f5690a182edc32be4a3236e0caaa6e0581a",
         "oracleType":"pyth",
         "price":"225.28704062"
      }
   ]
}
```

``` go
{
 "oracles": [
  {
   "symbol": "ANC",
   "oracle_type": "bandibc",
   "price": "2.212642692"
  },
  {
   "symbol": "ATOM",
   "oracle_type": "bandibc",
   "price": "24.706861402"
  },
  {
   "symbol": "ZRX",
   "oracle_type": "coinbase",
   "price": "0.9797"
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_oracle_rpc/OracleListResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">oracles</td><td class="type-td td_text">Oracle array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Oracle**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_oracle_rpc/Oracle.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">The symbol of the oracle asset.</td></tr>
<tr ><td class="parameter-td td_text">base_symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle base currency</td></tr>
<tr ><td class="parameter-td td_text">quote_symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle quote currency</td></tr>
<tr ><td class="parameter-td td_text">oracle_type</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle Type</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">string</td><td class="description-td td_text">The price of the oracle asset</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Price

Get the oracle price of an asset.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/oracle_rpc/2_Price.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/oracle_rpc/2_Price.py -->
```py
import asyncio
import json

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    market = (await client.all_derivative_markets())[
        "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    ]

    base_symbol = market.oracle_base
    quote_symbol = market.oracle_quote
    oracle_type = market.oracle_type

    oracle_prices = await client.fetch_oracle_price(
        base_symbol=base_symbol,
        quote_symbol=quote_symbol,
        oracle_type=oracle_type,
    )
    print(json.dumps(oracle_prices, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/oracle/2_Price/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/oracle/2_Price/example.go -->
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
	"github.com/InjectiveLabs/sdk-go/client/core"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
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
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		fmt.Println(err)
		return
	}

	ctx := context.Background()
	marketsAssistant, err := chainclient.NewHumanReadableMarketsAssistant(ctx, chainClient)
	if err != nil {
		panic(err)
	}

	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	market := marketsAssistant.AllDerivativeMarkets()["0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"]
	derivativeMarket, ok := market.(core.DerivativeMarketV2)
	if !ok {
		panic("market is not a derivative market")
	}

	baseSymbol := derivativeMarket.OracleBase
	quoteSymbol := derivativeMarket.OracleQuote
	oracleType := derivativeMarket.OracleType
	oracleScaleFactor := uint32(0)
	res, err := exchangeClient.GetPrice(ctx, baseSymbol, quoteSymbol, oracleType, oracleScaleFactor)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_oracle_rpc/PriceRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">base_symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle base currency</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quote_symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle quote currency</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_type</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle Type</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_scale_factor</td><td class="type-td td_text">uint32</td><td class="description-td td_text">OracleScaleFactor</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{ "price": '1.368087992' }
```

``` go
{
 "price": "40128736026.4094317665"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_oracle_rpc/PriceResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">string</td><td class="description-td td_text">The price of the oracle asset</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## StreamPrices

Stream new price changes for a specified oracle. If no oracles are provided, all price changes are streamed.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/oracle_rpc/1_StreamPrices.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/oracle_rpc/1_StreamPrices.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def price_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to oracle prices updates ({exception})")


def stream_closed_processor():
    print("The oracle prices updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    market = (await client.all_derivative_markets())[
        "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    ]

    base_symbol = market.oracle_base
    quote_symbol = market.oracle_quote
    oracle_type = market.oracle_type.lower()

    task = asyncio.get_event_loop().create_task(
        client.listen_oracle_prices_updates(
            callback=price_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            base_symbol=base_symbol,
            quote_symbol=quote_symbol,
            oracle_type=oracle_type,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/oracle/1_StreamPrices/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/oracle/1_StreamPrices/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"strings"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	"github.com/InjectiveLabs/sdk-go/client/core"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
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
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		fmt.Println(err)
		return
	}

	ctx := context.Background()
	marketsAssistant, err := chainclient.NewHumanReadableMarketsAssistant(ctx, chainClient)
	if err != nil {
		panic(err)
	}

	market := marketsAssistant.AllDerivativeMarkets()["0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"]
	derivativeMarket, ok := market.(core.DerivativeMarketV2)
	if !ok {
		panic("market is not a derivative market")
	}

	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	baseSymbol := derivativeMarket.OracleBase
	quoteSymbol := derivativeMarket.OracleQuote
	oracleType := strings.ToLower(derivativeMarket.OracleType)

	stream, err := exchangeClient.StreamPrices(ctx, baseSymbol, quoteSymbol, oracleType)
	if err != nil {
		panic(err)
	}

	for {
		select {
		case <-ctx.Done():
			return
		default:
			res, err := stream.Recv()
			if err != nil {
				fmt.Println(err)
				return
			}
			str, _ := json.MarshalIndent(res, "", "\t")
			fmt.Print(string(str))
		}
	}
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_oracle_rpc/StreamPricesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">base_symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle base currency</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quote_symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle quote currency</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_type</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle Type</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Streaming Response Example:

``` python
{
   "price":"1.3683814386627584",
   "timestamp":"1702043286264"
}
```

``` go
{
 "price": "40128.7360264094317665",
 "timestamp": 1653038843915
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_oracle_rpc/StreamPricesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">string</td><td class="description-td td_text">The price of the oracle asset</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">Operation timestamp in UNIX millis.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
