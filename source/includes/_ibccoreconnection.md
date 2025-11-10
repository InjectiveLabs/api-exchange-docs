# - IBC Core Connection

Includes all the messages and queries associated to connections from the IBC core connection module

## Connection

Queries an IBC connection end

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/ibc/connection/query/1_Connection.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/ibc/connection/query/1_Connection.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    connection_id = "connection-0"

    connection = await client.fetch_ibc_connection(connection_id=connection_id)
    print(connection)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/ibc/connection/query/1_Connection/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/ibc/connection/query/1_Connection/example.go -->
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

	connectionId := "connection-0"
	ctx := context.Background()

	res, err := chainClient.FetchIBCConnection(ctx, connectionId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryConnectionRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">connection_id</td><td class="type-td td_text">string</td><td class="description-td td_text">connection unique identifier</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "connection":{
      "clientId":"07-tendermint-0",
      "versions":[
         {
            "identifier":"1",
            "features":[
               "ORDER_ORDERED",
               "ORDER_UNORDERED"
            ]
         }
      ],
      "state":"STATE_OPEN",
      "counterparty":{
         "clientId":"07-tendermint-904",
         "connectionId":"connection-877",
         "prefix":{
            "keyPrefix":"aWJj"
         }
      },
      "delayPeriod":"0"
   },
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"27778433"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryConnectionResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">connection</td><td class="type-td td_text">ConnectionEnd</td><td class="description-td td_text">connection associated with the request identifier</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">byte array</td><td class="description-td td_text">merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">types.Height</td><td class="description-td td_text">height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ConnectionEnd**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/ConnectionEnd.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">string</td><td class="description-td td_text">client associated with this connection.</td></tr>
<tr ><td class="parameter-td td_text">versions</td><td class="type-td td_text">Version array</td><td class="description-td td_text">IBC version which can be utilised to determine encodings or protocols for channels or packets utilising this connection.</td></tr>
<tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">State</td><td class="description-td td_text">current state of the connection end.</td></tr>
<tr ><td class="parameter-td td_text">counterparty</td><td class="type-td td_text">Counterparty</td><td class="description-td td_text">counterparty chain associated with this connection.</td></tr>
<tr ><td class="parameter-td td_text">delay_period</td><td class="type-td td_text">uint64</td><td class="description-td td_text">delay period that must pass before a consensus state can be used for packet-verification NOTE: delay period logic is only implemented by some clients.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Version**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/Version.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">identifier</td><td class="type-td td_text">string</td><td class="description-td td_text">unique version identifier</td></tr>
<tr ><td class="parameter-td td_text">features</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of features compatible with the specified identifier</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**State**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/channel/v1/State.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">STATE_UNINITIALIZED_UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">STATE_INIT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">STATE_TRYOPEN</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STATE_OPEN</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STATE_CLOSED</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">STATE_FLUSHING</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">STATE_FLUSHCOMPLETE</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Counterparty**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/Counterparty.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">string</td><td class="description-td td_text">identifies the client on the counterparty chain associated with a given connection.</td></tr>
<tr ><td class="parameter-td td_text">connection_id</td><td class="type-td td_text">string</td><td class="description-td td_text">identifies the connection end on the counterparty chain associated with a given connection.</td></tr>
<tr ><td class="parameter-td td_text">prefix</td><td class="type-td td_text">types.MerklePrefix</td><td class="description-td td_text">commitment merkle prefix of the counterparty chain.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MerklePrefix**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/23-commitment/types/MerklePrefix.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key_prefix</td><td class="type-td td_text">byte array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/02-client/types/Height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Connections

