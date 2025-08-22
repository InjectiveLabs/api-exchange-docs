# - InjectivePortfolioRPC
InjectivePortfolioRPC defines the gRPC API of the Exchange Portfolio provider.


## AccountPortfolio

Get details about an account's portfolio.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/portfolio_rpc/1_AccountPortfolio.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/portfolio_rpc/1_AccountPortfolio.py -->
```py
import asyncio
import json

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    account_address = "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
    portfolio = await client.fetch_account_portfolio_balances(account_address=account_address, usd=False)
    print(json.dumps(portfolio, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/portfolio/1_AccountPortfolio/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/portfolio/1_AccountPortfolio/example.go -->
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
	// select network: local, testnet, mainnet
	network := common.LoadNetwork("devnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	accountAddress := "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
	res, err := exchangeClient.GetAccountPortfolioBalances(ctx, accountAddress, true)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_portfolio_rpc/AccountPortfolioBalancesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">string</td><td class="description-td td_text">Account address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">usd</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether to return USD values for the balances</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
{
   "portfolio":{
      "accountAddress":"inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt",
      "bankBalances":[
         {
            "denom":"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/atom",
            "amount":"10000000000"
         },
         {
            "denom":"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/usdc",
            "amount":"10000000000"
         },
         {
            "denom":"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/weth",
            "amount":"5000000000"
         },
         {
            "denom":"inj",
            "amount":"9699395972014420000000"
         },
         {
            "denom":"peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7",
            "amount":"100000000000000000000"
         },
         {
            "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
            "amount":"18689670208"
         }
      ],
      "subaccounts":[
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
            "denom":"inj",
            "deposit":{
               "totalBalance":"11010001000000000000",
               "availableBalance":"11010001000000000000"
            }
         },
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
            "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
            "deposit":{
               "totalBalance":"298666021.6838251182660625",
               "availableBalance":"298666021.6838251182660625"
            }
         },
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002",
            "denom":"inj",
            "deposit":{
               "totalBalance":"1000000000000",
               "availableBalance":"1000000000000"
            }
         },
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
            "denom":"inj",
            "deposit":{
               "totalBalance":"0.458458",
               "availableBalance":"0.458458"
            }
         },
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
            "denom":"peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7",
            "deposit":{
               "totalBalance":"0",
               "availableBalance":"0"
            }
         },
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
            "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
            "deposit":{
               "totalBalance":"0.170858923182467801",
               "availableBalance":"0.170858923182467801"
            }
         }
      ]
   }
}
```

``` go
{
 "portfolio": {
  "account_address": "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt",
  "bank_balances": [
   {
    "denom": "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/atom",
    "amount": "10000000000"
   },
   {
    "denom": "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/usdc",
    "amount": "10000000000"
   },
   {
    "denom": "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/weth",
    "amount": "5000000000"
   },
   {
    "denom": "inj",
    "amount": "9699395972014420000000"
   },
   {
    "denom": "peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7",
    "amount": "100000000000000000000"
   },
   {
    "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
    "amount": "18689670208"
   }
  ],
  "subaccounts": [
   {
    "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
    "denom": "peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7",
    "deposit": {
     "total_balance": "0",
     "available_balance": "0"
    }
   },
   {
    "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
    "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
    "deposit": {
     "total_balance": "0.170858923182467801",
     "available_balance": "0.170858923182467801"
    }
   },
   {
    "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
    "denom": "inj",
    "deposit": {
     "total_balance": "0.458458",
     "available_balance": "0.458458"
    }
   },
   {
    "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
    "denom": "inj",
    "deposit": {
     "total_balance": "11010001000000000000",
     "available_balance": "11010001000000000000"
    }
   },
   {
    "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
    "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
    "deposit": {
     "total_balance": "298666021.6838251182660625",
     "available_balance": "298666021.6838251182660625"
    }
   },
   {
    "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002",
    "denom": "inj",
    "deposit": {
     "total_balance": "1000000000000",
     "available_balance": "1000000000000"
    }
   }
  ]
 }
}

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_portfolio_rpc/AccountPortfolioBalancesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">portfolio</td><td class="type-td td_text">PortfolioBalances</td><td class="description-td td_text">The portfolio balances of this account</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PortfolioBalances**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_portfolio_rpc/PortfolioBalances.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">string</td><td class="description-td td_text">The account's portfolio address</td></tr>
<tr ><td class="parameter-td td_text">bank_balances</td><td class="type-td td_text">Coin array</td><td class="description-td td_text">Account available bank balances</td></tr>
<tr ><td class="parameter-td td_text">subaccounts</td><td class="type-td td_text">SubaccountBalanceV2 array</td><td class="description-td td_text">Subaccounts list</td></tr>
<tr ><td class="parameter-td td_text">total_usd</td><td class="type-td td_text">string</td><td class="description-td td_text">USD value of the portfolio</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_portfolio_rpc/Coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Denom of the coin</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">usd_value</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountBalanceV2**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_portfolio_rpc/SubaccountBalanceV2.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Related subaccount ID</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Coin denom on the chain.</td></tr>
<tr ><td class="parameter-td td_text">deposit</td><td class="type-td td_text">SubaccountDeposit</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountDeposit**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_portfolio_rpc/SubaccountDeposit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">total_balance</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">available_balance</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">total_balance_usd</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">available_balance_usd</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## StreamAccountPortfolio

Get continuous updates on account's portfolio.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/portfolio_rpc/2_StreamAccountPortfolio.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/portfolio_rpc/2_StreamAccountPortfolio.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def account_portfolio_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to account portfolio updates ({exception})")


def stream_closed_processor():
    print("The account portfolio updates stream has been closed")


async def main() -> None:
    network = Network.testnet()
    client = IndexerClient(network)
    account_address = "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"

    task = asyncio.get_event_loop().create_task(
        client.listen_account_portfolio_updates(
            account_address=account_address,
            callback=account_portfolio_event_processor,
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/portfolio/3_StreamAccountPortfolioSubaccountBalances/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/portfolio/3_StreamAccountPortfolioSubaccountBalances/example.go -->
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
	// select network: local, testnet, mainnet
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	stream, err := exchangeClient.StreamAccountPortfolio(ctx, "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt", "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001", "total_balances")
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_portfolio_rpc/StreamAccountPortfolioRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">string</td><td class="description-td td_text">The account's portfolio address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Related subaccount ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
 "type": "total_balances",
 "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
 "amount": "302686408.8456",
 "subaccountId": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
 "timestamp": "342423423"
}
{
 "type": "total_balances",
 "denom": "inj",
 "amount": "11040001000000000000",
 "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
 "timestamp": "342432343"
}
```

``` go
{
 "type": "total_balances",
 "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
 "amount": "302686408.8456",
 "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
}{
 "type": "total_balances",
 "denom": "inj",
 "amount": "11040001000000000000",
 "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_portfolio_rpc/StreamAccountPortfolioResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">string</td><td class="description-td td_text">type of portfolio entry</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">denom of portfolio entry</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">string</td><td class="description-td td_text">amount of portfolio entry</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">subaccount id of portfolio entry</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">Operation timestamp in UNIX millis.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
