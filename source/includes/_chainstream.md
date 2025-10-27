# - Chain Stream
Chain Stream is a gRPC service that allows clients to receive low-latency updates from the Injective Chain.
This API is exposed directly from a dedicated server running on a chain node and provides the fastest way to receive events data (like trades, orders, balances, etc.).
Under the hood, a stream message is computed by the chain node immediately after the event is emitted and is sent to the client via a gRPC stream once the block is committed.



## Stream Request
Its possible to specify multiple filters to customize the stream. 
A filter can be specified with a list of values, generally MarketIds, SubaccountIds and Accounts address.
A filter can also be omitted, in this case the stream will return all the events for the specified type.
In addition each filter supports a `*` wildcard to match all possible values.

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/7_ChainStream.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/7_ChainStream.py -->
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
    order_failures_filter = composer.chain_stream_order_failures_filter(
        accounts=["inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"]
    )
    conditional_order_trigger_failures_filter = composer.chain_stream_conditional_order_trigger_failures_filter(
        subaccount_ids=[subaccount_id], market_ids=[inj_usdt_perp_market]
    )

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
            order_failures_filter=order_failures_filter,
            conditional_order_trigger_failures_filter=conditional_order_trigger_failures_filter,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/12_ChainStream/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/12_ChainStream/example.go -->
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
		OrderFailuresFilter: &chainstreamv2.OrderFailuresFilter{
			Accounts: []string{"*"},
		},
		ConditionalOrderTriggerFailuresFilter: &chainstreamv2.ConditionalOrderTriggerFailuresFilter{
			SubaccountIds: []string{subaccountId},
			MarketIds:     []string{injUsdtPerpMarket},
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
			}
			str, _ := json.MarshalIndent(res, "", "\t")
			fmt.Print(string(str))
		}
	}
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/StreamRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bank_balances_filter</td><td class="type-td td_text">BankBalancesFilter</td><td class="description-td td_text">filter for bank balances events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">subaccount_deposits_filter</td><td class="type-td td_text">SubaccountDepositsFilter</td><td class="description-td td_text">filter for subaccount deposits events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">spot_trades_filter</td><td class="type-td td_text">TradesFilter</td><td class="description-td td_text">filter for spot trades events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_trades_filter</td><td class="type-td td_text">TradesFilter</td><td class="description-td td_text">filter for derivative trades events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">spot_orders_filter</td><td class="type-td td_text">OrdersFilter</td><td class="description-td td_text">filter for spot orders events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_orders_filter</td><td class="type-td td_text">OrdersFilter</td><td class="description-td td_text">filter for derivative orders events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">spot_orderbooks_filter</td><td class="type-td td_text">OrderbookFilter</td><td class="description-td td_text">filter for spot orderbooks events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_orderbooks_filter</td><td class="type-td td_text">OrderbookFilter</td><td class="description-td td_text">filter for derivative orderbooks events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">positions_filter</td><td class="type-td td_text">PositionsFilter</td><td class="description-td td_text">filter for positions events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">oracle_price_filter</td><td class="type-td td_text">OraclePriceFilter</td><td class="description-td td_text">filter for oracle prices events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">order_failures_filter</td><td class="type-td td_text">OrderFailuresFilter</td><td class="description-td td_text">filter for order failures events</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">conditional_order_trigger_failures_filter</td><td class="type-td td_text">ConditionalOrderTriggerFailuresFilter</td><td class="description-td td_text">filter for conditional order trigger failures events</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BankBalancesFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/BankBalancesFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">accounts</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of account addresses to filter by</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountDepositsFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/SubaccountDepositsFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of subaccount IDs to filter by</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TradesFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/TradesFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of subaccount IDs to filter by</td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of market IDs to filter by</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrdersFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/OrdersFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of subaccount IDs to filter by</td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of market IDs to filter by</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderbookFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/OrderbookFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of market IDs to filter by</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PositionsFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/PositionsFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of subaccount IDs to filter by</td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of market IDs to filter by</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OraclePriceFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/OraclePriceFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">symbol</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of symbols to filter by</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderFailuresFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/OrderFailuresFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">accounts</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of account addresses to filter by</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ConditionalOrderTriggerFailuresFilter**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/ConditionalOrderTriggerFailuresFilter.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of subaccount IDs to filter by</td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of market IDs to filter by</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## StreamResponse
The stream response is a stream of events that are sent to the client. 
Each message contains a list of events that are filtered by the request parameters and it's identified by the block height.

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/StreamResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">block_height</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the block height</td></tr>
<tr ><td class="parameter-td td_text">block_time</td><td class="type-td td_text">int64</td><td class="description-td td_text">the block time</td></tr>
<tr ><td class="parameter-td td_text">bank_balances</td><td class="type-td td_text">BankBalance array</td><td class="description-td td_text">list of bank balances updates</td></tr>
<tr ><td class="parameter-td td_text">subaccount_deposits</td><td class="type-td td_text">SubaccountDeposits array</td><td class="description-td td_text">list of subaccount deposits updates</td></tr>
<tr ><td class="parameter-td td_text">spot_trades</td><td class="type-td td_text">SpotTrade array</td><td class="description-td td_text">list of spot trades updates</td></tr>
<tr ><td class="parameter-td td_text">derivative_trades</td><td class="type-td td_text">DerivativeTrade array</td><td class="description-td td_text">list of derivative trades updates</td></tr>
<tr ><td class="parameter-td td_text">spot_orders</td><td class="type-td td_text">SpotOrderUpdate array</td><td class="description-td td_text">list of spot orders updates</td></tr>
<tr ><td class="parameter-td td_text">derivative_orders</td><td class="type-td td_text">DerivativeOrderUpdate array</td><td class="description-td td_text">list of derivative orders updates</td></tr>
<tr ><td class="parameter-td td_text">spot_orderbook_updates</td><td class="type-td td_text">OrderbookUpdate array</td><td class="description-td td_text">list of spot orderbook updates</td></tr>
<tr ><td class="parameter-td td_text">derivative_orderbook_updates</td><td class="type-td td_text">OrderbookUpdate array</td><td class="description-td td_text">list of derivative orderbook updates</td></tr>
<tr ><td class="parameter-td td_text">positions</td><td class="type-td td_text">Position array</td><td class="description-td td_text">list of positions updates</td></tr>
<tr ><td class="parameter-td td_text">oracle_prices</td><td class="type-td td_text">OraclePrice array</td><td class="description-td td_text">list of oracle prices updates</td></tr>
<tr ><td class="parameter-td td_text">gas_price</td><td class="type-td td_text">string</td><td class="description-td td_text">the current gas price when the block was processed (in chain format)</td></tr>
<tr ><td class="parameter-td td_text">order_failures</td><td class="type-td td_text">OrderFailureUpdate array</td><td class="description-td td_text">list of order failures updates</td></tr>
<tr ><td class="parameter-td td_text">conditional_order_trigger_failures</td><td class="type-td td_text">ConditionalOrderTriggerFailureUpdate array</td><td class="description-td td_text">list of conditional order trigger failures updates</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BankBalance**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/BankBalance.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account</td><td class="type-td td_text">string</td><td class="description-td td_text">the account address</td></tr>
<tr ><td class="parameter-td td_text">balances</td><td class="type-td td_text">github_com_cosmos_cosmos_sdk_types.Coins</td><td class="description-td td_text">list of account balances</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountDeposits**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/SubaccountDeposit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">deposit</td><td class="type-td td_text">v2.Deposit</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotTrade**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/SpotTrade.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the market ID</td></tr>
<tr ><td class="parameter-td td_text">is_buy</td><td class="type-td td_text">bool</td><td class="description-td td_text">whether the trade is a buy or sell</td></tr>
<tr ><td class="parameter-td td_text">executionType</td><td class="type-td td_text">string</td><td class="description-td td_text">the execution type</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the quantity of the trade (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the price of the trade (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the subaccount ID that executed the trade</td></tr>
<tr ><td class="parameter-td td_text">fee</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the fee of the trade (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient_address</td><td class="type-td td_text">string</td><td class="description-td td_text">the fee recipient address</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID</td></tr>
<tr ><td class="parameter-td td_text">trade_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the trade ID</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeTrade**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/DerivativeTrade.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the market ID</td></tr>
<tr ><td class="parameter-td td_text">is_buy</td><td class="type-td td_text">bool</td><td class="description-td td_text">whether the trade is a buy or sell</td></tr>
<tr ><td class="parameter-td td_text">executionType</td><td class="type-td td_text">string</td><td class="description-td td_text">the execution type</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the subaccount ID</td></tr>
<tr ><td class="parameter-td td_text">position_delta</td><td class="type-td td_text">v2.PositionDelta</td><td class="description-td td_text">the position delta of the trade (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">payout</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the payout of the trade (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">fee</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the fee of the trade (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient_address</td><td class="type-td td_text">string</td><td class="description-td td_text">the fee recipient address</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID</td></tr>
<tr ><td class="parameter-td td_text">trade_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the trade ID</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotOrderUpdate**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/SpotOrderUpdate.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">OrderUpdateStatus</td><td class="description-td td_text">the status of the order</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">SpotOrder</td><td class="description-td td_text">the order details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrderUpdate**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/DerivativeOrderUpdate.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">OrderUpdateStatus</td><td class="description-td td_text">the status of the order</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">DerivativeOrder</td><td class="description-td td_text">the order details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderbookUpdate**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/OrderbookUpdate.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">seq</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the sequence number of the orderbook update</td></tr>
<tr ><td class="parameter-td td_text">orderbook</td><td class="type-td td_text">Orderbook</td><td class="description-td td_text">the orderbook details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Position**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/Position.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the market ID</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the subaccount ID</td></tr>
<tr ><td class="parameter-td td_text">isLong</td><td class="type-td td_text">bool</td><td class="description-td td_text">whether the position is long or short</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the quantity of the position (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">entry_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the entry price of the position (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the margin of the position (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">cumulative_funding_entry</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the cumulative funding entry of the position (in human readable format)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OraclePrice**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/OraclePrice.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">the symbol of the oracle price</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the updated price</td></tr>
<tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">string</td><td class="description-td td_text">the oracle type</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderFailureUpdate**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/OrderFailureUpdate.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account</td><td class="type-td td_text">string</td><td class="description-td td_text">the account address</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID</td></tr>
<tr ><td class="parameter-td td_text">error_code</td><td class="type-td td_text">uint32</td><td class="description-td td_text">the error code</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ConditionalOrderTriggerFailureUpdate**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/ConditionalOrderTriggerFailureUpdate.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the market ID</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the subaccount ID</td></tr>
<tr ><td class="parameter-td td_text">mark_price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">the mark price</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">string</td><td class="description-td td_text">the order hash</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">string</td><td class="description-td td_text">the client order ID</td></tr>
<tr ><td class="parameter-td td_text">error_description</td><td class="type-td td_text">string</td><td class="description-td td_text">the error code</td></tr></tbody></table>
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/SpotOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the market ID</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">v2.SpotLimitOrder</td><td class="description-td td_text">the order details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/DerivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the market ID</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">v2.DerivativeLimitOrder</td><td class="description-td td_text">the order details</td></tr>
<tr ><td class="parameter-td td_text">is_market</td><td class="type-td td_text">bool</td><td class="description-td td_text">whether the order is a market order</td></tr></tbody></table>
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/stream/v2/Orderbook.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the market ID</td></tr>
<tr ><td class="parameter-td td_text">buy_levels</td><td class="type-td td_text">v2.Level array</td><td class="description-td td_text">list of buy levels</td></tr>
<tr ><td class="parameter-td td_text">sell_levels</td><td class="type-td td_text">v2.Level array</td><td class="description-td td_text">list of sell levels</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Level**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/Level.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">p</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">price (in human readable format)</td></tr>
<tr ><td class="parameter-td td_text">q</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec</td><td class="description-td td_text">quantity (in human readable format)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