Queries all the IBC connections of a chain

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/ibc/connection/query/2_Connections.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/ibc/connection/query/2_Connections.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    pagination = PaginationOption(skip=2, limit=4)

    connections = await client.fetch_ibc_connections(pagination=pagination)
    print(connections)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/ibc/connection/query/2_Connections/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/ibc/connection/query/2_Connections/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/cosmos/cosmos-sdk/types/query"

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

	pagination := query.PageRequest{Offset: 2, Limit: 4}
	ctx := context.Background()

	res, err := chainClient.FetchIBCConnections(ctx, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryConnectionsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">query.PageRequest</td><td class="description-td td_num"></td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PageRequest**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/query/PageRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">byte array</td><td class="description-td td_text">key is a value returned in PageResponse.next_key to begin querying the next page most efficiently. Only one of offset or key should be set.</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">offset</td><td class="type-td td_text">uint64</td><td class="description-td td_text">offset is a numeric offset that can be used when key is unavailable. It is less efficient than using key. Only one of offset or key should be set.</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">limit</td><td class="type-td td_text">uint64</td><td class="description-td td_text">limit is the total number of results to be returned in the result page. If left empty it will default to a value to be set by each app.</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">count_total</td><td class="type-td td_text">bool</td><td class="description-td td_text">count_total is set to true  to indicate that the result set should include a count of the total number of items available for pagination in UIs. count_total is only respected when offset is used. It is ignored when key is set.</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">reverse</td><td class="type-td td_text">bool</td><td class="description-td td_text">reverse is set to true if results are to be returned in the descending order.  Since: cosmos-sdk 0.43</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "connections":[
      {
         "id":"connection-10",
         "clientId":"07-tendermint-12",
         "versions":[
            {
               "identifier":"1",
               "features":[
                  "ORDER_ORDERED",
                  "ORDER_UNORDERED"
               ]
            }
         ],
         "state":"STATE_OPEN",
         "counterparty":{
            "clientId":"07-tendermint-103",
            "connectionId":"connection-93",
            "prefix":{
               "keyPrefix":"aWJj"
            }
         },
         "delayPeriod":"0"
      },
      {
         "id":"connection-100",
         "clientId":"07-tendermint-126",
         "versions":[
            {
               "identifier":"1",
               "features":[
                  "ORDER_ORDERED",
                  "ORDER_UNORDERED"
               ]
            }
         ],
         "state":"STATE_OPEN",
         "counterparty":{
            "clientId":"07-tendermint-168",
            "connectionId":"connection-118",
            "prefix":{
               "keyPrefix":"aWJj"
            }
         },
         "delayPeriod":"0"
      },
      {
         "id":"connection-101",
         "clientId":"07-tendermint-127",
         "versions":[
            {
               "identifier":"1",
               "features":[
                  "ORDER_ORDERED",
                  "ORDER_UNORDERED"
               ]
            }
         ],
         "state":"STATE_OPEN",
         "counterparty":{
            "clientId":"07-tendermint-3",
            "connectionId":"connection-5",
            "prefix":{
               "keyPrefix":"aWJj"
            }
         },
         "delayPeriod":"0"
      },
      {
         "id":"connection-102",
         "clientId":"07-tendermint-128",
         "versions":[
            {
               "identifier":"1",
               "features":[
                  "ORDER_ORDERED",
                  "ORDER_UNORDERED"
               ]
            }
         ],
         "state":"STATE_OPEN",
         "counterparty":{
            "clientId":"07-tendermint-633",
            "connectionId":"connection-574",
            "prefix":{
               "keyPrefix":"aWJj"
            }
         },
         "delayPeriod":"0"
      }
   ],
   "pagination":{
      "nextKey":"L2Nvbm5lY3Rpb24tMTAz",
      "total":"0"
   },
   "height":{
      "revisionNumber":"888",
      "revisionHeight":"27779944"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryConnectionsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">connections</td><td class="type-td td_text">IdentifiedConnection array</td><td class="description-td td_text">list of stored connections of the chain.</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">query.PageResponse</td><td class="description-td td_text">pagination response</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">types.Height</td><td class="description-td td_text">query block height</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**IdentifiedConnection**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/IdentifiedConnection.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">id</td><td class="type-td td_text">string</td><td class="description-td td_text">connection identifier.</td></tr>
<tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">string</td><td class="description-td td_text">client associated with this connection.</td></tr>
<tr ><td class="parameter-td td_text">versions</td><td class="type-td td_text">Version array</td><td class="description-td td_text">IBC version which can be utilised to determine encodings or protocols for channels or packets utilising this connection</td></tr>
<tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">State</td><td class="description-td td_text">current state of the connection end.</td></tr>
<tr ><td class="parameter-td td_text">counterparty</td><td class="type-td td_text">Counterparty</td><td class="description-td td_text">counterparty chain associated with this connection.</td></tr>
<tr ><td class="parameter-td td_text">delay_period</td><td class="type-td td_text">uint64</td><td class="description-td td_text">delay period associated with this connection.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PageResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/query/PageResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">next_key</td><td class="type-td td_text">byte array</td><td class="description-td td_text">next_key is the key to be passed to PageRequest.key to query the next page most efficiently. It will be empty if there are no more results.</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">uint64</td><td class="description-td td_text">total is total number of results available if PageRequest.count_total was set, its value is undefined otherwise</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/02-client/types/Height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Version**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/Version.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">identifier</td><td class="type-td td_text">string</td><td class="description-td td_text">unique version identifier</td></tr>
<tr ><td class="parameter-td td_text">features</td><td class="type-td td_text">string array</td><td class="description-td td_text">list of features compatible with the specified identifier</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**State**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/channel/v1/State.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">STATE_UNINITIALIZED_UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">STATE_INIT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">STATE_TRYOPEN</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STATE_OPEN</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STATE_CLOSED</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">STATE_FLUSHING</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">STATE_FLUSHCOMPLETE</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Counterparty**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/Counterparty.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">string</td><td class="description-td td_text">identifies the client on the counterparty chain associated with a given connection.</td></tr>
<tr ><td class="parameter-td td_text">connection_id</td><td class="type-td td_text">string</td><td class="description-td td_text">identifies the connection end on the counterparty chain associated with a given connection.</td></tr>
<tr ><td class="parameter-td td_text">prefix</td><td class="type-td td_text">types.MerklePrefix</td><td class="description-td td_text">commitment merkle prefix of the counterparty chain.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MerklePrefix**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/23-commitment/types/MerklePrefix.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key_prefix</td><td class="type-td td_text">byte array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ClientConnections

Queries the connection paths associated with a client state

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/ibc/connection/query/3_ClientConnections.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/ibc/connection/query/3_ClientConnections.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    client_id = "07-tendermint-0"

    connections = await client.fetch_ibc_client_connections(client_id=client_id)
    print(connections)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/ibc/connection/query/3_ClientConnections/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/ibc/connection/query/3_ClientConnections/example.go -->
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

	clientId := "07-tendermint-0"
	ctx := context.Background()

	res, err := chainClient.FetchIBCClientConnections(ctx, clientId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryClientConnectionsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">string</td><td class="description-td td_text">client identifier associated with a connection</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "connectionPaths":[
      "connection-0"
   ],
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"27783349"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryClientConnectionsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">connection_paths</td><td class="type-td td_text">string array</td><td class="description-td td_text">slice of all the connection paths associated with a client.</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">byte array</td><td class="description-td td_text">merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">types.Height</td><td class="description-td td_text">height at which the proof was generated</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/02-client/types/Height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ConnectionClientState

Queries the client state associated with the connection

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/ibc/connection/query/4_ConnectionClientState.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/ibc/connection/query/4_ConnectionClientState.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    connection_id = "connection-0"

    state = await client.fetch_ibc_connection_client_state(connection_id=connection_id)
    print(state)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/ibc/connection/query/4_ConnectionClientState/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/ibc/connection/query/4_ConnectionClientState/example.go -->
```go
package main

import (
	"context"
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

	connectionId := "connection-0"
	ctx := context.Background()

	res, err := chainClient.FetchIBCConnectionClientState(ctx, connectionId)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res)

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryConnectionClientStateRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">connection_id</td><td class="type-td td_text">string</td><td class="description-td td_text">connection identifier</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "identifiedClientState":{
      "clientId":"07-tendermint-0",
      "clientState":{
         "@type":"/ibc.lightclients.tendermint.v1.ClientState",
         "chainId":"band-laozi-testnet4",
         "trustLevel":{
            "numerator":"1",
            "denominator":"3"
         },
         "trustingPeriod":"1209600s",
         "unbondingPeriod":"1814400s",
         "maxClockDrift":"20s",
         "frozenHeight":{
            "revisionNumber":"0",
            "revisionHeight":"0"
         },
         "latestHeight":{
            "revisionHeight":"7379538",
            "revisionNumber":"0"
         },
         "proofSpecs":[
            {
               "leafSpec":{
                  "hash":"SHA256",
                  "prehashValue":"SHA256",
                  "length":"VAR_PROTO",
                  "prefix":"AA==",
                  "prehashKey":"NO_HASH"
               },
               "innerSpec":{
                  "childOrder":[
                     0,
                     1
                  ],
                  "childSize":33,
                  "minPrefixLength":4,
                  "maxPrefixLength":12,
                  "hash":"SHA256",
                  "emptyChild":""
               },
               "maxDepth":0,
               "minDepth":0,
               "prehashKeyBeforeComparison":false
            },
            {
               "leafSpec":{
                  "hash":"SHA256",
                  "prehashValue":"SHA256",
                  "length":"VAR_PROTO",
                  "prefix":"AA==",
                  "prehashKey":"NO_HASH"
               },
               "innerSpec":{
                  "childOrder":[
                     0,
                     1
                  ],
                  "childSize":32,
                  "minPrefixLength":1,
                  "maxPrefixLength":1,
                  "hash":"SHA256",
                  "emptyChild":""
               },
               "maxDepth":0,
               "minDepth":0,
               "prehashKeyBeforeComparison":false
            }
         ],
         "upgradePath":[
            "upgrade",
            "upgradedIBCState"
         ],
         "allowUpdateAfterExpiry":true,
         "allowUpdateAfterMisbehaviour":true
      }
   },
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"27783852"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryConnectionClientStateResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">identified_client_state</td><td class="type-td td_text">types.IdentifiedClientState</td><td class="description-td td_text">client state associated with the channel</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">byte array</td><td class="description-td td_text">merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">types.Height</td><td class="description-td td_text">height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**IdentifiedClientState**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/02-client/types/IdentifiedClientState.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">string</td><td class="description-td td_text">client identifier</td></tr>
<tr ><td class="parameter-td td_text">client_state</td><td class="type-td td_text">types.Any</td><td class="description-td td_text">client state</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/02-client/types/Height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ConnectionConsensusState

Queries the consensus state associated with the connection

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/ibc/connection/query/5_ConnectionConsensusState.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/ibc/connection/query/5_ConnectionConsensusState.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    connection_id = "connection-0"
    revision_number = 0
    revision_height = 7379538

    state = await client.fetch_ibc_connection_consensus_state(
        connection_id=connection_id, revision_number=revision_number, revision_height=revision_height
    )
    print(state)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/ibc/connection/query/5_ConnectionConsensusState/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/ibc/connection/query/5_ConnectionConsensusState/example.go -->
```go
package main

import (
	"context"
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

	connectionId := "connection-0"
	revisionNumber := uint64(0)
	revisionHeight := uint64(7379538)

	ctx := context.Background()

	res, err := chainClient.FetchIBCConnectionConsensusState(ctx, connectionId, revisionNumber, revisionHeight)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res)

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryConnectionConsensusStateRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">connection_id</td><td class="type-td td_text">string</td><td class="description-td td_text">connection identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">uint64</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">uint64</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "consensusState":{
      "@type":"/ibc.lightclients.tendermint.v1.ConsensusState",
      "timestamp":"2022-07-04T10:34:53.874345276Z",
      "root":{
         "hash":"viI6JuzZ/kOAh6jIeecglN7Xt+mGQT/PpvAGqGLcVmM="
      },
      "nextValidatorsHash":"olPEfP4dzPCC07Oyg/3+6U5/uumw/HmELk2MwpMogSg="
   },
   "clientId":"07-tendermint-0",
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"27784841"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryConnectionConsensusStateResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">consensus_state</td><td class="type-td td_text">types1.Any</td><td class="description-td td_text">consensus state associated with the channel</td></tr>
<tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">string</td><td class="description-td td_text">client ID associated with the consensus state</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">byte array</td><td class="description-td td_text">merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">types.Height</td><td class="description-td td_text">height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/02-client/types/Height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">uint64</td><td class="description-td td_text">the height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ConnectionParams

Queries all parameters of the ibc connection submodule

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/ibc/connection/query/6_ConnectionParams.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/ibc/connection/query/6_ConnectionParams.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    params = await client.fetch_ibc_connection_params()
    print(params)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/ibc/connection/query/6_ConnectionParams/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/ibc/connection/query/6_ConnectionParams/example.go -->
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

	ctx := context.Background()

	res, err := chainClient.FetchIBCConnectionParams(ctx)
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
{
   "params":{
      "maxExpectedTimePerBlock":"30000000000"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/QueryConnectionParamsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">params</td><td class="type-td td_text">Params</td><td class="description-td td_text">params defines the parameters of the module.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Params**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/ibc/core/03-connection/types/Params.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">max_expected_time_per_block</td><td class="type-td td_text">uint64</td><td class="description-td td_text">maximum expected time per block (in nanoseconds), used to enforce block delay. This parameter should reflect the largest amount of time that the chain might reasonably take to produce the next block under normal operating conditions. A safe choice is 3-5x the expected time per block.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->