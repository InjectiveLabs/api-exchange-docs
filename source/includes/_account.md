# - Account

Includes all messages related to accounts and transfers.


## MsgDeposit

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/1_MsgDeposit.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/1_MsgDeposit.py -->
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

    # prepare tx msg
    msg = composer.msg_deposit(sender=address.to_acc_bech32(), subaccount_id=subaccount_id, amount=1, denom="inj")

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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/1_MsgDeposit/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/1_MsgDeposit/example.go -->
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
	sdktypes "github.com/cosmos/cosmos-sdk/types"
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

	msg := exchangev2types.MsgDeposit{
		Sender:       senderAddress.String(),
		SubaccountId: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
		Amount: sdktypes.Coin{
			Denom: "inj", Amount: math.NewInt(1000000000000000000), // 1 INJ
		},
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgDeposit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">the sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">(Optional) the subaccount ID to deposit funds into. If empty, the coin will be deposited to the sender's default subaccount address.</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">types.Coin</td><td class="description-td td_text">the amount of the deposit (in chain format)</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/Coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">cosmossdk_io_math.Int</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "49CA54DA708B5F58E401B661A8A6B590447AFCFCD192D95AE2DAFDBEB00DCD33"
raw_log: "[]"

gas wanted: 105793
gas fee: 0.0000528965 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3491                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5212649  fn=func1 src="client/chain/chain.go:619" txHash=8B3F45BB7247C0BFC916B4D9177601E512BBAEF8FA60E5B61D5CC815910D059F
DEBU[0002] nonce incremented to 3492                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  132099                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000660495 INJ
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


## MsgWithdraw

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/2_MsgWithdraw.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/2_MsgWithdraw.py -->
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
    denom = "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"

    # prepare tx msg
    msg = composer.msg_withdraw(sender=address.to_acc_bech32(), subaccount_id=subaccount_id, amount=1, denom=denom)

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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/2_MsgWithdraw/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/2_MsgWithdraw/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	"cosmossdk.io/math"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
	txtypes "github.com/cosmos/cosmos-sdk/types/tx"

	exchangev2types "github.com/InjectiveLabs/sdk-go/chain/exchange/types/v2"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
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

	msg := exchangev2types.MsgWithdraw{
		Sender:       senderAddress.String(),
		SubaccountId: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
		Amount: sdktypes.Coin{
			Denom: "inj", Amount: math.NewInt(1000000000000000000), // 1 INJ
		},
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgWithdraw.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">the sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the subaccount ID to withdraw funds from</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">types.Coin</td><td class="description-td td_text">the amount of the withdrawal (in chain format)</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/Coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">cosmossdk_io_math.Int</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "30724652FB970C8C08B0179D134AC519795068885541B08C6BB0AE3E8F0E59CE"
raw_log: "[]"

gas wanted: 111105
gas fee: 0.0000555525 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3504                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5214520  fn=func1 src="client/chain/chain.go:619" txHash=B73529AE8EE92B931B5E52102DE67251B71B492421D718644A79ED826BD6B451
DEBU[0004] nonce incremented to 3505                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  129606                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000064803 INJ
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


## MsgSubaccountTransfer

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/17_MsgSubaccountTransfer.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/17_MsgSubaccountTransfer.py -->
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
    dest_subaccount_id = address.get_subaccount_id(index=1)

    # prepare tx msg
    msg = composer.msg_subaccount_transfer(
        sender=address.to_acc_bech32(),
        source_subaccount_id=subaccount_id,
        destination_subaccount_id=dest_subaccount_id,
        amount=100,
        denom="inj",
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/14_MsgSubaccountTransfer/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/14_MsgSubaccountTransfer/example.go -->
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
	sdktypes "github.com/cosmos/cosmos-sdk/types"
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

	msg := exchangev2types.MsgSubaccountTransfer{
		Sender:                  senderAddress.String(),
		SourceSubaccountId:      "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
		DestinationSubaccountId: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000001",
		Amount: sdktypes.Coin{
			Denom: "inj", Amount: math.NewInt(1000000000000000000), // 1 INJ
		},
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgSubaccountTransfer.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">the sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">source_subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the source subaccount ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">destination_subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the destination subaccount ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">types.Coin</td><td class="description-td td_text">the amount to transfer (in chain format)</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/Coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">cosmossdk_io_math.Int</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "2E37F37501D025D09FADEB8A64DD47362292DE47D81514723BB061410409C956"
raw_log: "[]"

gas wanted: 97883
gas fee: 0.0000489415 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3506                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5214566  fn=func1 src="client/chain/chain.go:619" txHash=11181E2B0ACD1B0358CA19D52EF05D191B24F4E91B7548E94F3B7AC5841ABD8F
DEBU[0003] nonce incremented to 3507                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  122103                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000610515 INJ
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


## MsgExternalTransfer

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/exchange/18_MsgExternalTransfer.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/exchange/18_MsgExternalTransfer.py -->
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
    dest_subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"

    # prepare tx msg
    msg = composer.msg_external_transfer(
        sender=address.to_acc_bech32(),
        source_subaccount_id=subaccount_id,
        destination_subaccount_id=dest_subaccount_id,
        amount=100,
        denom="inj",
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/exchange/15_MsgExternalTransfer/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/exchange/15_MsgExternalTransfer/example.go -->
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
	sdktypes "github.com/cosmos/cosmos-sdk/types"
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

	msg := exchangev2types.MsgExternalTransfer{
		Sender:                  senderAddress.String(),
		SourceSubaccountId:      "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
		DestinationSubaccountId: "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
		Amount: sdktypes.Coin{
			Denom: "inj", Amount: math.NewInt(1000000000000000000), // 1 INJ
		},
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/exchange/v2/MsgExternalTransfer.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">the sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">source_subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the source subaccount ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">destination_subaccount_id</td><td class="type-td td_text">string</td><td class="description-td td_text">the destination subaccount ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">types.Coin</td><td class="description-td td_text">the amount to transfer (in chain format)</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/Coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">cosmossdk_io_math.Int</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "6790503C993094B50A7E0CBAD4B27E1ABFE24060509CB189DCC408A0AD99F894"
raw_log: "[]"

gas wanted: 99159
gas fee: 0.0000495795 INJ
```

```go
DEBU[0002] broadcastTx with nonce 3658                   fn=func1 src="client/chain/chain.go:607"
DEBU[0005] msg batch committed successfully at height 6556107  fn=func1 src="client/chain/chain.go:628" txHash=BD185F427DD1987969605695779C48FD4BEECC7AEC9C51ED5E0BF1747A471F4E
DEBU[0005] nonce incremented to 3659                     fn=func1 src="client/chain/chain.go:632"
DEBU[0005] gas wanted:  122397                           fn=func1 src="client/chain/chain.go:633"
gas fee: 0.0000611985 INJ
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


## MsgSendToEth

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/peggy/1_MsgSendToEth.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/peggy/1_MsgSendToEth.py -->
```py
import asyncio
import json
import os
from decimal import Decimal

import dotenv
import requests

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

    # prepare msg
    asset = "injective-protocol"
    coingecko_endpoint = f"https://api.coingecko.com/api/v3/simple/price?ids={asset}&vs_currencies=usd"
    token_price = requests.get(coingecko_endpoint).json()[asset]["usd"]
    minimum_bridge_fee_usd = 10
    bridge_fee = minimum_bridge_fee_usd / token_price
    token_decimals = 6
    chain_bridge_fee = int(Decimal(str(bridge_fee)) * Decimal(f"1e{token_decimals}"))

    # prepare tx msg
    msg = composer.msg_send_to_eth(
        sender=address.to_acc_bech32(),
        denom="inj",
        eth_dest="0xaf79152ac5df276d9a8e1e2e22822f9713474902",
        amount=23,
        bridge_fee=chain_bridge_fee,
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/peggy/1_MsgSendToEth/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/peggy/1_MsgSendToEth/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	"cosmossdk.io/math"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
	txtypes "github.com/cosmos/cosmos-sdk/types/tx"

	peggytypes "github.com/InjectiveLabs/sdk-go/chain/peggy/types"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
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

	ethDest := "0xaf79152ac5df276d9a8e1e2e22822f9713474902"

	amount := sdktypes.Coin{
		Denom: "inj", Amount: math.NewInt(5000000000000000000), // 5 INJ
	}
	bridgeFee := sdktypes.Coin{
		Denom: "inj", Amount: math.NewInt(2000000000000000000), // 2 INJ
	}

	msg := peggytypes.MsgSendToEth{
		Sender:    senderAddress.String(),
		Amount:    amount,
		EthDest:   ethDest,
		BridgeFee: bridgeFee,
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/peggy/MsgSendToEth.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">The sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">eth_dest</td><td class="type-td td_text">string</td><td class="description-td td_text">The Ethereum address to send the tokens to</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">types.Coin</td><td class="description-td td_text">The amount of tokens to send</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">bridge_fee</td><td class="type-td td_text">types.Coin</td><td class="description-td td_text">The fee paid for the bridge, distinct from the fee paid to the chain to actually send this message in the first place. So a successful send has two layers of fees for the user</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/Coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">cosmossdk_io_math.Int</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "5529016817553230024B45B44ABEB0538DC0AF9EEE0DEAD467B91C85BCCCAC87"
raw_log: "[]"

gas wanted: 125732
gas fee: 0.000062866 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3515                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5215066  fn=func1 src="client/chain/chain.go:619" txHash=391AB87558318BD7FF2CCB9D68ED309AD073FA64C8395A493D6C347FF572AF38
DEBU[0004] nonce incremented to 3516                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  161907                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000809535 INJ
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


## SendToInjective

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/SendToInjective.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/SendToInjective.py -->
```py
import asyncio
import json
import os

import dotenv

from pyinjective.core.network import Network
from pyinjective.sendtocosmos import Peggo


async def main() -> None:
    dotenv.load_dotenv()
    private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: testnet, mainnet
    network = Network.testnet()
    peggo_composer = Peggo(network=network.string())

    ethereum_endpoint = "https://eth-goerli.g.alchemy.com/v2/q-7JVv4mTfsNh1y_djKkKn3maRBGILLL"

    maxFeePerGas_Gwei = 4
    maxPriorityFeePerGas_Gwei = 4

    token_contract = "0xBe8d71D26525440A03311cc7fa372262c5354A3c"
    receiver = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    amount = 1

    data = (
        '{"@type": "/injective.exchange.v1beta1.MsgDeposit",'
        '"sender": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",'
        '"subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",'
        '"amount": {"denom": "inj","amount": "1000000000000000000"}}'
    )

    with open("../pyinjective/Peggo_ABI.json") as pego_file:
        peggo_data = pego_file.read()
    peggo_abi = json.loads(peggo_data)

    peggo_composer.sendToInjective(
        ethereum_endpoint=ethereum_endpoint,
        private_key=private_key,
        token_contract=token_contract,
        receiver=receiver,
        amount=amount,
        maxFeePerGas=maxFeePerGas_Gwei,
        maxPriorityFeePerGas=maxPriorityFeePerGas_Gwei,
        data=data,
        peggo_abi=peggo_abi,
    )


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/peggy/sendToInjective.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">ethereum_endpoint</td><td class="type-td td_text">String</td><td class="description-td td_text">The ethereum endpoint, you can get one from providers like Infura and Alchemy</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">private_key</td><td class="type-td td_text">String</td><td class="description-td td_text">Private key of the account to be used to sign the transaction</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">token_contract</td><td class="type-td td_text">String</td><td class="description-td td_text">The token contract, you can find the contract for the token you want to transfer on etherscan</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">receiver</td><td class="type-td td_text">String</td><td class="description-td td_text">The Injective Chain address to receive the funds</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">Float</td><td class="description-td td_text">The amount to transfer</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">maxFeePerGas</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The maxFeePerGas in Gwei</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">maxPriorityFeePerGas</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The maxPriorityFeePerGas in Gwei</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">peggo_abi</td><td class="type-td td_text">String</td><td class="description-td td_text">Peggo contract ABI|</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">String</td><td class="description-td td_text">The body of the message to send to Injective chain to do the deposit</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">decimals</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Number of decimals in Injective chain of the token being transferred (default: 18)</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
Transferred 1 0x36b3d7ace7201e28040eff30e815290d7b37ffad from 0xbdAEdEc95d563Fb05240d6e01821008454c24C36 to inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku

Transaction hash: 0xb538abc7c2f893a2fe24c7a8ea606ff48d980a754499f1bec89b862c2bcb9ea7
```


## GetTx

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/tx/query/1_GetTx.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/tx/query/1_GetTx.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.devnet()
    client = AsyncClient(network)
    tx_hash = "EA598BB5297341636DD62D378DEB87ECE6F95AFB4F45966AA6A53D36EF022DA5"
    tx_logs = await client.fetch_tx(hash=tx_hash)
    print(tx_logs)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/tx/query/1_GetTx/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/tx/query/1_GetTx/example.go -->
```go
package main

import (
	"context"
	"fmt"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/common"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("mainnet", "lb")
	tmRPC, err := rpchttp.New(network.TmEndpoint)

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

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmRPC)

	chainClient, err := chainclient.NewChainClientV2(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	timeOutCtx, cancelFn := context.WithTimeout(ctx, 30*time.Second)
	defer cancelFn()

	resp, err := chainClient.GetTx(timeOutCtx, "A2B2B971C690AE7977451D24D6F450AECE6BCCB271E91E32C2563342DDA5254B")
	if err != nil {
		panic(err)
	}

	fmt.Println(resp.TxResponse)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/GetTxRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">hash</td><td class="type-td td_text">string</td><td class="description-td td_text">hash is the tx hash to query, encoded as a hex string.</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


> Response Example:

``` python
{
   "tx":{
      "body":{
         "messages":[
            "OrderedDict("[
               "(""@type",
               "/cosmos.authz.v1beta1.MsgExec"")",
               "(""grantee",
               "inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"")",
               "(""msgs",
               [
                  "OrderedDict("[
                     "(""@type",
                     "/injective.exchange.v1beta1.MsgCreateSpotMarketOrder"")",
                     "(""sender",
                     "inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"")",
                     "(""order",
                     {
                        "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
                        "orderInfo":{
                           "subaccountId":"0x6561b5033700b734c54df4084240395889d23492000000000000000000000000",
                           "feeRecipient":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                           "price":"10194000",
                           "quantity":"175000000000000000000000000000000000",
                           "cid":""
                        },
                        "orderType":"SELL",
                        "triggerPrice":"0"
                     }")"
                  ]")"
               ]")"
            ]")"
         ],
         "timeoutHeight":"17518637",
         "memo":"",
         "extensionOptions":[
            
         ],
         "nonCriticalExtensionOptions":[
            
         ]
      },
      "authInfo":{
         "signerInfos":[
            {
               "publicKey":"OrderedDict("[
                  "(""@type",
                  "/injective.crypto.v1beta1.ethsecp256k1.PubKey"")",
                  "(""key",
                  "AmHqvENFf9E5s9vQFLQbcbHv4OIKTEWXVO4f7PZS9YOz"")"
               ]")",
               "modeInfo":{
                  "single":{
                     "mode":"SIGN_MODE_DIRECT"
                  }
               },
               "sequence":"211255"
            }
         ],
         "fee":{
            "amount":[
               {
                  "denom":"inj",
                  "amount":"52378500000000"
               }
            ],
            "gasLimit":"104757",
            "payer":"",
            "granter":""
         }
      },
      "signatures":[
         "Hn4Ugl50quZLQv/btmpWGMDr4F4RX5eeaGMIbc5VzC06a0sH3yRLvcNPyAcODcVjMQ1jbIRM01SYkvu2By+xJw=="
      ]
   },
   "txResponse":{
      "height":"17518608",
      "txhash":"D265527E3171C47D01D7EC9B839A95F8F794D4E683F26F5564025961C96EFDDA",
      "data":"126F0A252F636F736D6F732E617574687A2E763162657461312E4D736745786563526573706F6E736512460A440A42307834316630316536623266646433623463303631663834323235666165653033333536646238643137656265373631356661393232663132363861666434316136",
      "rawLog":"[{\"msg_index\":0,\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/cosmos.authz.v1beta1.MsgExec\"},{\"key\":\"sender\",\"value\":\"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7\"},{\"key\":\"module\",\"value\":\"authz\"}]},{\"type\":\"coin_spent\",\"attributes\":[{\"key\":\"spender\",\"value\":\"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7\"},{\"key\":\"amount\",\"value\":\"175000000000000000inj\"},{\"key\":\"authz_msg_index\",\"value\":\"0\"}]},{\"type\":\"coin_received\",\"attributes\":[{\"key\":\"receiver\",\"value\":\"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk\"},{\"key\":\"amount\",\"value\":\"175000000000000000inj\"},{\"key\":\"authz_msg_index\",\"value\":\"0\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk\"},{\"key\":\"sender\",\"value\":\"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7\"},{\"key\":\"amount\",\"value\":\"175000000000000000inj\"},{\"key\":\"authz_msg_index\",\"value\":\"0\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"sender\",\"value\":\"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7\"},{\"key\":\"authz_msg_index\",\"value\":\"0\"}]}]}]",
      "logs":[
         {
            "events":[
               {
                  "type":"message",
                  "attributes":[
                     {
                        "key":"action",
                        "value":"/cosmos.authz.v1beta1.MsgExec"
                     },
                     {
                        "key":"sender",
                        "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"
                     },
                     {
                        "key":"module",
                        "value":"authz"
                     }
                  ]
               },
               {
                  "type":"coin_spent",
                  "attributes":[
                     {
                        "key":"spender",
                        "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"
                     },
                     {
                        "key":"amount",
                        "value":"175000000000000000inj"
                     },
                     {
                        "key":"authz_msg_index",
                        "value":"0"
                     }
                  ]
               },
               {
                  "type":"coin_received",
                  "attributes":[
                     {
                        "key":"receiver",
                        "value":"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk"
                     },
                     {
                        "key":"amount",
                        "value":"175000000000000000inj"
                     },
                     {
                        "key":"authz_msg_index",
                        "value":"0"
                     }
                  ]
               },
               {
                  "type":"transfer",
                  "attributes":[
                     {
                        "key":"recipient",
                        "value":"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk"
                     },
                     {
                        "key":"sender",
                        "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"
                     },
                     {
                        "key":"amount",
                        "value":"175000000000000000inj"
                     },
                     {
                        "key":"authz_msg_index",
                        "value":"0"
                     }
                  ]
               },
               {
                  "type":"message",
                  "attributes":[
                     {
                        "key":"sender",
                        "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"
                     },
                     {
                        "key":"authz_msg_index",
                        "value":"0"
                     }
                  ]
               }
            ],
            "msgIndex":0,
            "log":""
         }
      ],
      "gasWanted":"104757",
      "gasUsed":"102564",
      "tx":"OrderedDict("[
         "(""@type",
         "/cosmos.tx.v1beta1.Tx"")",
         "(""body",
         {
            "messages":[
               "OrderedDict("[
                  "(""@type",
                  "/cosmos.authz.v1beta1.MsgExec"")",
                  "(""grantee",
                  "inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"")",
                  "(""msgs",
                  [
                     "OrderedDict("[
                        "(""@type",
                        "/injective.exchange.v1beta1.MsgCreateSpotMarketOrder"")",
                        "(""sender",
                        "inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"")",
                        "(""order",
                        {
                           "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
                           "orderInfo":{
                              "subaccountId":"0x6561b5033700b734c54df4084240395889d23492000000000000000000000000",
                              "feeRecipient":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                              "price":"10194000",
                              "quantity":"175000000000000000000000000000000000",
                              "cid":""
                           },
                           "orderType":"SELL",
                           "triggerPrice":"0"
                        }")"
                     ]")"
                  ]")"
               ]")"
            ],
            "timeoutHeight":"17518637",
            "memo":"",
            "extensionOptions":[
               
            ],
            "nonCriticalExtensionOptions":[
               
            ]
         }")",
         "(""authInfo",
         {
            "signerInfos":[
               {
                  "publicKey":"OrderedDict("[
                     "(""@type",
                     "/injective.crypto.v1beta1.ethsecp256k1.PubKey"")",
                     "(""key",
                     "AmHqvENFf9E5s9vQFLQbcbHv4OIKTEWXVO4f7PZS9YOz"")"
                  ]")",
                  "modeInfo":{
                     "single":{
                        "mode":"SIGN_MODE_DIRECT"
                     }
                  },
                  "sequence":"211255"
               }
            ],
            "fee":{
               "amount":[
                  {
                     "denom":"inj",
                     "amount":"52378500000000"
                  }
               ],
               "gasLimit":"104757",
               "payer":"",
               "granter":""
            }
         }")",
         "(""signatures",
         [
            "Hn4Ugl50quZLQv/btmpWGMDr4F4RX5eeaGMIbc5VzC06a0sH3yRLvcNPyAcODcVjMQ1jbIRM01SYkvu2By+xJw=="
         ]")"
      ]")",
      "timestamp":"2023-10-23T18:48:19Z",
      "events":[
         {
            "type":"coin_spent",
            "attributes":[
               {
                  "key":"spender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"52378500000000inj",
                  "index":true
               }
            ]
         },
         {
            "type":"coin_received",
            "attributes":[
               {
                  "key":"receiver",
                  "value":"inj17xpfvakm2amg962yls6f84z3kell8c5l6s5ye9",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"52378500000000inj",
                  "index":true
               }
            ]
         },
         {
            "type":"transfer",
            "attributes":[
               {
                  "key":"recipient",
                  "value":"inj17xpfvakm2amg962yls6f84z3kell8c5l6s5ye9",
                  "index":true
               },
               {
                  "key":"sender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"52378500000000inj",
                  "index":true
               }
            ]
         },
         {
            "type":"message",
            "attributes":[
               {
                  "key":"sender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               }
            ]
         },
         {
            "type":"tx",
            "attributes":[
               {
                  "key":"fee",
                  "value":"52378500000000inj",
                  "index":true
               },
               {
                  "key":"fee_payer",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               }
            ]
         },
         {
            "type":"tx",
            "attributes":[
               {
                  "key":"acc_seq",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7/211255",
                  "index":true
               }
            ]
         },
         {
            "type":"tx",
            "attributes":[
               {
                  "key":"signature",
                  "value":"Hn4Ugl50quZLQv/btmpWGMDr4F4RX5eeaGMIbc5VzC06a0sH3yRLvcNPyAcODcVjMQ1jbIRM01SYkvu2By+xJw==",
                  "index":true
               }
            ]
         },
         {
            "type":"message",
            "attributes":[
               {
                  "key":"action",
                  "value":"/cosmos.authz.v1beta1.MsgExec",
                  "index":true
               },
               {
                  "key":"sender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"module",
                  "value":"authz",
                  "index":true
               }
            ]
         },
         {
            "type":"coin_spent",
            "attributes":[
               {
                  "key":"spender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"175000000000000000inj",
                  "index":true
               },
               {
                  "key":"authz_msg_index",
                  "value":"0",
                  "index":true
               }
            ]
         },
         {
            "type":"coin_received",
            "attributes":[
               {
                  "key":"receiver",
                  "value":"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"175000000000000000inj",
                  "index":true
               },
               {
                  "key":"authz_msg_index",
                  "value":"0",
                  "index":true
               }
            ]
         },
         {
            "type":"transfer",
            "attributes":[
               {
                  "key":"recipient",
                  "value":"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk",
                  "index":true
               },
               {
                  "key":"sender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"175000000000000000inj",
                  "index":true
               },
               {
                  "key":"authz_msg_index",
                  "value":"0",
                  "index":true
               }
            ]
         },
         {
            "type":"message",
            "attributes":[
               {
                  "key":"sender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"authz_msg_index",
                  "value":"0",
                  "index":true
               }
            ]
         }
      ],
      "codespace":"",
      "code":0,
      "info":""
   }
}
```

``` go
code: 0
codespace: ""
data: 0AC1010A302F696E6A6563746976652E65786368616E67652E763162657461312E4D736742617463685570646174654F7264657273128C011202010122423078396638313937363932323364333439646462313738333335303831396437396235373736323363623361613163633462346534326361643638666264393462362242307834656239333035636565663365616264663762653734313338343931633966373738663439613131613164643733613930623761666366323731353263633935
events:
- attributes:
  - index: true
    key: YWNjX3NlcQ==
    value: aW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13LzEwODczMTIy
  type: tx
- attributes:
  - index: true
    key: c2lnbmF0dXJl
    value: eWtDcmVOVjdEaHF1Z1k5d2gvc25EWFF4VUtibC9ZK3h3Nmw5d3ZhU28zcExSYU9rVlR2b3VuaERmRy9ZYzl0SEplYVd6L1d2am1OekU2MmFJNHBrSHdFPQ==
  type: tx
- attributes:
  - index: true
    key: c3BlbmRlcg==
    value: aW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13
  - index: true
    key: YW1vdW50
    value: MzY5ODAxMDAwMDAwMDAwaW5q
  type: coin_spent
- attributes:
  - index: true
    key: cmVjZWl2ZXI=
    value: aW5qMTd4cGZ2YWttMmFtZzk2MnlsczZmODR6M2tlbGw4YzVsNnM1eWU5
  - index: true
    key: YW1vdW50
    value: MzY5ODAxMDAwMDAwMDAwaW5q
  type: coin_received
- attributes:
  - index: true
    key: cmVjaXBpZW50
    value: aW5qMTd4cGZ2YWttMmFtZzk2MnlsczZmODR6M2tlbGw4YzVsNnM1eWU5
  - index: true
    key: c2VuZGVy
    value: aW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13
  - index: true
    key: YW1vdW50
    value: MzY5ODAxMDAwMDAwMDAwaW5q
  type: transfer
- attributes:
  - index: true
    key: c2VuZGVy
    value: aW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13
  type: message
- attributes:
  - index: true
    key: ZmVl
    value: MzY5ODAxMDAwMDAwMDAwaW5q
  - index: true
    key: ZmVlX3BheWVy
    value: aW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13
  type: tx
- attributes:
  - index: true
    key: YWN0aW9u
    value: L2luamVjdGl2ZS5leGNoYW5nZS52MWJldGExLk1zZ0JhdGNoVXBkYXRlT3JkZXJz
  type: message
- attributes:
  - index: true
    key: aXNMaW1pdENhbmNlbA==
    value: dHJ1ZQ==
  - index: true
    key: bGltaXRfb3JkZXI=
    value: eyJvcmRlcl9pbmZvIjp7InN1YmFjY291bnRfaWQiOiIweGVjMmIyMWFmYTczZDA1MTE0ZTNlZWE4NTEzNThiODZiNTY3NjkwNWIwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDEiLCJmZWVfcmVjaXBpZW50IjoiaW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13IiwicHJpY2UiOiI3NzM1MDAwLjAwMDAwMDAwMDAwMDAwMDAwMCIsInF1YW50aXR5IjoiNjQ2LjU2OTAwMDAwMDAwMDAwMDAwMCJ9LCJvcmRlcl90eXBlIjoiU0VMTF9QTyIsIm1hcmdpbiI6IjAuMDAwMDAwMDAwMDAwMDAwMDAwIiwiZmlsbGFibGUiOiI2NDYuNTY5MDAwMDAwMDAwMDAwMDAwIiwidHJpZ2dlcl9wcmljZSI6bnVsbCwib3JkZXJfaGFzaCI6ImhTZUNBOEU1a0krdmEzZUdLMnhWUGJxSlZybzNSUzlPRkJCVHhxMXhtVDg9In0=
  - index: true
    key: bWFya2V0X2lk
    value: IjB4OWI5OTgwMTY3ZWNjMzY0NWZmMWE1NTE3ODg2NjUyZDk0YTA4MjVlNTRhNzdkMjA1N2NiYmUzZWJlZTAxNTk2MyI=
  - index: true
    key: bWFya2V0X29yZGVyX2NhbmNlbA==
    value: bnVsbA==
  type: injective.exchange.v1beta1.EventCancelDerivativeOrder
- attributes:
  - index: true
    key: aXNMaW1pdENhbmNlbA==
    value: dHJ1ZQ==
  - index: true
    key: bGltaXRfb3JkZXI=
    value: eyJvcmRlcl9pbmZvIjp7InN1YmFjY291bnRfaWQiOiIweGVjMmIyMWFmYTczZDA1MTE0ZTNlZWE4NTEzNThiODZiNTY3NjkwNWIwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDEiLCJmZWVfcmVjaXBpZW50IjoiaW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13IiwicHJpY2UiOiI3NjY0MDAwLjAwMDAwMDAwMDAwMDAwMDAwMCIsInF1YW50aXR5IjoiNjQ2LjU2OTAwMDAwMDAwMDAwMDAwMCJ9LCJvcmRlcl90eXBlIjoiQlVZX1BPIiwibWFyZ2luIjoiOTkxMDYwOTYzLjIwMDAwMDAwMDAwMDAwMDAwMCIsImZpbGxhYmxlIjoiNjQ2LjU2OTAwMDAwMDAwMDAwMDAwMCIsInRyaWdnZXJfcHJpY2UiOm51bGwsIm9yZGVyX2hhc2giOiJnYllhaEVIdFhLY0J3RkgvazU4ZmxQdVZlUWRzcGlabjA5NWZia3E0a0dNPSJ9
  - index: true
    key: bWFya2V0X2lk
    value: IjB4OWI5OTgwMTY3ZWNjMzY0NWZmMWE1NTE3ODg2NjUyZDk0YTA4MjVlNTRhNzdkMjA1N2NiYmUzZWJlZTAxNTk2MyI=
  - index: true
    key: bWFya2V0X29yZGVyX2NhbmNlbA==
    value: bnVsbA==
  type: injective.exchange.v1beta1.EventCancelDerivativeOrder
- attributes:
  - index: true
    key: YnV5X29yZGVycw==
    value: W10=
  - index: true
    key: bWFya2V0X2lk
    value: IjB4OWI5OTgwMTY3ZWNjMzY0NWZmMWE1NTE3ODg2NjUyZDk0YTA4MjVlNTRhNzdkMjA1N2NiYmUzZWJlZTAxNTk2MyI=
  - index: true
    key: c2VsbF9vcmRlcnM=
    value: W3sib3JkZXJfaW5mbyI6eyJzdWJhY2NvdW50X2lkIjoiMHhlYzJiMjFhZmE3M2QwNTExNGUzZWVhODUxMzU4Yjg2YjU2NzY5MDViMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxIiwiZmVlX3JlY2lwaWVudCI6ImluajFhczRqcnRhODg1ejN6bjM3YTJ6M3hrOWNkZHQ4ZHl6bWZ2d2VtdyIsInByaWNlIjoiNzczNzAwMC4wMDAwMDAwMDAwMDAwMDAwMDAiLCJxdWFudGl0eSI6IjY0Ni4zMzcwMDAwMDAwMDAwMDAwMDAifSwib3JkZXJfdHlwZSI6IlNFTExfUE8iLCJtYXJnaW4iOiIwLjAwMDAwMDAwMDAwMDAwMDAwMCIsImZpbGxhYmxlIjoiNjQ2LjMzNzAwMDAwMDAwMDAwMDAwMCIsInRyaWdnZXJfcHJpY2UiOm51bGwsIm9yZGVyX2hhc2giOiJuNEdYYVNJOU5KM2JGNE0xQ0JuWG0xZDJJOHM2b2N4TFRrTEsxbys5bExZPSJ9XQ==
  type: injective.exchange.v1beta1.EventNewDerivativeOrders
- attributes:
  - index: true
    key: YnV5X29yZGVycw==
    value: W3sib3JkZXJfaW5mbyI6eyJzdWJhY2NvdW50X2lkIjoiMHhlYzJiMjFhZmE3M2QwNTExNGUzZWVhODUxMzU4Yjg2YjU2NzY5MDViMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxIiwiZmVlX3JlY2lwaWVudCI6ImluajFhczRqcnRhODg1ejN6bjM3YTJ6M3hrOWNkZHQ4ZHl6bWZ2d2VtdyIsInByaWNlIjoiNzY2NjAwMC4wMDAwMDAwMDAwMDAwMDAwMDAiLCJxdWFudGl0eSI6IjY0Ni4zMzcwMDAwMDAwMDAwMDAwMDAifSwib3JkZXJfdHlwZSI6IkJVWV9QTyIsIm1hcmdpbiI6Ijk5MDk2Mzg4OC40MDAwMDAwMDAwMDAwMDAwMDAiLCJmaWxsYWJsZSI6IjY0Ni4zMzcwMDAwMDAwMDAwMDAwMDAiLCJ0cmlnZ2VyX3ByaWNlIjpudWxsLCJvcmRlcl9oYXNoIjoiVHJrd1hPN3o2cjMzdm5RVGhKSEo5M2owbWhHaDNYT3BDM3I4OG5GU3pKVT0ifV0=
  - index: true
    key: bWFya2V0X2lk
    value: IjB4OWI5OTgwMTY3ZWNjMzY0NWZmMWE1NTE3ODg2NjUyZDk0YTA4MjVlNTRhNzdkMjA1N2NiYmUzZWJlZTAxNTk2MyI=
  - index: true
    key: c2VsbF9vcmRlcnM=
    value: W10=
  type: injective.exchange.v1beta1.EventNewDerivativeOrders
gas_used: "261983"
gas_wanted: "369801"
height: "32442284"
info: ""
logs:
- events:
  - attributes:
    - key: isLimitCancel
      value: "true"
    - key: limit_order
      value: '{"order_info":{"subaccount_id":"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001","fee_recipient":"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw","price":"7735000.000000000000000000","quantity":"646.569000000000000000"},"order_type":"SELL_PO","margin":"0.000000000000000000","fillable":"646.569000000000000000","trigger_price":null,"order_hash":"hSeCA8E5kI+va3eGK2xVPbqJVro3RS9OFBBTxq1xmT8="}'
    - key: market_id
      value: '"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963"'
    - key: market_order_cancel
      value: "null"
    - key: isLimitCancel
      value: "true"
    - key: limit_order
      value: '{"order_info":{"subaccount_id":"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001","fee_recipient":"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw","price":"7664000.000000000000000000","quantity":"646.569000000000000000"},"order_type":"BUY_PO","margin":"991060963.200000000000000000","fillable":"646.569000000000000000","trigger_price":null,"order_hash":"gbYahEHtXKcBwFH/k58flPuVeQdspiZn095fbkq4kGM="}'
    - key: market_id
      value: '"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963"'
    - key: market_order_cancel
      value: "null"
    type: injective.exchange.v1beta1.EventCancelDerivativeOrder
  - attributes:
    - key: buy_orders
      value: '[]'
    - key: market_id
      value: '"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963"'
    - key: sell_orders
      value: '[{"order_info":{"subaccount_id":"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001","fee_recipient":"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw","price":"7737000.000000000000000000","quantity":"646.337000000000000000"},"order_type":"SELL_PO","margin":"0.000000000000000000","fillable":"646.337000000000000000","trigger_price":null,"order_hash":"n4GXaSI9NJ3bF4M1CBnXm1d2I8s6ocxLTkLK1o+9lLY="}]'
    - key: buy_orders
      value: '[{"order_info":{"subaccount_id":"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001","fee_recipient":"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw","price":"7666000.000000000000000000","quantity":"646.337000000000000000"},"order_type":"BUY_PO","margin":"990963888.400000000000000000","fillable":"646.337000000000000000","trigger_price":null,"order_hash":"TrkwXO7z6r33vnQThJHJ93j0mhGh3XOpC3r88nFSzJU="}]'
    - key: market_id
      value: '"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963"'
    - key: sell_orders
      value: '[]'
    type: injective.exchange.v1beta1.EventNewDerivativeOrders
  - attributes:
    - key: action
      value: /injective.exchange.v1beta1.MsgBatchUpdateOrders
    type: message
  log: ""
  msg_index: 0
raw_log: '[{"events":[{"type":"injective.exchange.v1beta1.EventCancelDerivativeOrder","attributes":[{"key":"isLimitCancel","value":"true"},{"key":"limit_order","value":"{\"order_info\":{\"subaccount_id\":\"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001\",\"fee_recipient\":\"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw\",\"price\":\"7735000.000000000000000000\",\"quantity\":\"646.569000000000000000\"},\"order_type\":\"SELL_PO\",\"margin\":\"0.000000000000000000\",\"fillable\":\"646.569000000000000000\",\"trigger_price\":null,\"order_hash\":\"hSeCA8E5kI+va3eGK2xVPbqJVro3RS9OFBBTxq1xmT8=\"}"},{"key":"market_id","value":"\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\""},{"key":"market_order_cancel","value":"null"},{"key":"isLimitCancel","value":"true"},{"key":"limit_order","value":"{\"order_info\":{\"subaccount_id\":\"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001\",\"fee_recipient\":\"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw\",\"price\":\"7664000.000000000000000000\",\"quantity\":\"646.569000000000000000\"},\"order_type\":\"BUY_PO\",\"margin\":\"991060963.200000000000000000\",\"fillable\":\"646.569000000000000000\",\"trigger_price\":null,\"order_hash\":\"gbYahEHtXKcBwFH/k58flPuVeQdspiZn095fbkq4kGM=\"}"},{"key":"market_id","value":"\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\""},{"key":"market_order_cancel","value":"null"}]},{"type":"injective.exchange.v1beta1.EventNewDerivativeOrders","attributes":[{"key":"buy_orders","value":"[]"},{"key":"market_id","value":"\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\""},{"key":"sell_orders","value":"[{\"order_info\":{\"subaccount_id\":\"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001\",\"fee_recipient\":\"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw\",\"price\":\"7737000.000000000000000000\",\"quantity\":\"646.337000000000000000\"},\"order_type\":\"SELL_PO\",\"margin\":\"0.000000000000000000\",\"fillable\":\"646.337000000000000000\",\"trigger_price\":null,\"order_hash\":\"n4GXaSI9NJ3bF4M1CBnXm1d2I8s6ocxLTkLK1o+9lLY=\"}]"},{"key":"buy_orders","value":"[{\"order_info\":{\"subaccount_id\":\"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001\",\"fee_recipient\":\"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw\",\"price\":\"7666000.000000000000000000\",\"quantity\":\"646.337000000000000000\"},\"order_type\":\"BUY_PO\",\"margin\":\"990963888.400000000000000000\",\"fillable\":\"646.337000000000000000\",\"trigger_price\":null,\"order_hash\":\"TrkwXO7z6r33vnQThJHJ93j0mhGh3XOpC3r88nFSzJU=\"}]"},{"key":"market_id","value":"\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\""},{"key":"sell_orders","value":"[]"}]},{"type":"message","attributes":[{"key":"action","value":"/injective.exchange.v1beta1.MsgBatchUpdateOrders"}]}]}]'
timestamp: "2023-05-02T03:04:55Z"
tx:
  '@type': /cosmos.tx.v1beta1.Tx
  auth_info:
    fee:
      amount:
      - amount: "369801000000000"
        denom: inj
      gas_limit: "369801"
      granter: ""
      payer: ""
    signer_infos:
    - mode_info:
        single:
          mode: SIGN_MODE_DIRECT
      public_key:
        '@type': /injective.crypto.v1beta1.ethsecp256k1.PubKey
        key: An8DQ7/twFqvUuJxd5rCIkl04BfQocYS2T/A2pnYbFOJ
      sequence: "10873122"
  body:
    extension_options: []
    memo: ""
    messages:
    - '@type': /injective.exchange.v1beta1.MsgBatchUpdateOrders
      binary_options_market_ids_to_cancel_all: []
      binary_options_orders_to_cancel: []
      binary_options_orders_to_create: []
      derivative_market_ids_to_cancel_all: []
      derivative_orders_to_cancel:
      - market_id: 0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963
        order_hash: 0x85278203c139908faf6b77862b6c553dba8956ba37452f4e141053c6ad71993f
        order_mask: 0
        subaccount_id: 0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001
      - market_id: 0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963
        order_hash: 0x81b61a8441ed5ca701c051ff939f1f94fb9579076ca62667d3de5f6e4ab89063
        order_mask: 0
        subaccount_id: 0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001
      derivative_orders_to_create:
      - margin: "0.000000000000000000"
        market_id: 0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963
        order_info:
          fee_recipient: inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw
          price: "7737000.000000000000000000"
          quantity: "646.337000000000000000"
          subaccount_id: 0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001
        order_type: SELL_PO
        trigger_price: null
      - margin: "990963888.400000000000000000"
        market_id: 0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963
        order_info:
          fee_recipient: inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw
          price: "7666000.000000000000000000"
          quantity: "646.337000000000000000"
          subaccount_id: 0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001
        order_type: BUY_PO
        trigger_price: null
      sender: inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw
      spot_market_ids_to_cancel_all: []
      spot_orders_to_cancel: []
      spot_orders_to_create: []
      subaccount_id: ""
    non_critical_extension_options: []
    timeout_height: "0"
  signatures:
  - ykCreNV7DhqugY9wh/snDXQxUKbl/Y+xw6l9wvaSo3pLRaOkVTvounhDfG/Yc9tHJeaWz/WvjmNzE62aI4pkHwE=
txhash: A2B2B971C690AE7977451D24D6F450AECE6BCCB271E91E32C2563342DDA5254B
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/GetTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">Tx</td><td class="description-td td_text">tx is the queried transaction.</td></tr>
<tr ><td class="parameter-td td_text">tx_response</td><td class="type-td td_text">types.TxResponse</td><td class="description-td td_text">tx_response is the queried TxResponses.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Tx**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/Tx.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">body</td><td class="type-td td_text">TxBody</td><td class="description-td td_text">body is the processable content of the transaction</td></tr>
<tr ><td class="parameter-td td_text">auth_info</td><td class="type-td td_text">AuthInfo</td><td class="description-td td_text">auth_info is the authorization related content of the transaction, specifically signers, signer modes and fee</td></tr>
<tr ><td class="parameter-td td_text">signatures</td><td class="type-td td_text">][byte array</td><td class="description-td td_text">signatures is a list of signatures that matches the length and order of AuthInfo's signer_infos to allow connecting signature meta information like public key and signing mode by position.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxBody**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/TxBody.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">messages</td><td class="type-td td_text">types.Any array</td><td class="description-td td_text">messages is a list of messages to be executed. The required signers of those messages define the number and order of elements in AuthInfo's signer_infos and Tx's signatures. Each required signer address is added to the list only the first time it occurs. By convention, the first required signer (usually from the first message) is referred to as the primary signer and pays the fee for the whole transaction.</td></tr>
<tr ><td class="parameter-td td_text">memo</td><td class="type-td td_text">string</td><td class="description-td td_text">memo is any arbitrary note/comment to be added to the transaction. WARNING: in clients, any publicly exposed text should not be called memo, but should be called `note` instead (see https://github.com/cosmos/cosmos-sdk/issues/9122).</td></tr>
<tr ><td class="parameter-td td_text">timeout_height</td><td class="type-td td_text">uint64</td><td class="description-td td_text">timeout is the block height after which this transaction will not be processed by the chain</td></tr>
<tr ><td class="parameter-td td_text">extension_options</td><td class="type-td td_text">types.Any array</td><td class="description-td td_text">extension_options are arbitrary options that can be added by chains when the default options are not sufficient. If any of these are present and can't be handled, the transaction will be rejected</td></tr>
<tr ><td class="parameter-td td_text">non_critical_extension_options</td><td class="type-td td_text">types.Any array</td><td class="description-td td_text">extension_options are arbitrary options that can be added by chains when the default options are not sufficient. If any of these are present and can't be handled, they will be ignored</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AuthInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/AuthInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">signer_infos</td><td class="type-td td_text">SignerInfo array</td><td class="description-td td_text">signer_infos defines the signing modes for the required signers. The number and order of elements must match the required signers from TxBody's messages. The first element is the primary signer and the one which pays the fee.</td></tr>
<tr ><td class="parameter-td td_text">fee</td><td class="type-td td_text">Fee</td><td class="description-td td_text">Fee is the fee and gas limit for the transaction. The first signer is the primary signer and the one which pays the fee. The fee can be calculated based on the cost of evaluating the body and doing signature verification of the signers. This can be estimated via simulation.</td></tr>
<tr ><td class="parameter-td td_text">tip</td><td class="type-td td_text">Tip</td><td class="description-td td_text">Tip is the optional tip used for transactions fees paid in another denom.  This field is ignored if the chain didn't enable tips, i.e. didn't add the `TipDecorator` in its posthandler.  Since: cosmos-sdk 0.46</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SignerInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/SignerInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">public_key</td><td class="type-td td_text">types.Any</td><td class="description-td td_text">public_key is the public key of the signer. It is optional for accounts that already exist in state. If unset, the verifier can use the required \ signer address for this position and lookup the public key.</td></tr>
<tr ><td class="parameter-td td_text">mode_info</td><td class="type-td td_text">ModeInfo</td><td class="description-td td_text">mode_info describes the signing mode of the signer and is a nested structure to support nested multisig pubkey's</td></tr>
<tr ><td class="parameter-td td_text">sequence</td><td class="type-td td_text">uint64</td><td class="description-td td_text">sequence is the sequence of the account, which describes the number of committed transactions signed by a given address. It is used to prevent replay attacks.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ModeInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/ModeInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">single</td><td class="type-td td_text">ModeInfo_Single</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">multi</td><td class="type-td td_text">ModeInfo_Multi</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">mode</td><td class="type-td td_text">signing.SignMode</td><td class="description-td td_text">mode is the signing mode of the single signer</td></tr>
<tr ><td class="parameter-td td_text">bitarray</td><td class="type-td td_text">types1.CompactBitArray</td><td class="description-td td_text">bitarray specifies which keys within the multisig are signing</td></tr>
<tr ><td class="parameter-td td_text">mode_infos</td><td class="type-td td_text">ModeInfo array</td><td class="description-td td_text">mode_infos is the corresponding modes of the signers of the multisig which could include nested multisig public keys</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Fee**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/Fee.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">github_com_cosmos_cosmos_sdk_types.Coins</td><td class="description-td td_text">amount is the amount of coins to be paid as a fee</td></tr>
<tr ><td class="parameter-td td_text">gas_limit</td><td class="type-td td_text">uint64</td><td class="description-td td_text">gas_limit is the maximum gas that can be used in transaction processing before an out of gas error occurs</td></tr>
<tr ><td class="parameter-td td_text">payer</td><td class="type-td td_text">string</td><td class="description-td td_text">if unset, the first signer is responsible for paying the fees. If set, the specified account must pay the fees. the payer must be a tx signer (and thus have signed this field in AuthInfo). setting this field does *not* change the ordering of required signers for the transaction.</td></tr>
<tr ><td class="parameter-td td_text">granter</td><td class="type-td td_text">string</td><td class="description-td td_text">if set, the fee payer (either the first signer or the value of the payer field) requests that a fee grant be used to pay fees instead of the fee payer's own balance. If an appropriate fee grant does not exist or the chain does not support fee grants, this will fail</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/Coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">cosmossdk_io_math.Int</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Tip**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/tx/Tip.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">github_com_cosmos_cosmos_sdk_types.Coins</td><td class="description-td td_text">amount is the amount of the tip</td></tr>
<tr ><td class="parameter-td td_text">tipper</td><td class="type-td td_text">string</td><td class="description-td td_text">tipper is the address of the account paying for the tip</td></tr></tbody></table>
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


## StreamEventOrderFail

**IP rate limit group:** `chain`

> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/2_StreamEventOrderFail.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/2_StreamEventOrderFail.py -->
```py
import asyncio
import base64
import json

import websockets

from pyinjective.core.network import Network


async def main() -> None:
    network = Network.mainnet()
    event_filter = (
        "tm.event='Tx' AND message.sender='inj1rwv4zn3jptsqs7l8lpa3uvzhs57y8duemete9e' "
        "AND message.action='/injective.exchange.v2.MsgBatchUpdateOrders' "
        "AND injective.exchange.v2.EventOrderFail.flags EXISTS"
    )
    query = json.dumps(
        {
            "jsonrpc": "2.0",
            "method": "subscribe",
            "id": "0",
            "params": {"query": event_filter},
        }
    )

    async with websockets.connect(network.tm_websocket_endpoint) as ws:
        await ws.send(query)
        while True:
            res = await ws.recv()
            res = json.loads(res)
            result = res["result"]
            if result == {}:
                continue

            failed_order_hashes = json.loads(result["events"]["injective.exchange.v2.EventOrderFail.hashes"][0])
            failed_order_codes = json.loads(result["events"]["injective.exchange.v2.EventOrderFail.flags"][0])

            dict = {}
            for i, order_hash in enumerate(failed_order_hashes):
                hash = "0x" + base64.b64decode(order_hash).hex()
                dict[hash] = failed_order_codes[i]

            print(dict)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/9_StreamEventOrderFail/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/9_StreamEventOrderFail/example.go -->
```go
package main

import (
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
)

func main() {
	network := common.LoadNetwork("mainnet", "lb")

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		"",
		nil,
	)
	if err != nil {
		panic(err)
	}

	chainClient, err := chainclient.NewChainClientV2(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	failEventCh := make(chan map[string]uint, 10000)
	go chainClient.StreamEventOrderFail("inj1rwv4zn3jptsqs7l8lpa3uvzhs57y8duemete9e", failEventCh)
	for {
		e := <-failEventCh
		fmt.Println(e)
	}
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
{'0x7d6d0d2118488dcaccd57193372e536881f34132241f01c1721ed6aedffec419': 36}
```

``` go
map[0x9db0f6e90d63b151ab0d64f0c6d83f747969f353d8c39a68cca65d046907e92a:59 0xdf7e05e66ab7a47e7a8a1751d4b9360fd80058cd5186162cee6fe124c57ece82:36]
```
