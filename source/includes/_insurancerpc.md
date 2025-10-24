# - InjectiveInsuranceRPC
InjectiveInsuranceRPC defines the gRPC API of the Insurance Exchange provider.


## InsuranceFunds

List all the insurance funds.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/insurance_rpc/1_InsuranceFunds.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/insurance_rpc/1_InsuranceFunds.py -->
```py
import asyncio
import json

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    insurance_funds = await client.fetch_insurance_funds()
    print(json.dumps(insurance_funds, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/insurance/1_InsuranceFunds/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/insurance/1_InsuranceFunds/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	insurancePB "github.com/InjectiveLabs/sdk-go/exchange/insurance_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := insurancePB.FundsRequest{}

	res, err := exchangeClient.GetInsuranceFunds(ctx, &req)
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
   "funds":[
      {
         "marketTicker":"BTC/USDT PERP",
         "marketId":"0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3",
         "depositDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "poolTokenDenom":"share1",
         "redemptionNoticePeriodDuration":"1209600",
         "balance":"3825059708",
         "totalShare":"1000000000000000000",
         "oracleBase":"BTC",
         "oracleQuote":"USDT",
         "oracleType":"bandibc",
         "expiry":"0"
      },
      {
         "marketTicker":"ETH/USDT PERP",
         "marketId":"0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff",
         "depositDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "poolTokenDenom":"share2",
         "redemptionNoticePeriodDuration":"1209600",
         "balance":"723501080000",
         "totalShare":"7235010800000000000",
         "oracleBase":"ETH",
         "oracleQuote":"USDT",
         "oracleType":"bandibc",
         "expiry":"0"
      }
   ]
}
```

``` go
{
 "funds": [
  {
   "market_ticker": "OSMO/UST PERP",
   "market_id": "0x8c7fd5e6a7f49d840512a43d95389a78e60ebaf0cde1af86b26a785eb23b3be5",
   "deposit_denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
   "pool_token_denom": "share19",
   "redemption_notice_period_duration": 1209600,
   "balance": "1000000",
   "total_share": "1000000000000000000",
   "oracle_base": "OSMO",
   "oracle_quote": "UST",
   "oracle_type": "bandibc"
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_insurance_rpc/FundsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">funds</td><td class="type-td td_text">InsuranceFund array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**InsuranceFund**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_insurance_rpc/InsuranceFund.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_ticker</td><td class="type-td td_text">string</td><td class="description-td td_text">Ticker of the derivative market.</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">string</td><td class="description-td td_text">Derivative Market ID</td></tr>
<tr ><td class="parameter-td td_text">deposit_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Coin denom used for the underwriting of the insurance fund.</td></tr>
<tr ><td class="parameter-td td_text">pool_token_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Pool token denom</td></tr>
<tr ><td class="parameter-td td_text">redemption_notice_period_duration</td><td class="type-td td_text">int64</td><td class="description-td td_text">Redemption notice period duration in seconds.</td></tr>
<tr ><td class="parameter-td td_text">balance</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">total_share</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">oracle_base</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle base currency</td></tr>
<tr ><td class="parameter-td td_text">oracle_quote</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle quote currency</td></tr>
<tr ><td class="parameter-td td_text">oracle_type</td><td class="type-td td_text">string</td><td class="description-td td_text">Oracle Type</td></tr>
<tr ><td class="parameter-td td_text">expiry</td><td class="type-td td_text">int64</td><td class="description-td td_text">Defines the expiry, if any</td></tr>
<tr ><td class="parameter-td td_text">deposit_token_meta</td><td class="type-td td_text">TokenMeta</td><td class="description-td td_text">Token metadata for the deposit asset</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TokenMeta**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_insurance_rpc/TokenMeta.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">name</td><td class="type-td td_text">string</td><td class="description-td td_text">Token full name</td></tr>
<tr ><td class="parameter-td td_text">address</td><td class="type-td td_text">string</td><td class="description-td td_text">Token contract address (native or not)</td></tr>
<tr ><td class="parameter-td td_text">symbol</td><td class="type-td td_text">string</td><td class="description-td td_text">Token symbol short name</td></tr>
<tr ><td class="parameter-td td_text">logo</td><td class="type-td td_text">string</td><td class="description-td td_text">URL to the logo image</td></tr>
<tr ><td class="parameter-td td_text">decimals</td><td class="type-td td_text">int32</td><td class="description-td td_text">Token decimals</td></tr>
<tr ><td class="parameter-td td_text">updated_at</td><td class="type-td td_text">int64</td><td class="description-td td_text">Token metadata fetched timestamp in UNIX millis.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Redemptions

Get a list of redemptions. If no parameters are provided, redemptions for all pools and addresses will be returned.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/exchange_client/insurance_rpc/2_Redemptions.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/exchange_client/insurance_rpc/2_Redemptions.py -->
```py
import asyncio
import json

