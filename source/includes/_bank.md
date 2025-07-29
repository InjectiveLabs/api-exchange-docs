# - Bank

Bank module.

## MsgSend

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/1_MsgSend.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/1_MsgSend.py -->
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

    # prepare tx msg
    msg = composer.msg_send(
        from_address=address.to_acc_bech32(),
        to_address="inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        amount=100000000000000000,
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/1_MsgSend/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/1_MsgSend/example.go -->
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
	banktypes "github.com/cosmos/cosmos-sdk/x/bank/types"

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
	msg := banktypes.MsgSend{
		FromAddress: senderAddress.String(),
		ToAddress:   "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
		Amount: []sdktypes.Coin{{
			Denom: "inj", Amount: math.NewInt(1000000000000000000)}, // 1 INJ
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

|Parameter|Type|Description|Required|
|----|----|----|----|
|from_address|String|The Injective Chain address of the sender|Yes|
|to_address|String| The Injective Chain address of the receiver|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|


### Response Parameters
> Response Example:

``` python
txhash: "52F3AF222FB064E7505FB14D79D703120EBDF8C945B7920F02FE2BB6666F1D50"
raw_log: "[]"

gas wanted: 97455
gas fee: 0.0000487275 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3490                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5212593  fn=func1 src="client/chain/chain.go:619" txHash=AD30AE73838AA342072DCC61897AA75548D613D032A3EC9BDD0A5A064C456002
DEBU[0004] nonce incremented to 3491                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  119871                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000599355 INJ
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


## MsgMultiSend

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/2_MsgMultiSend/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/2_MsgMultiSend/example.go -->
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
	banktypes "github.com/cosmos/cosmos-sdk/x/bank/types"

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

	msg := banktypes.MsgMultiSend{
		Inputs: []banktypes.Input{
			{
				Address: senderAddress.String(),
				Coins: []sdktypes.Coin{{
					Denom: "inj", Amount: math.NewInt(1000000000000000000)}, // 1 INJ
				},
			},
			{
				Address: senderAddress.String(),
				Coins: []sdktypes.Coin{{
					Denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5", Amount: math.NewInt(1000000)}, // 1 USDT
				},
			},
		},
		Outputs: []banktypes.Output{
			{
				Address: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
				Coins: []sdktypes.Coin{{
					Denom: "inj", Amount: math.NewInt(1000000000000000000)}, // 1 INJ
				},
			},
			{
				Address: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
				Coins: []sdktypes.Coin{{
					Denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5", Amount: math.NewInt(1000000)}, // 1 USDT
				},
			},
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

|Parameter|Type|Description|Required|
|----|----|----|----|
|Inputs|Input|Inputs|Yes|
|Outputs|Output|Outputs|Yes|

***Input***

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address of the sender|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|

***Output***

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address of the receiver|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|



> Response Example:

``` python

```


```go
DEBU[0001] broadcastTx with nonce 30                     fn=func1 src="client/chain/chain.go:630"
DEBU[0003] msg batch committed successfully at height 1620903  fn=func1 src="client/chain/chain.go:651" txHash=643F2C0F7FC679609AFE87FC4F3B0F2E81769F75628375BD6F3D27D4C286B240
DEBU[0003] nonce incremented to 31                       fn=func1 src="client/chain/chain.go:655"
DEBU[0003] gas wanted:  152844                           fn=func1 src="client/chain/chain.go:656"
gas fee: 0.000076422 INJ
```

## QueryAllBalances

Get the bank balance for all denoms.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/query/2_BankBalances.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/query/2_BankBalances.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    address = "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
    all_bank_balances = await client.fetch_bank_balances(address=address)
    print(json.dumps(all_bank_balances, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/query/2_BankBalances/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/query/2_BankBalances/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	address := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
	ctx := context.Background()

	res, err := chainClient.GetBankBalances(ctx, address)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address|Yes|


### Response Parameters
> Response Example:

``` python
{
   "balances":[
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
         "denom":"factory/inj1aetmaq5pswvfg6nhvgd4lt94qmg23ka3ljgxlm/SHURIKEN",
         "amount":"115700000"
      },
      {
         "denom":"factory/inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r/test",
         "amount":"1000000"
      },
      {
         "denom":"inj",
         "amount":"760662316753211286487"
      },
      {
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "amount":"9996297948"
      }
   ],
   "pagination":{
      "total":"7",
      "nextKey":""
   }
}
```

``` go
{
 "balances": [
  {
   "denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
   "amount": "829149863837"
  },
  {
   "denom": "inj",
   "amount": "51142210518226357537"
  },
  {
   "denom": "peggy0x36B3D7ACe7201E28040eFf30e815290D7b37ffaD",
   "amount": "4000000000000000000"
  },
  {
   "denom": "share26",
   "amount": "1000000000000000000"
  }
 ],
 "pagination": {
  "total": 4
 }
}
```

|Parameter|Type|Description|
|----|----|----|
|balances|Balances|Balances object|
|pagination|Pagination|Pagination object|

**Balances**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Token denom|
|amount|String|Token amount|

**Pagination**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total denoms|


## QueryBalance

Get the bank balance for a specific denom.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/query/1_BankBalance.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/query/1_BankBalance.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    address = "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
    denom = "inj"
    bank_balance = await client.fetch_bank_balance(address=address, denom=denom)
    print(json.dumps(bank_balance, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/query/1_BankBalance/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/query/1_BankBalance/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	address := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
	denom := "inj"
	ctx := context.Background()

	res, err := chainClient.GetBankBalance(ctx, address, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address|Yes|
|denom|String|The token denom|Yes|


### Response Parameters
> Response Example:

``` python
{
   "balance":{
      "denom":"inj",
      "amount":"760662316753211286487"
   }
}
```

``` go
{
 "balance": {
  "denom": "inj",
  "amount": "51142210518226357537"
 }
}
```

|Parameter|Type|Description|
|----|----|----|
|balance|Balance|Balance object|

**Balance**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Token denom|
|amount|String|Token amount|


## SpendableBalances

Get the bank spendable balances for a specific address.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/query/3_SpendableBalances.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/query/3_SpendableBalances.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    address = "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
    spendable_balances = await client.fetch_spendable_balances(address=address)
    print(json.dumps(spendable_balances, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/query/3_BankSpendableBalances/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/query/3_BankSpendableBalances/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/cosmos/cosmos-sdk/types/query"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	address := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
	pagination := query.PageRequest{Limit: 10}
	ctx := context.Background()

	res, err := chainClient.GetBankSpendableBalances(ctx, address, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type   | Description                             | Required |
| ---------- | ------ | --------------------------------------- | -------- |
| address    | String | Address to query spendable balances for | Yes      |
| pagination | Paging | Pagination of results                   | No       |


### Response Parameters
> Response Example:

``` python
{
   "balances":[
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
         "denom":"factory/inj1aetmaq5pswvfg6nhvgd4lt94qmg23ka3ljgxlm/SHURIKEN",
         "amount":"109950000"
      },
      {
         "denom":"factory/inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r/AAA",
         "amount":"3000000000"
      },
      {
         "denom":"factory/inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r/ANK",
         "amount":"999989999000010"
      },
      {
         "denom":"factory/inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r/APE",
         "amount":"999999899000038"
      },
      {
         "denom":"factory/inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r/aaaa",
         "amount":"900000928000028"
      },
      {
         "denom":"factory/inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r/test",
         "amount":"1000000"
      },
      {
         "denom":"inj",
         "amount":"682717353413490977815"
      },
      {
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "amount":"9996297948"
      }
   ],
   "pagination":{
      "total":"11",
      "nextKey":""
   }
}
```

``` go
{
 "balances": [
  {
   "denom": "factory/inj17d34nrgnq5sj24qd6rk4jrnak628wfqxjx9uhz/lpinj1zd8zg8xeerlsrsfzxhpe3xgncrp0txetqye9cl",
   "amount": "2000000000000000000"
  },
  {
   "denom": "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/mitotest1",
   "amount": "249999999999999999998"
  },
  {
   "denom": "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/projx",
   "amount": "27877970000000000000"
  },
  {
   "denom": "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/stinj",
   "amount": "103927830000000000000"
  },
  {
   "denom": "factory/inj17q7ds0yh7hhtusff7gz8a5kx2uwxruttlxur96/lpinj1vd0mf8a39xwr9hav2g7e8lmur07utjrjv025kd",
   "amount": "29670048440098478542"
  },
  {
   "denom": "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/aave",
   "amount": "110000000000"
  },
  {
   "denom": "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/atom",
   "amount": "20672215991"
  },
  {
   "denom": "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/crv",
   "amount": "110000000000"
  },
  {
   "denom": "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/cvx",
   "amount": "110000000000"
  },
  {
   "denom": "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/shib",
   "amount": "110000000000"
  }
 ],
 "pagination": {
  "next_key": "ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdGlh"
 }
}

```

| Parameter  | Type         | Description           |
| ---------- | ------------ | --------------------- |
| balances   | Coin Array   | Balance object        |
| pagination | PageResponse | Pagination of results |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |


## SpendableBalancesByDenom

Get the bank spendable balances for a specific address and denom.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/query/4_SpendableBalancesByDenom.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/query/4_SpendableBalancesByDenom.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    address = "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
    denom = "inj"
    spendable_balances = await client.fetch_spendable_balances_by_denom(address=address, denom=denom)
    print(json.dumps(spendable_balances, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/query/4_BankSpendableBalancesByDenom/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/query/4_BankSpendableBalancesByDenom/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	address := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
	denom := "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
	ctx := context.Background()

	res, err := chainClient.GetBankSpendableBalancesByDenom(ctx, address, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type   | Description                             | Required |
| --------- | ------ | --------------------------------------- | -------- |
| address   | String | Address to query spendable balances for | Yes      |
| denom     | String | The token denom                         | Yes      |


### Response Parameters
> Response Example:

``` python
{
   "balance":{
      "denom":"inj",
      "amount":"682717353413490977815"
   }
}
```

``` go
{
 "balance": {
  "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
  "amount": "172767664766"
 }
}

```

| Parameter | Type | Description    |
| --------- | ---- | -------------- |
| balance   | Coin | Balance object |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |


## TotalSupply

Get the total supply for all tokens

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/query/5_TotalSupply.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/query/5_TotalSupply.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    total_supply = await client.fetch_total_supply(
        pagination=PaginationOption(limit=10),
    )
    print(json.dumps(total_supply, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/query/5_BankTotalSupply/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/query/5_BankTotalSupply/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/cosmos/cosmos-sdk/types/query"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	pagination := query.PageRequest{Limit: 10}
	ctx := context.Background()

	res, err := chainClient.GetBankTotalSupply(ctx, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type   | Description           | Required |
| ---------- | ------ | --------------------- | -------- |
| pagination | Paging | Pagination of results | No       |


### Response Parameters
> Response Example:

``` python
{
   "supply":[
      {
         "denom":"factory/inj104y00apw6uu26gthl7cafztdy67hhmwksekdem/position",
         "amount":"64120252107"
      },
      {
         "denom":"factory/inj106rseec0xmv5k06aaf8jsnr57ajw76rxa3gpwm/position",
         "amount":"192927104"
      },
      {
         "denom":"factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position",
         "amount":"1921200000000000000000"
      },
      {
         "denom":"factory/inj107skcseta3egagj822d3qdgusx7a7ua7sepmcf/position",
         "amount":"52973849072"
      },
      {
         "denom":"factory/inj107srzqksjtdevlpw888vuyrnqmlpjuv64ytm85/position",
         "amount":"777131899999"
      },
      {
         "denom":"factory/inj108t3mlej0dph8er6ca2lq5cs9pdgzva5mqsn5p/position",
         "amount":"5556700000000000000"
      },
      {
         "denom":"factory/inj109rcepnmg7ewjcc4my3448jm3h0yjdwcl6kmnl/position",
         "amount":"642300000000"
      },
      {
         "denom":"factory/inj10ajd3f46mp755wmhgke8w4vcegfjndwfzymf82/position",
         "amount":"725247250499"
      },
      {
         "denom":"factory/inj10fz2cj00ee80y76pdzg06dxfamat8nfpr9vl5s/position",
         "amount":"4067730000000000000000"
      },
      {
         "denom":"factory/inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27/position",
         "amount":"761148481800"
      }
   ],
   "pagination":{
      "nextKey":"ZmFjdG9yeS9pbmoxMG52MjB4ZTR4MzI1c3E1NTdkZGNtc3lsYTd6YWo2cG5zc3JmdzkvcG9zaXRpb24=",
      "total":"0"
   }
}
```

``` go
{
 "supply": [
  {
   "denom": "factory/inj104y00apw6uu26gthl7cafztdy67hhmwksekdem/position",
   "amount": "64120252107"
  },
  {
   "denom": "factory/inj106rseec0xmv5k06aaf8jsnr57ajw76rxa3gpwm/position",
   "amount": "192927104"
  },
  {
   "denom": "factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position",
   "amount": "1921200000000000000000"
  },
  {
   "denom": "factory/inj107skcseta3egagj822d3qdgusx7a7ua7sepmcf/position",
   "amount": "52973849072"
  },
  {
   "denom": "factory/inj107srzqksjtdevlpw888vuyrnqmlpjuv64ytm85/position",
   "amount": "777131899999"
  },
  {
   "denom": "factory/inj108t3mlej0dph8er6ca2lq5cs9pdgzva5mqsn5p/position",
   "amount": "5556700000000000000"
  },
  {
   "denom": "factory/inj109rcepnmg7ewjcc4my3448jm3h0yjdwcl6kmnl/position",
   "amount": "642300000000"
  },
  {
   "denom": "factory/inj10ajd3f46mp755wmhgke8w4vcegfjndwfzymf82/position",
   "amount": "725247250499"
  },
  {
   "denom": "factory/inj10fz2cj00ee80y76pdzg06dxfamat8nfpr9vl5s/position",
   "amount": "4067730000000000000000"
  },
  {
   "denom": "factory/inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27/position",
   "amount": "761148481800"
  }
 ],
 "pagination": {
  "next_key": "ZmFjdG9yeS9pbmoxMG52MjB4ZTR4MzI1c3E1NTdkZGNtc3lsYTd6YWo2cG5zc3JmdzkvcG9zaXRpb24="
 }
}

```

| Parameter  | Type         | Description                    |
| ---------- | ------------ | ------------------------------ |
| supply     | Coin Array   | Array of supply for each token |
| pagination | PageResponse | Pagination of results          |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |


## SupplyOf

Queries the supply of a single token

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/query/6_SupplyOf.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/query/6_SupplyOf.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    supply_of = await client.fetch_supply_of(denom="inj")
    print(json.dumps(supply_of, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/query/6_BankSupplyOf/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/query/6_BankSupplyOf/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	denom := "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
	ctx := context.Background()

	res, err := chainClient.GetBankSupplyOf(ctx, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type   | Description | Required |
| --------- | ------ | ----------- | -------- |
| denom     | String | Token denom | Yes      |


### Response Parameters
> Response Example:

``` python
{'amount': {'denom': 'inj', 'amount': '926435158902805147647209906101604'}}
```

``` go
{
 "amount": {
  "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
  "amount": "999999965050607001998"
 }
}

```

| Parameter  | Type         | Description           |
| ---------- | ------------ | --------------------- |
| amount     | Coin         | Supply for the token  |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |


## DenomMetadata

Queries the metadata of a single token

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/query/7_DenomMetadata.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/query/7_DenomMetadata.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    denom = "factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position"
    metadata = await client.fetch_denom_metadata(denom=denom)
    print(json.dumps(metadata, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/query/7_DenomMetadata/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/query/7_DenomMetadata/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	denom := "factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position"
	ctx := context.Background()

	res, err := chainClient.GetDenomMetadata(ctx, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type   | Description | Required |
| --------- | ------ | ----------- | -------- |
| denom     | String | Token denom | Yes      |


### Response Parameters
> Response Example:

``` python
{
   "metadata":{
      "denomUnits":[
         {
            "denom":"factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position",
            "exponent":0,
            "aliases":[
               
            ]
         }
      ],
      "base":"factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position",
      "description":"",
      "display":"",
      "name":"",
      "symbol":"",
      "uri":"",
      "uriHash":""
   }
}
```

``` go
{
 "metadata": {
  "denom_units": [
   {
    "denom": "factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position"
   }
  ],
  "base": "factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position"
 }
}

```

| Parameter | Type     | Description       |
| --------- | -------- | ----------------- |
| metadata  | Metadata | Token information |

**Metadata**

| Parameter   | Type            | Description                                                |
| ----------- | --------------- | ---------------------------------------------------------- |
| description | String          | Token description                                          |
| denom_units | DenomUnit Array | DenomUnits                                                 |
| base        | String          | Token denom                                                |
| display     | String          | Token display name                                         |
| name        | String          | Token name                                                 |
| symbol      | String          | Token symbol                                               |
| uri         | String          | In general a URI to a document with additional information |
| uri_hash    | String          | SHA256 hash of a document pointed by URI                   |


## DenomsMetadata

Queries the metadata of all tokens

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/query/8_DenomsMetadata.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/query/8_DenomsMetadata.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    denoms = await client.fetch_denoms_metadata(
        pagination=PaginationOption(limit=10),
    )
    print(json.dumps(denoms, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/query/8_DenomsMetadata/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/query/8_DenomsMetadata/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/cosmos/cosmos-sdk/types/query"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	pagination := query.PageRequest{Limit: 10}
	ctx := context.Background()

	res, err := chainClient.GetDenomsMetadata(ctx, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type   | Description           | Required |
| ---------- | ------ | --------------------- | -------- |
| pagination | Paging | Pagination of results | No       |


### Response Parameters
> Response Example:

``` python
{
   "metadatas":[
      {
         "denomUnits":[
            {
               "denom":"factory/inj104y00apw6uu26gthl7cafztdy67hhmwksekdem/position",
               "exponent":0,
               "aliases":[
                  
               ]
            }
         ],
         "base":"factory/inj104y00apw6uu26gthl7cafztdy67hhmwksekdem/position",
         "description":"",
         "display":"",
         "name":"",
         "symbol":"",
         "uri":"",
         "uriHash":""
      },
      {
         "denomUnits":[
            {
               "denom":"factory/inj106rseec0xmv5k06aaf8jsnr57ajw76rxa3gpwm/position",
               "exponent":0,
               "aliases":[
                  
               ]
            }
         ],
         "base":"factory/inj106rseec0xmv5k06aaf8jsnr57ajw76rxa3gpwm/position",
         "description":"",
         "display":"",
         "name":"",
         "symbol":"",
         "uri":"",
         "uriHash":""
      },
      {
         "denomUnits":[
            {
               "denom":"factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position",
               "exponent":0,
               "aliases":[
                  
               ]
            }
         ],
         "base":"factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position",
         "description":"",
         "display":"",
         "name":"",
         "symbol":"",
         "uri":"",
         "uriHash":""
      },
      {
         "denomUnits":[
            {
               "denom":"factory/inj107skcseta3egagj822d3qdgusx7a7ua7sepmcf/position",
               "exponent":0,
               "aliases":[
                  
               ]
            }
         ],
         "base":"factory/inj107skcseta3egagj822d3qdgusx7a7ua7sepmcf/position",
         "description":"",
         "display":"",
         "name":"",
         "symbol":"",
         "uri":"",
         "uriHash":""
      },
      {
         "denomUnits":[
            {
               "denom":"factory/inj107srzqksjtdevlpw888vuyrnqmlpjuv64ytm85/position",
               "exponent":0,
               "aliases":[
                  
               ]
            }
         ],
         "base":"factory/inj107srzqksjtdevlpw888vuyrnqmlpjuv64ytm85/position",
         "description":"",
         "display":"",
         "name":"",
         "symbol":"",
         "uri":"",
         "uriHash":""
      },
      {
         "denomUnits":[
            {
               "denom":"factory/inj108t3mlej0dph8er6ca2lq5cs9pdgzva5mqsn5p/position",
               "exponent":0,
               "aliases":[
                  
               ]
            }
         ],
         "base":"factory/inj108t3mlej0dph8er6ca2lq5cs9pdgzva5mqsn5p/position",
         "description":"",
         "display":"",
         "name":"",
         "symbol":"",
         "uri":"",
         "uriHash":""
      },
      {
         "denomUnits":[
            {
               "denom":"factory/inj109rcepnmg7ewjcc4my3448jm3h0yjdwcl6kmnl/position",
               "exponent":0,
               "aliases":[
                  
               ]
            }
         ],
         "base":"factory/inj109rcepnmg7ewjcc4my3448jm3h0yjdwcl6kmnl/position",
         "description":"",
         "display":"",
         "name":"",
         "symbol":"",
         "uri":"",
         "uriHash":""
      },
      {
         "denomUnits":[
            {
               "denom":"factory/inj10ajd3f46mp755wmhgke8w4vcegfjndwfzymf82/position",
               "exponent":0,
               "aliases":[
                  
               ]
            }
         ],
         "base":"factory/inj10ajd3f46mp755wmhgke8w4vcegfjndwfzymf82/position",
         "description":"",
         "display":"",
         "name":"",
         "symbol":"",
         "uri":"",
         "uriHash":""
      },
      {
         "denomUnits":[
            {
               "denom":"factory/inj10fz2cj00ee80y76pdzg06dxfamat8nfpr9vl5s/position",
               "exponent":0,
               "aliases":[
                  
               ]
            }
         ],
         "base":"factory/inj10fz2cj00ee80y76pdzg06dxfamat8nfpr9vl5s/position",
         "description":"",
         "display":"",
         "name":"",
         "symbol":"",
         "uri":"",
         "uriHash":""
      },
      {
         "denomUnits":[
            {
               "denom":"factory/inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27/position",
               "exponent":0,
               "aliases":[
                  
               ]
            }
         ],
         "base":"factory/inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27/position",
         "description":"",
         "display":"",
         "name":"",
         "symbol":"",
         "uri":"",
         "uriHash":""
      }
   ],
   "pagination":{
      "nextKey":"ZmFjdG9yeS9pbmoxMGptcDZzZ2g0Y2M2enQzZThndzA1d2F2dmVqZ3I1cHc2bThqNzUvYWs=",
      "total":"0"
   }
}
```

``` go
{
 "metadatas": [
  {
   "denom_units": [
    {
     "denom": "factory/inj104y00apw6uu26gthl7cafztdy67hhmwksekdem/position"
    }
   ],
   "base": "factory/inj104y00apw6uu26gthl7cafztdy67hhmwksekdem/position"
  },
  {
   "denom_units": [
    {
     "denom": "factory/inj106rseec0xmv5k06aaf8jsnr57ajw76rxa3gpwm/position"
    }
   ],
   "base": "factory/inj106rseec0xmv5k06aaf8jsnr57ajw76rxa3gpwm/position"
  },
  {
   "denom_units": [
    {
     "denom": "factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position"
    }
   ],
   "base": "factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position"
  },
  {
   "denom_units": [
    {
     "denom": "factory/inj107skcseta3egagj822d3qdgusx7a7ua7sepmcf/position"
    }
   ],
   "base": "factory/inj107skcseta3egagj822d3qdgusx7a7ua7sepmcf/position"
  },
  {
   "denom_units": [
    {
     "denom": "factory/inj107srzqksjtdevlpw888vuyrnqmlpjuv64ytm85/position"
    }
   ],
   "base": "factory/inj107srzqksjtdevlpw888vuyrnqmlpjuv64ytm85/position"
  },
  {
   "denom_units": [
    {
     "denom": "factory/inj108t3mlej0dph8er6ca2lq5cs9pdgzva5mqsn5p/position"
    }
   ],
   "base": "factory/inj108t3mlej0dph8er6ca2lq5cs9pdgzva5mqsn5p/position"
  },
  {
   "denom_units": [
    {
     "denom": "factory/inj109rcepnmg7ewjcc4my3448jm3h0yjdwcl6kmnl/position"
    }
   ],
   "base": "factory/inj109rcepnmg7ewjcc4my3448jm3h0yjdwcl6kmnl/position"
  },
  {
   "denom_units": [
    {
     "denom": "factory/inj10ajd3f46mp755wmhgke8w4vcegfjndwfzymf82/position"
    }
   ],
   "base": "factory/inj10ajd3f46mp755wmhgke8w4vcegfjndwfzymf82/position"
  },
  {
   "denom_units": [
    {
     "denom": "factory/inj10fz2cj00ee80y76pdzg06dxfamat8nfpr9vl5s/position"
    }
   ],
   "base": "factory/inj10fz2cj00ee80y76pdzg06dxfamat8nfpr9vl5s/position"
  },
  {
   "denom_units": [
    {
     "denom": "factory/inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27/position"
    }
   ],
   "base": "factory/inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27/position"
  }
 ],
 "pagination": {
  "next_key": "ZmFjdG9yeS9pbmoxMGptcDZzZ2g0Y2M2enQzZThndzA1d2F2dmVqZ3I1cHc2bThqNzUvYWs="
 }
}
```

| Parameter  | Type           | Description        |
| ---------- | -------------- | ------------------ |
| metadatas  | Metadata Array | Tokens information |
| pagination | Pagination     | Pagination object  |

**Metadata**

| Parameter   | Type            | Description                                                |
| ----------- | --------------- | ---------------------------------------------------------- |
| description | String          | Token description                                          |
| denom_units | DenomUnit Array | DenomUnits                                                 |
| base        | String          | Token denom                                                |
| display     | String          | Token display name                                         |
| name        | String          | Token name                                                 |
| symbol      | String          | Token symbol                                               |
| uri         | String          | In general a URI to a document with additional information |
| uri_hash    | String          | SHA256 hash of a document pointed by URI                   |


## DenomsOwners

Queries for all account addresses that own a particular token

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/query/9_DenomOwners.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/query/9_DenomOwners.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    denom = "inj"
    owners = await client.fetch_denom_owners(
        denom=denom,
        pagination=PaginationOption(limit=10),
    )
    print(json.dumps(owners, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/query/9_DenomOwners/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/query/9_DenomOwners/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	"github.com/cosmos/cosmos-sdk/types/query"

	"os"
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

	denom := "factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position"
	pagination := query.PageRequest{Limit: 10}
	ctx := context.Background()

	res, err := chainClient.GetDenomOwners(ctx, denom, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type   | Description           | Required |
| ---------- | ------ | --------------------- | -------- |
| denom      | String | Token denom           | Yes      |
| pagination | Paging | Pagination of results | No       |


### Response Parameters
> Response Example:

``` python
{
   "denomOwners":[
      {
         "address":"inj1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqe2hm49",
         "balance":{
            "denom":"inj",
            "amount":"420000000000000010003"
         }
      },
      {
         "address":"inj1qqqqqqqpa95pcsnxa3927hlym6t8quhwlgkmqt",
         "balance":{
            "denom":"inj",
            "amount":"10000000000000000"
         }
      },
      {
         "address":"inj1qqqqqqzw4rg692t320252whr7gjp4k86lun8hp",
         "balance":{
            "denom":"inj",
            "amount":"143805431033925108"
         }
      },
      {
         "address":"inj1qqqqqqr0g47qlr6kqveans58w2raj25j095pad",
         "balance":{
            "denom":"inj",
            "amount":"199999568185205399700"
         }
      },
      {
         "address":"inj1qqqqqq4ze7h25mf9w8h8h02h807yj2fxzl27m8",
         "balance":{
            "denom":"inj",
            "amount":"10000"
         }
      },
      {
         "address":"inj1qqqqqqhn9sygdmn966q9n77mwmhk56vkkae2d3",
         "balance":{
            "denom":"inj",
            "amount":"260838118080821668174"
         }
      },
      {
         "address":"inj1qqqqqr5pwtzk2n8tswusllscjagw3w9k3dyceg",
         "balance":{
            "denom":"inj",
            "amount":"826945326095056784"
         }
      },
      {
         "address":"inj1qqqqqrk35e4y5r3aklpeelkkr9hkxq4k4y55c9",
         "balance":{
            "denom":"inj",
            "amount":"49800000000000000"
         }
      },
      {
         "address":"inj1qqqqqyyfzemqpsjjtrdzn5hzept7c95f8zyhmn",
         "balance":{
            "denom":"inj",
            "amount":"599500010155805818137328"
         }
      },
      {
         "address":"inj1qqqqqy2thegwe8473jk5u6th93uc488n4ltucm",
         "balance":{
            "denom":"inj",
            "amount":"40027858757349727870"
         }
      }
   ],
   "pagination":{
      "nextKey":"FAAAADLLRNDsOnihjI3alQcdNB0a",
      "total":"0"
   }
}
```

``` go
{
 "denom_owners": [
  {
   "address": "inj15e2qkdv5kf0w79f34t0c0w3j7arhxe4gy6juwf",
   "balance": {
    "denom": "factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position",
    "amount": "1921200000000000000000"
   }
  }
 ],
 "pagination": {}
}
```

| Parameter    | Type             | Description       |
| ------------ | ---------------- | ----------------- |
| denom_owners | DenomOwner Array | Token owners      |
| pagination   | Pagination       | Pagination object |

**DenomOwner**

| Parameter | Type   | Description     |
| --------- | ------ | --------------- |
| address   | String | Account address |
| balance   | Coin   | Token amount    |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |


## SendEnabled

This query only returns denominations that have specific SendEnabled settings. Any denomination that does not have a specific setting will use the default params.default_send_enabled, and will not be returned by this query.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/bank/query/10_SendEnabled.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/bank/query/10_SendEnabled.py -->
```py
import asyncio
import json

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    denom = "inj"
    enabled = await client.fetch_send_enabled(
        denoms=[denom],
        pagination=PaginationOption(limit=10),
    )
    print(json.dumps(enabled, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/bank/query/10_BankSendEnabled/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/bank/query/10_BankSendEnabled/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	"github.com/cosmos/cosmos-sdk/types/query"

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

	denoms := []string{"factory/inj107aqkjc3t5r3l9j4n9lgrma5tm3jav8qgppz6m/position"}
	pagination := query.PageRequest{Limit: 10}
	ctx := context.Background()

	res, err := chainClient.GetBankSendEnabled(ctx, denoms, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type         | Description           | Required |
| ---------- | ------------ | --------------------- | -------- |
| denom      | String Array | Token denoms          | No       |
| pagination | Paging       | Pagination of results | No       |


### Response Parameters
> Response Example:

``` python
```

``` go
```

| Parameter    | Type              | Description             |
| ------------ | ----------------- | ----------------------- |
| send_enabled | SendEnabled Array | SendEnabled information |
| pagination   | Pagination        | Pagination object       |

**SendEnabled**

| Parameter | Type   | Description   |
| --------- | ------ | ------------- |
| denom     | String | Token denom   |
| enabled   | Bool   | True or False |
