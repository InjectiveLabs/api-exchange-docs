# - InjectiveMetaRPC
InjectiveMetaRPC defines the gRPC API of the Exchange Meta provider.

## Ping

Get the server health.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/meta_rpc/1_Ping.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/meta_rpc/1_Ping.py -->
```py
import asyncio
import json

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    resp = await client.fetch_ping()
    print(json.dumps(resp, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/meta/1_Ping/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/meta/1_Ping/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	metaPB "github.com/InjectiveLabs/sdk-go/exchange/meta_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := metaPB.PingRequest{}

	res, err := exchangeClient.Ping(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

> Response Example:

``` python
Health OK?
```

``` go
Health OK?{}
```


## Version

Get the server version.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/meta_rpc/2_Version.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/meta_rpc/2_Version.py -->
```py
import asyncio
import json

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    resp = await client.fetch_version()
    print(json.dumps(resp, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/meta/2_Version/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/meta/2_Version/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	metaPB "github.com/InjectiveLabs/sdk-go/exchange/meta_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := metaPB.VersionRequest{}

	res, err := exchangeClient.GetVersion(ctx, &req)
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
   "version":"v1.12.46-rc1",
   "build":{
      "BuildDate":"20231110-0736",
      "GitCommit":"2b326fe",
      "GoVersion":"go1.20.5",
      "GoArch":"amd64"
   }
}
```

``` go
{
 "version": "dev",
 "build": {
  "BuildDate": "20220426-0810",
  "GitCommit": "4f3bc09",
  "GoArch": "amd64",
  "GoVersion": "go1.17.3"
 }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_meta_rpc/VersionResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">string</td><td class="description-td td_text">injective-exchange code version.</td></tr>
<tr ><td class="parameter-td td_text">build</td><td class="type-td td_text">map[string]string</td><td class="description-td td_text">Additional build meta info.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Info

Get the server information.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/meta_rpc/3_Info.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/meta_rpc/3_Info.py -->
```py
import asyncio
import json
import time

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    resp = await client.fetch_info()
    print("[!] Info:")
    print(json.dumps(resp, indent=2))
    latency = int(time.time() * 1000) - int(resp["timestamp"])
    print(f"Server Latency: {latency}ms")


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/meta/3_Info/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/meta/3_Info/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	metaPB "github.com/InjectiveLabs/sdk-go/exchange/meta_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := metaPB.InfoRequest{}

	res, err := exchangeClient.GetInfo(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_meta_rpc/InfoRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">Provide current system UNIX timestamp in millis</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "timestamp":"1702040535291",
   "serverTime":"1702040536394",
   "version":"v1.12.46-guilds-rc5",
   "build":{
      "BuildDate":"20231113-1523",
      "GitCommit":"78a9ea2",
      "GoVersion":"go1.20.5",
      "GoArch":"amd64"
   },
   "region":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_meta_rpc/InfoResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">The original timestamp value in millis.</td></tr>
<tr ><td class="parameter-td td_text">server_time</td><td class="type-td td_text">int64</td><td class="description-td td_text">UNIX time on the server in millis.</td></tr>
<tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">string</td><td class="description-td td_text">injective-exchange code version.</td></tr>
<tr ><td class="parameter-td td_text">build</td><td class="type-td td_text">map[string]string</td><td class="description-td td_text">Additional build meta info.</td></tr>
<tr ><td class="parameter-td td_text">region</td><td class="type-td td_text">string</td><td class="description-td td_text">Server's location region</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## StreamKeepAlive

Subscribe to a stream and gracefully disconnect and connect to another sentry node if the primary becomes unavailable.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/meta_rpc/4_StreamKeepAlive.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/meta_rpc/4_StreamKeepAlive.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to keepalive updates ({exception})")


def stream_closed_processor():
    print("The keepalive stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    tasks = []

    async def keepalive_event_processor(event: Dict[str, Any]):
        print("Server announce:", event)
        for task in tasks:
            task.cancel()
        print("Cancelled all tasks")

    market_task = asyncio.get_event_loop().create_task(get_markets(client))
    tasks.append(market_task)
    keepalive_task = asyncio.get_event_loop().create_task(
        client.listen_keepalive(
            callback=keepalive_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    try:
        await asyncio.gather(market_task, keepalive_task)
    except asyncio.CancelledError:
        print("main(): get_markets is cancelled now")


async def get_markets(client):
    async def print_market_updates(event: Dict[str, Any]):
        print(event)

    await client.listen_spot_markets_updates(
        callback=print_market_updates,
        on_end_callback=stream_closed_processor,
        on_status_callback=stream_error_processor,
    )


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/meta/4_StreamKeepAlive/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/meta/4_StreamKeepAlive/example.go -->
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
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	stream, err := exchangeClient.StreamKeepalive(ctx)
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
event: "shutdown",
timestamp: 1636236225847,

"Cancelled all tasks"
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_meta_rpc/InfoResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">int64</td><td class="description-td td_text">The original timestamp value in millis.</td></tr>
<tr ><td class="parameter-td td_text">server_time</td><td class="type-td td_text">int64</td><td class="description-td td_text">UNIX time on the server in millis.</td></tr>
<tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">string</td><td class="description-td td_text">injective-exchange code version.</td></tr>
<tr ><td class="parameter-td td_text">build</td><td class="type-td td_text">map[string]string</td><td class="description-td td_text">Additional build meta info.</td></tr>
<tr ><td class="parameter-td td_text">region</td><td class="type-td td_text">string</td><td class="description-td td_text">Server's location region</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
