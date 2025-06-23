# - Chain Stream
Chain Stream is a gRPC service that allows clients to receive low-latency updates from the Injective Chain.
This API is exposed directly from a dedicated server running on a chain node and provides the fastest way to receive events data (like trades, orders, balances, etc.).
Under the hood, a stream message is computed by the chain node immediately after the event is emitted and is sent to the client via a gRPC stream once the block is committed.



## Stream Request
Its possible to specify multiple filters to customize the stream. 
A filter can be specified with a list of values, generally MarketIds, SubaccountIds and Accounts address.
A filter can also be omitted, in this case the stream will return all the events for the specified type.
In addition each filter supports a `*` wildcard to match all possible values.

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/7_ChainStream.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/7_ChainStream.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def chain_stream_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to chain stream updates ({exception})")


def stream_closed_processor():
    print("The chain stream updates stream has been closed")


async def main() -> None:
    network = Network.testnet()

    client = AsyncClient(network)
    composer = await client.composer()

    subaccount_id = "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000"

    inj_usdt_market = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    inj_usdt_perp_market = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"

    bank_balances_filter = composer.chain_stream_bank_balances_filter(
        accounts=["inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"]
    )
    subaccount_deposits_filter = composer.chain_stream_subaccount_deposits_filter(subaccount_ids=[subaccount_id])
    spot_trades_filter = composer.chain_stream_trades_filter(subaccount_ids=["*"], market_ids=[inj_usdt_market])
    derivative_trades_filter = composer.chain_stream_trades_filter(
        subaccount_ids=["*"], market_ids=[inj_usdt_perp_market]
    )
    spot_orders_filter = composer.chain_stream_orders_filter(
        subaccount_ids=[subaccount_id], market_ids=[inj_usdt_market]
    )
    derivative_orders_filter = composer.chain_stream_orders_filter(
        subaccount_ids=[subaccount_id], market_ids=[inj_usdt_perp_market]
    )
    spot_orderbooks_filter = composer.chain_stream_orderbooks_filter(market_ids=[inj_usdt_market])
    derivative_orderbooks_filter = composer.chain_stream_orderbooks_filter(market_ids=[inj_usdt_perp_market])
    positions_filter = composer.chain_stream_positions_filter(
        subaccount_ids=[subaccount_id], market_ids=[inj_usdt_perp_market]
    )
    oracle_price_filter = composer.chain_stream_oracle_price_filter(symbols=["INJ", "USDT"])

    task = asyncio.get_event_loop().create_task(
        client.listen_chain_stream_updates(
            callback=chain_stream_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            bank_balances_filter=bank_balances_filter,
            subaccount_deposits_filter=subaccount_deposits_filter,
            spot_trades_filter=spot_trades_filter,
            derivative_trades_filter=derivative_trades_filter,
            spot_orders_filter=spot_orders_filter,
            derivative_orders_filter=derivative_orders_filter,
            spot_orderbooks_filter=spot_orderbooks_filter,
            derivative_orderbooks_filter=derivative_orderbooks_filter,
            positions_filter=positions_filter,
            oracle_price_filter=oracle_price_filter,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/12_ChainStream/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/12_ChainStream/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	chainstreamv2 "github.com/InjectiveLabs/sdk-go/chain/stream/types/v2"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		"",
		nil,
	)
	if err != nil {
		panic(err)
	}
	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint)

	chainClient, err := chainclient.NewChainClientV2(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	subaccountId := "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000"

	injUsdtMarket := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	injUsdtPerpMarket := "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"

	req := chainstreamv2.StreamRequest{
		BankBalancesFilter: &chainstreamv2.BankBalancesFilter{
			Accounts: []string{"*"},
		},
		SpotOrdersFilter: &chainstreamv2.OrdersFilter{
			MarketIds:     []string{injUsdtMarket},
			SubaccountIds: []string{subaccountId},
		},
		DerivativeOrdersFilter: &chainstreamv2.OrdersFilter{
			MarketIds:     []string{injUsdtPerpMarket},
			SubaccountIds: []string{subaccountId},
		},
		SpotTradesFilter: &chainstreamv2.TradesFilter{
			MarketIds:     []string{injUsdtMarket},
			SubaccountIds: []string{"*"},
		},
		SubaccountDepositsFilter: &chainstreamv2.SubaccountDepositsFilter{
			SubaccountIds: []string{subaccountId},
		},
		DerivativeOrderbooksFilter: &chainstreamv2.OrderbookFilter{
			MarketIds: []string{injUsdtPerpMarket},
		},
		SpotOrderbooksFilter: &chainstreamv2.OrderbookFilter{
			MarketIds: []string{injUsdtMarket},
		},
		PositionsFilter: &chainstreamv2.PositionsFilter{
			SubaccountIds: []string{subaccountId},
			MarketIds:     []string{injUsdtPerpMarket},
		},
		DerivativeTradesFilter: &chainstreamv2.TradesFilter{
			SubaccountIds: []string{"*"},
			MarketIds:     []string{injUsdtPerpMarket},
		},
		OraclePriceFilter: &chainstreamv2.OraclePriceFilter{
			Symbol: []string{"INJ", "USDT"},
		},
	}

	ctx := context.Background()

	stream, err := chainClient.ChainStreamV2(ctx, req)
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
				panic(err)
				return
			}
			str, _ := json.MarshalIndent(res, "", "\t")
			fmt.Print(string(str))
		}
	}
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/QuerySubaccountDepositsRequest.json -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BankBalancesFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/BankBalancesFilter.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountDepositsFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/SubaccountDepositsFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_ids</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TradesFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/TradesFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_ids</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrdersFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/OrdersFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_ids</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderbookFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/OrderbookFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PositionsFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/PositionsFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_ids</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OraclePriceFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/OraclePriceFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">symbol</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## StreamResponse
The stream response is a stream of events that are sent to the client. 
Each message contains a list of events that are filtered by the request parameters and it's identified by the block height.

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/StreamResponse.json -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BankBalance**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/BankBalance.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountDeposits**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/SubaccountDeposit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">deposit</td><td class="type-td td_text">types.Deposit</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotTrade**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/SpotTrade.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">is_buy</td><td class="type-td td_text">bool</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">executionType</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">bytes32 subaccount ID that executed the trade</td></tr>
<tr ><td class="parameter-td td_text">fee</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">fee_recipient_address</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">trade_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeTrade**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/DerivativeTrade.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">is_buy</td><td class="type-td td_text">bool</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">executionType</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">position_delta</td><td class="type-td td_text">types.PositionDelta</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">payout</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">fee</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">fee_recipient_address</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">trade_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotOrderUpdate**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/SpotOrderUpdate.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">OrderUpdateStatus</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">SpotOrder</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrderUpdate**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/DerivativeOrderUpdate.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">OrderUpdateStatus</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">DerivativeOrder</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderbookUpdate**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/OrderbookUpdate.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">seq</td><td class="type-td td_text">uint64</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">orderbook</td><td class="type-td td_text">Orderbook</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Position**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/Position.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">isLong</td><td class="type-td td_text">bool</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">entry_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">cumulative_funding_entry</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OraclePrice**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/OraclePrice.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">symbol</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderUpdateStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/OrderUpdateStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Booked</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Matched</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Cancelled</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/SpotOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">types.SpotLimitOrder</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/DerivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">types.DerivativeLimitOrder</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">is_market</td><td class="type-td td_text">bool</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/SpotLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">order_info contains the information of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">order types</td></tr>
<tr ><td class="parameter-td td_text">fillable</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the amount of the quantity remaining fillable</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">trigger_price is the trigger price used by stop/take orders</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">byte array</td><td class="description-td td_text">order hash</td></tr>
<tr ><td class="parameter-td td_text">expiration_block</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration block is the block number at which the order will expire</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/DerivativeLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">order_info contains the information of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">order types</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">margin is the margin used by the limit order</td></tr>
<tr ><td class="parameter-td td_text">fillable</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the amount of the quantity remaining fillable</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">trigger_price is the trigger price used by stop/take orders</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">byte array</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">expiration_block</td><td class="type-td td_text">int64</td><td class="description-td td_text">expiration block is the block number at which the order will expire</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Orderbook**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/Orderbook.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">buy_levels</td><td class="type-td td_text">types.Level array</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">sell_levels</td><td class="type-td td_text">types.Level array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Level**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/Level.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">p</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price</td></tr>
<tr ><td class="parameter-td td_text">q</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
