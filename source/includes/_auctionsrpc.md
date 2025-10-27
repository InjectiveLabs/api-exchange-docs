# - InjectiveAuctionRPC
InjectiveAuctionRPC defines the gRPC API of the Auction provider.


## Auction

Get the details of a specific auction.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/auctions_rpc/1_Auction.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/auctions_rpc/1_Auction.py -->
```py
import asyncio
import json

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    bid_round = 31
    auction = await client.fetch_auction(round=bid_round)
    print(json.dumps(auction, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/auction/1_Auction/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/auction/1_Auction/example.go -->
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	round := int64(35)
	res, err := exchangeClient.GetAuction(ctx, round)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_auction_rpc/AuctionEndpointRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">round</td><td class="type-td td_text">int64</td><td class="description-td td_text">The auction round number. -1 for latest.</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "auction":{
      "winner":"inj1uyk56r3xdcf60jwrmn7p9rgla9dc4gam56ajrq",
      "basket":[
         {
            "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
            "amount":"2322098"
         }
      ],
      "winningBidAmount":"2000000000000000000",
      "round":"31",
      "endTimestamp":"1676013187000",
      "updatedAt":"1677075140258"
   },
   "bids":[
      {
         "bidder":"inj1pdxq82m20fzkjn2th2mm5jp7t5ex6j6klf9cs5",
         "amount":"1000000000000000000",
         "timestamp":"1675426622603"
      },
      {
         "bidder":"inj1tu9xwxms5dvz3782tjal0fy5rput78p3k5sfv6",
         "amount":"1010000000000000000",
         "timestamp":"1675427580363"
      },
      {
         "bidder":"inj1sdkt803zwq2tpej0k2a0z58hwyrnerzfsxj356",
         "amount":"1030000000000000000",
         "timestamp":"1675482275821"
      },
      {
         "bidder":"inj1uyk56r3xdcf60jwrmn7p9rgla9dc4gam56ajrq",
         "amount":"2000000000000000000",
         "timestamp":"1675595586380"
      }
   ]
}
```

