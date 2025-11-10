# Change Log

## 2025-11-10
- Updated all messages to reflect the changes included in the chain version 1.17.0, and the Indexer for that chain version
- Python SDK v1.12.0
- Go SDK v1.59.0

## 2025-09-24
- Updated all messages to reflect the changes included in the chain version 1.16.4, and the Indexer for that chain version
- Python SDK v1.11.2
- Go SDK v1.58.3

## 2025-07-29
- Updated all messages to reflect the changes included in the chain version 1.16, and the Indexer for that chain version
- Added documentation for `erc20` modules endpoints
- Added documentation for `evm` modules endpoints
- Updated all `exchange` module examples to query the exchange v2 endpoints and send exchange v2 messages
- New GTB orders functionality (Good-Til-Block orders)
- Python SDK v1.11.0
- Go SDK v1.58.0

## 2025-04-21
- Added documentation for `TXFees` modules endpoints
- Updated all messages to reflect the changes included in the chain version 1.15, and the Indexer for that chain version
- Python SDK v1.10.0
- Go SDK v1.57.0

## 2025-02-17
- Changed the `Permissions` module documentation to reflect the new module version (new queries and messages)
- Updated all messages to reflect the changes included in the chain version 1.14, and the Indexer for that chain version
- Python SDK v1.9.0
- Go SDK v1.56.0

## 2024-08-06
- Added support for the following messages in the chain "exchange" module:
  - MsgDecreasePositionMargin
  - MsgUpdateSpotMarket
  - MsgUpdateDerivativeMarket
  - MsgAuthorizeStakeGrants
  - MsgActivateStakeGrantmodule
- Python SDK v1.6.1: add min_notional to all market classes
- Go SDK v1.51.1: add min_notional to all market structs

## 2024-07-30
- Updated requests and responses messages with parameters added in chain upgrade to v1.13
- Updated the API documentation to include all queries and messages for the `tendermint` module
- Updated the API documentation to include all queries and messages for the `IBC transfer` module
- Updated the API documentation to include all queries and messages for the `IBC core channel` module
- Updated the API documentation to include all queries and messages for the `IBC core client` module
- Updated the API documentation to include all queries and messages for the `IBC core connection` module
- Updated the API documentation to include all queries and messages for the `permissions` module
- Python SDK v1.6.0
  - Added support for all queries from the `tendermint` module
  - Added support for all queries from the `IBC transfer` module
  - Added support for all queries from the `IBC core channel` module
  - Added support for all queries from the `IBC core client` module
  - Added support for all queries from the `IBC core connection` module
  - Added support for all queries from the `permissions` module

## 2024-03-08
- Updated the API documentation to include all queries and messages for the `distribution` and `chain exchange` modules
- Python SDK v1.4.0
  - Added support for all queries and messages from the `distribution` module
  - Added support for all queries and messages from the `chain exchange` module

## 2024-01-25
- Python SDK v1.2.0
  - Improved message based gas estimator to consider that Post Only orders creation require more gas than normal orders

## 2024-01-02
- Python SDK v1.0 and Go SDK v1.49
  - Added logic to support use of Client Order ID (CID) new identifier in OrderInfo
  - New chain stream support
  - Remove support for `sentry` nodes in mainnet network. The only supported node option in mainnet is `lb`
  - Migrated all proto objects dependency to support chain version 1.12
  - Added logic to cover all bank module queries
  - Added logic in Python SDK to support the initialization of tokens with all the tokens from the chain (DenomsMetadata)
  - Added logic in Go SDK to allow the initialization of markets and tokens from the chain (without using the local .ini files). Also included functionality to initialize the tokens wilh all the tokens from the chain (DenomsMetadata)
  - Added support for wasm, tokenfactory and wasmx modules, including example script for all their endpoints

## 2023-09-06
- Python SDK v0.8 release
    - Network class was moved from `pyinjective.constant` to `pyinjective.core.network`
    - Configuration to use secure or insecure channels has been moved into the Network class
    - The Composer can be created now by the AsyncClient, taking markets and tokens from the chain information instead of using the local configuration files
    - Changed the cookies management logic. All cookies management is done now by Network

## 2023-08-28
- Added IP rate limits documentation