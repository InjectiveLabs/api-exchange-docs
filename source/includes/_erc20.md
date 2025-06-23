# - ERC20

Includes all the messages and queries related to the tokens for the native EVM implementation.


## AllTokenPairs

Defines a gRPC query method that returns the erc20 module's created token pairs

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/erc20/query/1_AllTokenPairs.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/erc20/query/1_AllTokenPairs.py -->
```py
import asyncio
import json
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client_v2 import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
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

    pairs = await client.fetch_erc20_all_token_pairs(
        pagination=PaginationOption(
            skip=0,
            limit=100,
        ),
    )
    print(json.dumps(pairs, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/erc20/query/1_AllTokenPairs/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/erc20/query/1_AllTokenPairs/example.go -->
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

	ctx := context.Background()

	pagination := query.PageRequest{Limit: 10}

	res, err := chainClient.FetchAllTokenPairs(ctx, &pagination)
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

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/QueryAllTokenPairsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">token_pairs</td><td class="type-td td_text">TokenPair array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TokenPair**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/TokenPair.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bank_denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">erc20_address</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## TokenPairByDenom

Defines a gRPC query method that returns the erc20 module's token pair associated with the provided bank denom

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/erc20/query/2_TokenPairByDenom.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/erc20/query/2_TokenPairByDenom.py -->
```py
import asyncio
import json
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

    result = await client.fetch_erc20_token_pair_by_denom(bank_denom="usdt")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/erc20/query/2_TokenPairByDenom/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/erc20/query/2_TokenPairByDenom/example.go -->
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

	res, err := chainClient.FetchTokenPairByERC20Address(ctx, "usdt")
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/QueryTokenPairByDenomRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bank_denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/QueryTokenPairByDenomResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">token_pair</td><td class="type-td td_text">TokenPair</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TokenPair**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/TokenPair.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bank_denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">erc20_address</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## TokenPairByERC20Address

Defines a gRPC query method that returns the erc20 module's token pair associated with the provided erc20 contract address

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/erc20/query/3_TokenPairByERC20Address.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/erc20/query/3_TokenPairByERC20Address.py -->
```py
import asyncio
import json
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

    erc20_address = "0xdAC17F958D2ee523a2206206994597C13D831ec7"
    result = await client.fetch_erc20_token_pair_by_erc20_address(erc20_address=erc20_address)
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/erc20/query/3_TokenPairByERC20Address/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/erc20/query/3_TokenPairByERC20Address/example.go -->
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

	usdtERC20 := "0xdAC17F958D2ee523a2206206994597C13D831ec7"
	res, err := chainClient.FetchTokenPairByDenom(ctx, usdtERC20)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/QueryTokenPairByERC20AddressRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">erc20_address</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/QueryTokenPairByERC20AddressResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">token_pair</td><td class="type-td td_text">TokenPair</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TokenPair**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/TokenPair.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bank_denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">erc20_address</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgCreateTokenPair

Creates a new ERC20 token

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/erc20/1_CreateTokenPair.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/erc20/1_CreateTokenPair.py -->
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
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

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

    usdt_denom = "factory/inj10vkkttgxdeqcgeppu20x9qtyvuaxxev8qh0awq/usdt"
    usdt_erc20 = "0xdAC17F958D2ee523a2206206994597C13D831ec7"

    # prepare tx msg
    msg = composer.msg_create_token_pair(
        sender=address.to_acc_bech32(),
        bank_denom=usdt_denom,
        erc20_address=usdt_erc20,
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/erc20/1_CreateTokenPair/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/erc20/1_CreateTokenPair/example.go -->
```go
package main

import (
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	erc20types "github.com/InjectiveLabs/sdk-go/chain/erc20/types"
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

	usdtDenom := "factory/inj10vkkttgxdeqcgeppu20x9qtyvuaxxev8qh0awq/usdt"
	usdtERC20 := "0xdAC17F958D2ee523a2206206994597C13D831ec7"

	msg := &erc20types.MsgCreateTokenPair{
		Sender: senderAddress.String(),
		TokenPair: erc20types.TokenPair{
			BankDenom:    usdtDenom,
			Erc20Address: usdtERC20,
		},
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	err = chainClient.QueueBroadcastMsg(msg)

	if err != nil {
		fmt.Println(err)
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/MsgCreateTokenPair.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">token_pair</td><td class="type-td td_text">TokenPair</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TokenPair**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/TokenPair.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bank_denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">erc20_address</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
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


## MsgDeleteTokenPair

Deletes an ERC20 token

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/erc20/2_DeleteTokenPair.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/erc20/2_DeleteTokenPair.py -->
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
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

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

    usdt_denom = "factory/inj10vkkttgxdeqcgeppu20x9qtyvuaxxev8qh0awq/usdt"

    # prepare tx msg
    msg = composer.msg_delete_token_pair(
        sender=address.to_acc_bech32(),
        bank_denom=usdt_denom,
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/erc20/2_DeleteTokenPair/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/erc20/2_DeleteTokenPair/example.go -->
```go
package main

import (
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	erc20types "github.com/InjectiveLabs/sdk-go/chain/erc20/types"
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

	usdtDenom := "factory/inj10vkkttgxdeqcgeppu20x9qtyvuaxxev8qh0awq/usdt"

	msg := &erc20types.MsgDeleteTokenPair{
		Sender:    senderAddress.String(),
		BankDenom: usdtDenom,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	err = chainClient.QueueBroadcastMsg(msg)

	if err != nil {
		fmt.Println(err)
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/erc20/MsgDeleteTokenPair.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">bank_denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
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
