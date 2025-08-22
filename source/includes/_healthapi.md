# - HealthAPI
HealthAPI (HTTP) checks if backend data is up-to-date and reliable or not.

## GetStatus

**IP rate limit group:** `chain`


To check the health of a node, the GetStatus API can be queried to obtain the Indexer height (`localHeight`) and the network height (`horacleHeight`). Next, the chain node height can be queried directly from the node (e.g. `curl --insecure http://sentry.lcd.injective.network:26657/abci_info | grep last_block_height` or in Python `(await async_client.get_latest_block()).block.header.height`). Comparing `last_block_height` with `horacleHeight` gives a sense of the chain node's health, with a threshold of a 20 block difference being a good starting point for detecting unhealthy nodes. `localHeight` and `horacleHeight` can also be compared to check Indexer health, though an error should already be returned from the API query if the Indexer is deemed unhealthy (more than 20 block height difference).

If LB/K8S endpoints are being used, there is no need to do these checks, as the cluster has built-in liveliness checks and excludes unhealthy nodes if any are detected.

A recommended health check frequency of once every 20-30 seconds is recommended.

**Notes**

*horacleHeight:* the network height of the chain (average returned by multiple nodes in the network)

*localHeight:* the latest synced block on the indexer

*lastBlock:* the latest synced block on the chain

### Request Parameters
> Request Example:


``` python
import requests

def main() -> None:
    r = requests.get('https://sentry.lcd.injective.network:4444/api/health/v1/status', verify=False)
    print(r.text)

if __name__ == '__main__':
    main()

```

``` go
package main

import (
  "crypto/tls"
  "fmt"
  "io/ioutil"
  "net/http"
  "time"
)

func queryHealthAPI(url, method string) ([]byte, error) {
  tr := &http.Transport{
    TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
  }
  client := &http.Client{
    Transport: tr,
    Timeout:   time.Second * 10,
  }

  req, err := http.NewRequest(method, url, nil)
  if err != nil {
    return nil, fmt.Errorf("new request err: %w", err)
  }

  response, err := client.Do(req)
  if err != nil {
    return nil, fmt.Errorf("exec request err: %w", err)
  }
  defer response.Body.Close()

  return ioutil.ReadAll(response.Body)
}

func main() {
  result, err := queryHealthAPI("https://sentry.lcd.injective.network:4444/api/health/v1/status", "GET")
  if err != nil {
    panic(err)
  }

  fmt.Println("query result:", string(result))
}
```

### Response Parameters
> Response Example:

```json
{
  "s": "",
  "data": {
    "localHeight": 26953309,
    "localTimestamp": 1677042872,
    "horacleHeight": 26953309,
    "horacleTimestamp": 1677042872
  }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/health/GetStatusResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">s</td><td class="type-td td_text">string</td><td class="description-td td_text">Status of the response.</td></tr>
<tr ><td class="parameter-td td_text">errmsg</td><td class="type-td td_text">string</td><td class="description-td td_text">Error message.</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">HealthStatus</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**HealthStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/health/HealthStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">local_height</td><td class="type-td td_text">int32</td><td class="description-td td_text">Block height from local mongo exchange db.</td></tr>
<tr ><td class="parameter-td td_text">local_timestamp</td><td class="type-td td_text">int32</td><td class="description-td td_text">block timestamp from local mongo exchange db.</td></tr>
<tr ><td class="parameter-td td_text">horacle_height</td><td class="type-td td_text">int32</td><td class="description-td td_text">block height from Horacle service.</td></tr>
<tr ><td class="parameter-td td_text">horacle_timestamp</td><td class="type-td td_text">int32</td><td class="description-td td_text">block timestamp from Horacle service.</td></tr>
<tr ><td class="parameter-td td_text">migration_last_version</td><td class="type-td td_text">int32</td><td class="description-td td_text">Migration version of the database.</td></tr>
<tr ><td class="parameter-td td_text">ep_height</td><td class="type-td td_text">int32</td><td class="description-td td_text">Block height from event provider service.</td></tr>
<tr ><td class="parameter-td td_text">ep_timestamp</td><td class="type-td td_text">int32</td><td class="description-td td_text">Block UNIX timestamp from event provider service.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