from pyinjective.core.network import Network
from pyinjective.indexer_client import IndexerClient


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = IndexerClient(network)
    redeemer = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    redemption_denom = "share4"
    status = "disbursed"
    insurance_redemptions = await client.fetch_redemptions(address=redeemer, denom=redemption_denom, status=status)
    print(json.dumps(insurance_redemptions, indent=2))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/exchange/insurance/2_Redemptions/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/exchange/insurance/2_Redemptions/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	insurancePB "github.com/InjectiveLabs/sdk-go/exchange/insurance_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := insurancePB.RedemptionsRequest{}

	res, err := exchangeClient.GetRedemptions(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_insurance_rpc/RedemptionsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">redeemer</td><td class="type-td td_text">string</td><td class="description-td td_text">Account address of the redemption owner</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">redemption_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Denom of the insurance pool token.</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">string</td><td class="description-td td_text">Status of the redemption. Either pending or disbursed.</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "redemptionSchedules":[
      {
         "redemptionId":"1",
         "status":"disbursed",
         "redeemer":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "claimableRedemptionTime":"1674798129093000",
         "redemptionAmount":"500000000000000000",
         "redemptionDenom":"share4",
         "requestedAt":"1673588529093000",
         "disbursedAmount":"5000000",
         "disbursedDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "disbursedAt":"1674798130965000"
      },
      {
         "redemptionId":"2",
         "status":"disbursed",
         "redeemer":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "claimableRedemptionTime":"1674798342397000",
         "redemptionAmount":"2000000000000000000",
         "redemptionDenom":"share4",
         "requestedAt":"1673588742397000",
         "disbursedAmount":"20000000",
         "disbursedDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "disbursedAt":"1674798343097000"
      }
   ]
}
```

``` go
{
 "redemption_schedules": [
  {
   "redemption_id": 1,
   "status": "pending",
   "redeemer": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "claimable_redemption_time": 1654247935923000,
   "redemption_amount": "1000000000000000000",
   "redemption_denom": "share19",
   "requested_at": 1653038335923000
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_insurance_rpc/RedemptionsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">redemption_schedules</td><td class="type-td td_text">RedemptionSchedule array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RedemptionSchedule**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/injective_insurance_rpc/RedemptionSchedule.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">redemption_id</td><td class="type-td td_text">uint64</td><td class="description-td td_text">Redemption ID.</td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">string</td><td class="description-td td_text">Status of the redemption. Either pending or disbursed.</td></tr>
<tr ><td class="parameter-td td_text">redeemer</td><td class="type-td td_text">string</td><td class="description-td td_text">Account address of the redemption owner</td></tr>
<tr ><td class="parameter-td td_text">claimable_redemption_time</td><td class="type-td td_text">int64</td><td class="description-td td_text">Claimable redemption time in seconds</td></tr>
<tr ><td class="parameter-td td_text">redemption_amount</td><td class="type-td td_text">string</td><td class="description-td td_text">Amount of pool tokens being redeemed.</td></tr>
<tr ><td class="parameter-td td_text">redemption_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Pool token denom being redeemed.</td></tr>
<tr ><td class="parameter-td td_text">requested_at</td><td class="type-td td_text">int64</td><td class="description-td td_text">Redemption request time in unix milliseconds.</td></tr>
<tr ><td class="parameter-td td_text">disbursed_amount</td><td class="type-td td_text">string</td><td class="description-td td_text">Amount of quote tokens disbursed</td></tr>
<tr ><td class="parameter-td td_text">disbursed_denom</td><td class="type-td td_text">string</td><td class="description-td td_text">Denom of the quote tokens disbursed</td></tr>
<tr ><td class="parameter-td td_text">disbursed_at</td><td class="type-td td_text">int64</td><td class="description-td td_text">Redemption disbursement time in unix milliseconds.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
