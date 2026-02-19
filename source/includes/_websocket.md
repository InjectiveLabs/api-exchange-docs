# - WebSocket
The WebSocket endpoint provides a real-time streaming interface for Injective chain events. It is a wrapper on top of the Chain Stream gRPC service, so you receive the same event data (trades, orders, balances, oracle prices, etc.) over a standard WebSocket connection instead of gRPC. The request and response shapes match the [Chain Stream](#chain-stream) API: you use the same filters and receive the same stream payloads.

Use the WebSocket when your client environment supports WebSockets but not gRPC (e.g. browsers or some server runtimes), or when you prefer a single long-lived HTTP upgrade over gRPC streaming.

## Connecting

Connect to the WebSocket at the following path on a node that exposes the WebSocket server:

```
ws://<node-address>:<port>/injstream-ws
```

For secure connections, use a TLS-terminating proxy and connect with `wss://` to the proxy endpoint.

After the connection is established, send JSON-RPC 2.0 requests to subscribe or unsubscribe. All messages are JSON; text frames only.

> Connect and subscribe:

```py
import asyncio
import json

import websockets


async def main():
    uri = "ws://localhost:9998/injstream-ws"
    async with websockets.connect(uri) as ws:
        subscribe_request = {
            "jsonrpc": "2.0",
            "id": 1,
            "method": "subscribe",
            "params": {
                "req": {
                    "subscription_id": "my-oracle-prices",
                    "filter": {
                        "oracle_price_filter": {"symbol": ["INJ", "USDT"]}
                    },
                }
            },
        }
        await ws.send(json.dumps(subscribe_request))

        async for raw in ws:
            msg = json.loads(raw)
            print(msg)


if __name__ == "__main__":
    asyncio.run(main())
```
```go
package main

import (
	"encoding/json"
	"log"
	"net/url"

	"github.com/gorilla/websocket"
)

func main() {
	u := url.URL{Scheme: "ws", Host: "localhost:9998", Path: "/injstream-ws"}
	conn, _, err := websocket.DefaultDialer.Dial(u.String(), nil)
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()

	subscribeReq := map[string]interface{}{
		"jsonrpc": "2.0",
		"id":      float64(1),
		"method":  "subscribe",
		"params": map[string]interface{}{
			"req": map[string]interface{}{
				"subscription_id": "my-oracle-prices",
				"filter": map[string]interface{}{
					"oracle_price_filter": map[string]interface{}{
						"symbol": []string{"INJ", "USDT"},
					},
				},
			},
		},
	}
	payload, _ := json.Marshal(subscribeReq)
	if err := conn.WriteMessage(websocket.TextMessage, payload); err != nil {
		log.Fatal(err)
	}

	for {
		_, data, err := conn.ReadMessage()
		if err != nil {
			log.Fatal(err)
		}
		var msg map[string]interface{}
		json.Unmarshal(data, &msg)
		log.Printf("%+v", msg)
	}
}
```

## Subscribing to events

Send a JSON-RPC 2.0 request with method `subscribe`. The request must include:

- `jsonrpc`: `"2.0"`
- `id`: A positive integer used to match responses for this subscription
- `method`: `"subscribe"`
- `params.req.subscription_id`: A **client-chosen unique identifier** for this subscription (used later to unsubscribe)
- `params.req.filter`: An object with one or more of the filter types below (same as [Chain Stream](#chain-stream))

At least one filter must be specified. You can combine multiple filters in a single subscription.

> Subscribe to oracle prices:

```javascript
const subscribeRequest = {
  jsonrpc: '2.0',
  id: 1,
  method: 'subscribe',
  params: {
    req: {
      subscription_id: 'my-oracle-prices',
      filter: {
        oracle_price_filter: {
          symbol: ['*']  // Use '*' to subscribe to all symbols
        }
      }
    }
  }
};

ws.send(JSON.stringify(subscribeRequest));
```

> Subscribe to spot orders for a specific market:

```javascript
const subscribeRequest = {
  jsonrpc: '2.0',
  id: 2,
  method: 'subscribe',
  params: {
    req: {
      subscription_id: 'spot-orders-market-1',
      filter: {
        spot_orders_filter: {
          market_ids: ['0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe'],
          subaccount_ids: ['*']
        }
      }
    }
  }
};

ws.send(JSON.stringify(subscribeRequest));
```

> Subscribe to multiple event types:

```javascript
const subscribeRequest = {
  jsonrpc: '2.0',
  id: 3,
  method: 'subscribe',
  params: {
    req: {
      subscription_id: 'my-trading-stream',
      filter: {
        spot_orders_filter: {
          market_ids: ['*'],
          subaccount_ids: ['0xeb8cf88b739fe12e303e31fb88fc37751e17cf3d000000000000000000000000']
        },
        derivative_orders_filter: {
          market_ids: ['*'],
          subaccount_ids: ['0xeb8cf88b739fe12e303e31fb88fc37751e17cf3d000000000000000000000000']
        },
        oracle_price_filter: {
          symbol: ['BTCUSD', 'ETHUSD']
        },
        positions_filter: {
          subaccount_ids: ['0xeb8cf88b739fe12e303e31fb88fc37751e17cf3d000000000000000000000000'],
          market_ids: ['*']
        }
      }
    }
  }
};

ws.send(JSON.stringify(subscribeRequest));
```

> Successful subscription response:

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": "success"
}
```

After a successful subscription, stream updates are sent as JSON-RPC responses with the same `id`. Only fields that match your filters will contain data; others will be empty arrays or omitted.

## Unsubscribing

To stop receiving events for a subscription, send a request with method `unsubscribe` and the same `subscription_id` you used when subscribing:

```javascript
const unsubscribeRequest = {
  jsonrpc: '2.0',
  id: 100,
  method: 'unsubscribe',
  params: {
    req: {
      subscription_id: 'my-oracle-prices'
    }
  }
};

ws.send(JSON.stringify(unsubscribeRequest));
```

> Successful unsubscribe response:

```json
{
  "jsonrpc": "2.0",
  "id": 100,
  "result": "success"
}
```

The `subscription_id` must match exactly the value you provided when creating the subscription. When the WebSocket connection is closed, all its subscriptions are cancelled automatically.

## Subscribe request filter

The `params.req.filter` object uses the same structure as the [Chain Stream](#chain-stream) **Stream Request**: the same filter names (e.g. `bank_balances_filter`, `spot_trades_filter`, `oracle_price_filter`) and the same parameters per filter. You must specify at least one filter. For the full list of filters, their parameters, and wildcard (`"*"`) support, see the [Chain Stream — Stream Request](#chain-stream-stream-request) section.

## Stream response format

Stream updates are delivered as JSON-RPC 2.0 responses. The `result` field is the same as the [Chain Stream](#chain-stream) **StreamResponse**: one message per block, with `block_height`, `block_time`, and arrays for each event type. For the full response shape and the structure of each event type (e.g. `SpotTrade`, `Position`, `OraclePrice`), see the [Chain Stream — StreamResponse](#chain-stream-streamresponse) section.

> Stream message:

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "block_height": "12345678",
    "block_time": "1702123456789",
    "bank_balances": [],
    "subaccount_deposits": [],
    "spot_trades": [],
    "derivative_trades": [],
    "spot_orders": [],
    "derivative_orders": [],
    "spot_orderbook_updates": [],
    "derivative_orderbook_updates": [],
    "positions": [],
    "oracle_prices": [...],
    "gas_price": "160000000",
    "order_failures": [],
    "conditional_order_trigger_failures": []
  }
}
```

## Client behavior

- **Subscription ID:** You choose a unique `subscription_id` per subscription. It must be unique within the same connection. Use it when unsubscribing. After a reconnect, you can re-subscribe with the same IDs to get back the same logical subscriptions.
- **Connection lifecycle:** When the WebSocket connection is closed, all subscriptions for that connection are cancelled. Implement reconnection (e.g. with increasing delay between attempts to avoid hammering the server) and re-send subscribe requests for the streams you need. The stream is live-only: after reconnecting you only receive new events from that point; past events are not replayed.
- **Errors:** The server may send JSON-RPC error responses (e.g. invalid request or subscription already exists). Handle `error` in the JSON-RPC payload and optional ping/pong frames to detect stale connections.
