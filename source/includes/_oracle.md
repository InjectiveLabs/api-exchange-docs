# - Oracle
Includes the message to relay a price feed.


## MsgRelayPriceFeedPrice

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/oracle/1_MsgRelayPriceFeedPrice.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/oracle/1_MsgRelayPriceFeedPrice.py -->
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

    price = 100
    price_to_send = [str(int(price * 10**18))]
    base = ["BAYC"]
    quote = ["WETH"]

    # prepare tx msg
    msg = composer.msg_relay_price_feed_price(
        sender=address.to_acc_bech32(), price=price_to_send, base=base, quote=quote
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/oracle/1_MsgRelayPriceFeedPrice/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/oracle/1_MsgRelayPriceFeedPrice/example.go -->
```go
package main

import (
	"context"
	"fmt"
	"os"
	"time"

	"cosmossdk.io/math"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	txtypes "github.com/cosmos/cosmos-sdk/types/tx"

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

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	gasPrice := chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)

	price := []math.LegacyDec{math.LegacyMustNewDecFromStr("100")}
	base := []string{"BAYC"}
	quote := []string{"WETH"}

	msg := &oracletypes.MsgRelayPriceFeedPrice{
		Sender: senderAddress.String(),
		Price:  price,
		Base:   base,
		Quote:  quote,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	_, result, err := chainClient.BroadcastMsg(ctx, txtypes.BroadcastMode_BROADCAST_MODE_SYNC, msg)

	if err != nil {
		panic(err)
	}

	fmt.Printf("Broadcast result: %s\n", result)

	gasPrice = chainClient.CurrentChainGasPrice(ctx)
	// adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
	gasPrice = int64(float64(gasPrice) * 1.1)
	chainClient.SetGasPrice(gasPrice)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/oracle/MsgRelayPriceFeedPrice.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">base</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quote</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec array</td><td class="description-td td_text">price defines the price of the oracle base and quote</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


> Response Example:

``` python
txhash: "88F5B9C28813BB32607DF312A5411390F43C44F5E1F9D3BA0023EFE0EE4BD0EC"
raw_log: "[]"

gas wanted: 93486
gas fee: 0.000046743 INJ
```

```go
DEBU[0001] broadcastTx with nonce 1314                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5215101  fn=func1 src="client/chain/chain.go:619" txHash=641DE5923625C1A81C2544B72E5029E53AE721E47F40221182AFAD6F66F39EA4
DEBU[0002] nonce incremented to 1315                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  113647                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000568235 INJ
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


## MsgRelayProviderPrices

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/oracle/2_MsgRelayProviderPrices.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/oracle/2_MsgRelayProviderPrices.py -->
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

    provider = "ufc"
    symbols = ["KHABIB-TKO-05/30/2023", "KHABIB-TKO-05/26/2023"]
    prices = [0.5, 0.8]

    # prepare tx msg
    msg = composer.msg_relay_provider_prices(
        sender=address.to_acc_bech32(), provider=provider, symbols=symbols, prices=prices
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/oracle/MsgRelayProviderPrices.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">provider</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">symbols</td><td class="type-td td_text">string array</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">prices</td><td class="type-td td_text">cosmossdk_io_math.LegacyDec array</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


> Response Example:

``` python
---Transaction Response---
txhash: "784728B42AD56D0241B166A531815FC82511432FF636E2AD22CBA856123F4AB1"
raw_log: "[]"

gas wanted: 172751
gas fee: 0.0000863755 INJ
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