``` go
{
 "auction": {
  "basket": [
   {
    "denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
    "amount": "20541163349"
   },
   {
    "denom": "peggy0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
    "amount": "3736040925000000"
   },
   {
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "amount": "383119139180"
   }
  ],
  "round": 13534,
  "end_timestamp": 1650635285000,
  "updated_at": 1650978958302
 }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_auction_rpc/AuctionEndpointResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">auction</td><td class="type-td td_text">Auction</td><td class="description-td td_text">The auction</td></tr>
<tr ><td class="parameter-td td_text">bids</td><td class="type-td td_text">Bid array</td><td class="description-td td_text">Bids of the auction</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

</br>

**Auction**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_auction_rpc/Auction.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">winner</td><td class="type-td td_text">string</td><td class="description-td td_text">Account address of the auction winner</td></tr>
<tr ><td class="parameter-td td_text">basket</td><td class="type-td td_text">Coin array</td><td class="description-td td_text">Coins in the basket</td></tr>
<tr ><td class="parameter-td td_text">winning_bid_amount</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">round</td><td class="type-td td_text">uint64</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">end_timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">Auction end timestamp in UNIX millis.</td></tr>
<tr ><td class="parameter-td td_text">updated_at</td><td class="type-td td_text">int64</td><td class="description-td td_text">UpdatedAt timestamp in UNIX millis.</td></tr>
<tr ><td class="parameter-td td_text">contract</td><td class="type-td td_text">AuctionContract</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

</br>

**Bid**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_auction_rpc/bid.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bidder</td><td class="type-td td_text">string</td><td class="description-td td_text">Account address of the bidder</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">Bid timestamp in UNIX millis.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

</br>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_auction_rpc/coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Denom of the coin</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">usd_value</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Auctions

Get the details of previous auctions.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/auctions_rpc/2_Auctions.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/auctions_rpc/2_Auctions.py -->
```py
import asyncio
import json

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    auctions = await client.fetch_auctions()
    print(json.dumps(auctions, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/auction/2_Auctions/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/auction/2_Auctions/example.go -->
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	res, err := exchangeClient.GetAuctions(ctx)
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

``` python
{
   "auctions":[
      {
         "basket":[
            {
               "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
               "amount":"188940000"
            }
         ],
         "round":"1",
         "endTimestamp":"1657869187000",
         "updatedAt":"1658131202118",
         "winner":"",
         "winningBidAmount":""
      },
      {
         "basket":[
            {
               "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
               "amount":"219025410"
            }
         ],
         "round":"2",
         "endTimestamp":"1658473987000",
         "updatedAt":"1658134858904",
         "winner":"",
         "winningBidAmount":""
      },
      ...
      {
         "winner":"inj1rk9fguz9zjwtqm3t6e9fzp7n9dd7jfhaw9dcc4",
         "basket":[
            {
               "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
               "amount":"1066722260002"
            }
         ],
         "winningBidAmount":"3007530000000000000000",
         "round":"73",
         "endTimestamp":"1701414787000",
         "updatedAt":"1700809987278"
      },
      {
         "basket":[
            {
               "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
               "amount":"1137356301548"
            },
            {
               "denom":"peggy0xf9152067989BDc8783fF586624124C05A529A5D1",
               "amount":"128519416"
            }
         ],
         "round":"74",
         "endTimestamp":"1702019587000",
         "updatedAt":"1701414788278",
         "winner":"",
         "winningBidAmount":""
      }
   ]
}
```

``` go
{
 "auctions": [
  {
   "basket": [
    {
     "denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
     "amount": "20541163349"
    },
    {
     "denom": "peggy0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
     "amount": "3736040925000000"
    },
    {
     "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
     "amount": "383119139180"
    }
   ],
   "round": 13435,
   "end_timestamp": 1650575885000,
   "updated_at": 1650978931464
  },
  {
   "basket": [
    {
     "denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
     "amount": "20541163349"
    },
    {
     "denom": "peggy0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
     "amount": "3736040925000000"
    },
    {
     "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
     "amount": "383119139180"
    }
   ],
   "round": 13436,
   "end_timestamp": 1650576485000,
   "updated_at": 1650978931847
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_auction_rpc/AuctionsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">auctions</td><td class="type-td td_text">Auction array</td><td class="description-td td_text">The historical auctions</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

</br>

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_auction_rpc/Auction.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">winner</td><td class="type-td td_text">string</td><td class="description-td td_text">Account address of the auction winner</td></tr>
<tr ><td class="parameter-td td_text">basket</td><td class="type-td td_text">Coin array</td><td class="description-td td_text">Coins in the basket</td></tr>
<tr ><td class="parameter-td td_text">winning_bid_amount</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">round</td><td class="type-td td_text">uint64</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">end_timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">Auction end timestamp in UNIX millis.</td></tr>
<tr ><td class="parameter-td td_text">updated_at</td><td class="type-td td_text">int64</td><td class="description-td td_text">UpdatedAt timestamp in UNIX millis.</td></tr>
<tr ><td class="parameter-td td_text">contract</td><td class="type-td td_text">AuctionContract</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

</br>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_auction_rpc/coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Denom of the coin</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">usd_value</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## InjBurntEndpoint

Returns the total amount of INJ burnt in auctions.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/auctions_rpc/4_InjBurntEndpoint.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/auctions_rpc/4_InjBurntEndpoint.py -->
```py
import asyncio
import json

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main():
    # Select network: testnet, mainnet, or local
    network = Network.testnet()
    client = IndexerClient(network)

    try:
        # Fetch INJ burnt amount
        inj_burnt_response = await client.fetch_inj_burnt()
        print("INJ Burnt Endpoint Response:")
        print(json.dumps(inj_burnt_response, indent=2))

    except Exception as e:
        print(f"Error fetching INJ burnt amount: {e}")


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/auction/4_InjBurntEndpoint/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/auction/4_InjBurntEndpoint/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"time"

	"github.com/InjectiveLabs/sdk-go/client/common"
	"github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchange.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	// Fetch INJ burnt details
	injBurntResponse, err := exchangeClient.FetchInjBurnt(ctx)
	if err != nil {
		fmt.Printf("Failed to fetch INJ burnt details: %v\n", err)
		return
	}

	// Print JSON representation of the response
	jsonResponse, err := json.MarshalIndent(injBurntResponse, "", "  ")
	if err != nil {
		fmt.Printf("Failed to marshal response to JSON: %v\n", err)
		return
	}

	fmt.Println("INJ Burnt Details:")
	fmt.Println(string(jsonResponse))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters

### Response Parameters
> Response Example:

``` json
{
  "total_inj_burnt": "15336250729"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_auction_rpc/injBurntEndpointResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">total_inj_burnt</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## StreamBids

Stream live updates for auction bids.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/auctions_rpc/3_StreamBids.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/auctions_rpc/3_StreamBids.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def bid_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to bids updates ({exception})")


def stream_closed_processor():
    print("The bids updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)

    task = asyncio.get_event_loop().create_task(
        client.listen_bids_updates(
            callback=bid_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/auction/3_StreamBids/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/auction/3_StreamBids/example.go -->
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	stream, err := exchangeClient.StreamBids(ctx)
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

No parameters


### Response Parameters
> Response Example:

``` python
{
  "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "bidAmount": "1000000000000000000",
  "round": 19532,
  "timestamp": 1654233511715
}
{
  "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "bidAmount": "3000000000000000000",
  "round": 19532,
  "timestamp": 1654233530633
}
```

``` go
{
 "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
 "bid_amount": "1000000000000000000",
 "round": 17539,
 "timestamp": 1653038036697
}{
 "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
 "bid_amount": "2000000000000000000",
 "round": 17539,
 "timestamp": 1653038046359
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_auction_rpc/streamBidsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bidder</td><td class="type-td td_text">string</td><td class="description-td td_text">Account address of the bidder</td></tr>
<tr ><td class="parameter-td td_text">bid_amount</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">round</td><td class="type-td td_text">uint64</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">Operation timestamp in UNIX millis.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
