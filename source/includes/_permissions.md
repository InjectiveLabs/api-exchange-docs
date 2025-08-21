# - Permissions

Permissions module provides an extra layer of configuration for all actions related to tokens: mint, transfer and burn.


## NamespaceDenoms

Defines a gRPC query method that returns the denoms for which a namespace exists

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/1_NamespaceDenoms.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/1_NamespaceDenoms.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    namespaces = await client.fetch_permissions_namespace_denoms()
    print(namespaces)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/1_NamespaceDenoms/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/1_NamespaceDenoms/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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

	res, err := chainClient.FetchPermissionsNamespaceDenoms(ctx)
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
  "denoms": [
    "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/reR"
  ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryNamespaceDenomsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denoms</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of denoms</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Namespaces

Defines a gRPC query method that returns the permissions module's created namespaces

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/2_Namespaces.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/2_Namespaces.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    namespaces = await client.fetch_permissions_namespaces()
    print(namespaces)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/2_Namespaces/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/2_Namespaces/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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

	res, err := chainClient.FetchPermissionsNamespaces(ctx)
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
 "namespaces": [
  {
   "denom": "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/reR",
   "role_permissions": [
    {
     "name": "EVERYONE",
     "permissions": 8
    },
    {
     "name": "Admin",
     "role_id": 1,
     "permissions": 2013265951
    },
    {
     "name": "Minter",
     "role_id": 2,
     "permissions": 3
    },
    {
     "name": "OtherMinter",
     "role_id": 3,
     "permissions": 1
    },
    {
     "name": "Receiver",
     "role_id": 4,
     "permissions": 2
    },
    {
     "name": "SenderAndReceiver",
     "role_id": 5,
     "permissions": 10
    },
    {
     "name": "Burner",
     "role_id": 6,
     "permissions": 4
    },
    {
     "name": "SuperBurner",
     "role_id": 7,
     "permissions": 16
    },
    {
     "name": "ModifyPolicyManagers",
     "role_id": 8,
     "permissions": 134217728
    },
    {
     "name": "ModifyContractHook",
     "role_id": 9,
     "permissions": 268435456
    },
    {
     "name": "ModifyRoleManagers",
     "role_id": 10,
     "permissions": 1073741824
    },
    {
     "name": "ModifyRolePermission",
     "role_id": 11,
     "permissions": 536870912
    },
    {
     "name": "TestToModify",
     "role_id": 12,
     "permissions": 5
    },
    {
     "name": "TestToModify2",
     "role_id": 13,
     "permissions": 7
    },
    {
     "name": "TestToModify3",
     "role_id": 14,
     "permissions": 15
    },
    {
     "name": "Blacklisted",
     "role_id": 15
    }
   ],
   "actor_roles": [
    {
     "actor": "inj1q82aa323r2vxha9mvsz5nvhc0h6unh2duk48gc",
     "roles": [
      "ModifyRolePermission"
     ]
    },
    {
     "actor": "inj1yv7jzmzcxusrvnaj86mjg59x4nc05wtz93tyhv",
     "roles": [
      "SenderAndReceiver"
     ]
    },
    {
     "actor": "inj1y5vuaw7qvltxp6vmynaf74d0gfgduk3c494x0q",
     "roles": [
      "ModifyPolicyManagers"
     ]
    },
    {
     "actor": "inj188dcnc89c5lvxvhxegju722jsnz3huls6sdw3r",
     "roles": [
      "TestToModify2",
      "OtherMinter"
     ]
    },
    {
     "actor": "inj1gxx3mkvrymyw5u7mdrnzjl6q8vcgvj85kfghkg",
     "roles": [
      "TestToModify"
     ]
    },
    {
     "actor": "inj1g5xj7flevr9nqn068wtenhjtlagpm3kd7hgq2x",
     "roles": [
      "Receiver"
     ]
    },
    {
     "actor": "inj12maj7ndrm0ytumcffd4hrl7jk05du69axnjndz",
     "roles": [
      "Burner",
      "Receiver"
     ]
    },
    {
     "actor": "inj1dku85qn8cs2648trk74kluck286sphrvhrfpfe",
     "roles": [
      "ModifyContractHook"
     ]
    },
    {
     "actor": "inj10zyguxjt3m0yfq4ae5s6flvudyqaev2p2nxzv7",
     "roles": [
      "SuperBurner",
      "Receiver"
     ]
    },
    {
     "actor": "inj1sn9yc5e27sd9c6334ufresn9356narlz0s9vdq",
     "roles": [
      "Receiver"
     ]
    },
    {
     "actor": "inj14enjvrdza0m495q77nk6cnl3c9r0u06wsugkdc",
     "roles": [
      "Receiver"
     ]
    },
    {
     "actor": "inj1kuhunpk695kn93twqhfvamg4tx2lcjafpmgx5s",
     "roles": [
      "TestToModify3"
     ]
    },
    {
     "actor": "inj1cr2jzsgmw4tf4t82nk7hskxpcsvd9c84nyy5rg",
     "roles": [
      "SenderAndReceiver"
     ]
    },
    {
     "actor": "inj16jtcqsyng98wk7fu87wpzgyx59ghle980cjrp8",
     "roles": [
      "Blacklisted"
     ]
    },
    {
     "actor": "inj16nj2c4j2e7scq8r5xkkgdjmwhpv7mw0trtjapf",
     "roles": [
      "SenderAndReceiver"
     ]
    },
    {
     "actor": "inj1mhgedl8exqca4mnmmh0r3tsgxcvz8kgj2tjukf",
     "roles": [
      "OtherMinter"
     ]
    },
    {
     "actor": "inj1az9uh3ytwcgjyy9akspdtaerfqca7jswfupgd7",
     "roles": [
      "ModifyRoleManagers"
     ]
    },
    {
     "actor": "inj1a0cl5hagkcncjsylsqryk8rze9m56gda60f68s",
     "roles": [
      "Blacklisted"
     ]
    },
    {
     "actor": "inj1aj6yxg97ynvyewdyf76q47yn49f6t622ftmud6",
     "roles": [
      "Minter"
     ]
    },
    {
     "actor": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "roles": [
      "Admin"
     ]
    }
   ],
   "role_managers": [
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "roles": [
      "EVERYONE",
      "Admin",
      "Minter",
      "OtherMinter",
      "Receiver",
      "SenderAndReceiver",
      "Burner",
      "SuperBurner",
      "ModifyPolicyManagers",
      "ModifyContractHook",
      "ModifyRoleManagers",
      "ModifyRolePermission",
      "TestToModify",
      "TestToModify2",
      "TestToModify3",
      "Blacklisted"
     ]
    }
   ],
   "policy_statuses": [
    {
     "action": 134217728
    },
    {
     "action": 268435456
    },
    {
     "action": 536870912
    },
    {
     "action": 1073741824
    },
    {
     "action": 1
    },
    {
     "action": 2
    },
    {
     "action": 4
    },
    {
     "action": 8
    },
    {
     "action": 16
    }
   ],
   "policy_manager_capabilities": [
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 134217728,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 268435456,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 536870912,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 1073741824,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 1,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 2,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 4,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 8,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 16,
     "can_disable": true,
     "can_seal": true
    }
   ]
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryNamespacesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">namespaces</td><td class="type-td td_text">Namespace array</td><td class="description-td td_text">List of namespaces</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Namespace**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/Namespace.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The tokenfactory denom to which this namespace applies to</td></tr>
<tr ><td class="parameter-td td_text">contract_hook</td><td class="type-td td_text">string</td><td class="description-td td_text">The address of smart contract to apply code-based restrictions</td></tr>
<tr ><td class="parameter-td td_text">role_permissions</td><td class="type-td td_text">Role array</td><td class="description-td td_text">permissions for each role</td></tr>
<tr ><td class="parameter-td td_text">actor_roles</td><td class="type-td td_text">ActorRoles array</td><td class="description-td td_text">roles for each actor</td></tr>
<tr ><td class="parameter-td td_text">role_managers</td><td class="type-td td_text">RoleManager array</td><td class="description-td td_text">managers for each role</td></tr>
<tr ><td class="parameter-td td_text">policy_statuses</td><td class="type-td td_text">PolicyStatus array</td><td class="description-td td_text">status for each policy</td></tr>
<tr ><td class="parameter-td td_text">policy_manager_capabilities</td><td class="type-td td_text">PolicyManagerCapability array</td><td class="description-td td_text">capabilities for each manager for each policy</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Role**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/Role.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">name</td><td class="type-td td_text">string</td><td class="description-td td_text">The role name</td></tr>
<tr ><td class="parameter-td td_text">role_id</td><td class="type-td td_text">uint32</td><td class="description-td td_text">The role ID</td></tr>
<tr ><td class="parameter-td td_text">permissions</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Integer representing the bitwise combination of all actions assigned to the role</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ActorRoles**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/ActorRoles.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">actor</td><td class="type-td td_text">string</td><td class="description-td td_text">The actor name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">The roles for the actor</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/RoleManager.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of roles associated with the manager</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">is_disabled</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is disabled</td></tr>
<tr ><td class="parameter-td td_text">is_sealed</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is sealed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyManagerCapability.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">can_disable</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can disable the policy</td></tr>
<tr ><td class="parameter-td td_text">can_seal</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can seal the policy</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Action**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/v1beta1/Action.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">MINT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">RECEIVE</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">BURN</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SEND</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">SUPER_BURN</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_POLICY_MANAGERS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_CONTRACT_HOOK</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_PERMISSIONS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_MANAGERS</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Namespace

Defines a gRPC query method that returns the permissions module's namespace associated with the provided denom

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/3_Namespace.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/3_Namespace.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    denom = "inj"
    namespace = await client.fetch_permissions_namespace(denom=denom)
    print(namespace)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/3_Namespace/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/3_Namespace/example.go -->
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
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	namespaceDenom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"

	ctx := context.Background()

	res, err := chainClient.FetchPermissionsNamespace(ctx, namespaceDenom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryNamespaceRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "namespace": {
  "denom": "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/reR",
  "role_permissions": [
   {
    "name": "EVERYONE",
    "permissions": 8
   },
   {
    "name": "Admin",
    "role_id": 1,
    "permissions": 2013265951
   },
   {
    "name": "Minter",
    "role_id": 2,
    "permissions": 3
   },
   {
    "name": "OtherMinter",
    "role_id": 3,
    "permissions": 1
   },
   {
    "name": "Receiver",
    "role_id": 4,
    "permissions": 2
   },
   {
    "name": "SenderAndReceiver",
    "role_id": 5,
    "permissions": 10
   },
   {
    "name": "Burner",
    "role_id": 6,
    "permissions": 4
   },
   {
    "name": "SuperBurner",
    "role_id": 7,
    "permissions": 16
   },
   {
    "name": "ModifyPolicyManagers",
    "role_id": 8,
    "permissions": 134217728
   },
   {
    "name": "ModifyContractHook",
    "role_id": 9,
    "permissions": 268435456
   },
   {
    "name": "ModifyRoleManagers",
    "role_id": 10,
    "permissions": 1073741824
   },
   {
    "name": "ModifyRolePermission",
    "role_id": 11,
    "permissions": 536870912
   },
   {
    "name": "TestToModify",
    "role_id": 12,
    "permissions": 5
   },
   {
    "name": "TestToModify2",
    "role_id": 13,
    "permissions": 7
   },
   {
    "name": "TestToModify3",
    "role_id": 14,
    "permissions": 15
   },
   {
    "name": "Blacklisted",
    "role_id": 15
   }
  ],
  "actor_roles": [
   {
    "actor": "inj1q82aa323r2vxha9mvsz5nvhc0h6unh2duk48gc",
    "roles": [
     "ModifyRolePermission"
    ]
   },
   {
    "actor": "inj1yv7jzmzcxusrvnaj86mjg59x4nc05wtz93tyhv",
    "roles": [
     "SenderAndReceiver"
    ]
   },
   {
    "actor": "inj1y5vuaw7qvltxp6vmynaf74d0gfgduk3c494x0q",
    "roles": [
     "ModifyPolicyManagers"
    ]
   },
   {
    "actor": "inj188dcnc89c5lvxvhxegju722jsnz3huls6sdw3r",
    "roles": [
     "TestToModify2",
     "OtherMinter"
    ]
   },
   {
    "actor": "inj1gxx3mkvrymyw5u7mdrnzjl6q8vcgvj85kfghkg",
    "roles": [
     "TestToModify"
    ]
   },
   {
    "actor": "inj1g5xj7flevr9nqn068wtenhjtlagpm3kd7hgq2x",
    "roles": [
     "Receiver"
    ]
   },
   {
    "actor": "inj12maj7ndrm0ytumcffd4hrl7jk05du69axnjndz",
    "roles": [
     "Burner",
     "Receiver"
    ]
   },
   {
    "actor": "inj1dku85qn8cs2648trk74kluck286sphrvhrfpfe",
    "roles": [
     "ModifyContractHook"
    ]
   },
   {
    "actor": "inj10zyguxjt3m0yfq4ae5s6flvudyqaev2p2nxzv7",
    "roles": [
     "SuperBurner",
     "Receiver"
    ]
   },
   {
    "actor": "inj1sn9yc5e27sd9c6334ufresn9356narlz0s9vdq",
    "roles": [
     "Receiver"
    ]
   },
   {
    "actor": "inj14enjvrdza0m495q77nk6cnl3c9r0u06wsugkdc",
    "roles": [
     "Receiver"
    ]
   },
   {
    "actor": "inj1kuhunpk695kn93twqhfvamg4tx2lcjafpmgx5s",
    "roles": [
     "TestToModify3"
    ]
   },
   {
    "actor": "inj1cr2jzsgmw4tf4t82nk7hskxpcsvd9c84nyy5rg",
    "roles": [
     "SenderAndReceiver"
    ]
   },
   {
    "actor": "inj16jtcqsyng98wk7fu87wpzgyx59ghle980cjrp8",
    "roles": [
     "Blacklisted"
    ]
   },
   {
    "actor": "inj16nj2c4j2e7scq8r5xkkgdjmwhpv7mw0trtjapf",
    "roles": [
     "SenderAndReceiver"
    ]
   },
   {
    "actor": "inj1mhgedl8exqca4mnmmh0r3tsgxcvz8kgj2tjukf",
    "roles": [
     "OtherMinter"
    ]
   },
   {
    "actor": "inj1az9uh3ytwcgjyy9akspdtaerfqca7jswfupgd7",
    "roles": [
     "ModifyRoleManagers"
    ]
   },
   {
    "actor": "inj1a0cl5hagkcncjsylsqryk8rze9m56gda60f68s",
    "roles": [
     "Blacklisted"
    ]
   },
   {
    "actor": "inj1aj6yxg97ynvyewdyf76q47yn49f6t622ftmud6",
    "roles": [
     "Minter"
    ]
   },
   {
    "actor": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "roles": [
     "Admin"
    ]
   }
  ],
  "role_managers": [
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "roles": [
     "EVERYONE",
     "Admin",
     "Minter",
     "OtherMinter",
     "Receiver",
     "SenderAndReceiver",
     "Burner",
     "SuperBurner",
     "ModifyPolicyManagers",
     "ModifyContractHook",
     "ModifyRoleManagers",
     "ModifyRolePermission",
     "TestToModify",
     "TestToModify2",
     "TestToModify3",
     "Blacklisted"
    ]
   }
  ],
  "policy_statuses": [
   {
    "action": 134217728
   },
   {
    "action": 268435456
   },
   {
    "action": 536870912
   },
   {
    "action": 1073741824
   },
   {
    "action": 1
   },
   {
    "action": 2
   },
   {
    "action": 4
   },
   {
    "action": 8
   },
   {
    "action": 16
   }
  ],
  "policy_manager_capabilities": [
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 134217728,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 268435456,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 536870912,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 1073741824,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 1,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 2,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 4,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 8,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 16,
    "can_disable": true,
    "can_seal": true
   }
  ]
 }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryNamespaceResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">namespace</td><td class="type-td td_text">Namespace</td><td class="description-td td_text">The namespace details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Namespace**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/Namespace.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The tokenfactory denom to which this namespace applies to</td></tr>
<tr ><td class="parameter-td td_text">contract_hook</td><td class="type-td td_text">string</td><td class="description-td td_text">The address of smart contract to apply code-based restrictions</td></tr>
<tr ><td class="parameter-td td_text">role_permissions</td><td class="type-td td_text">Role array</td><td class="description-td td_text">permissions for each role</td></tr>
<tr ><td class="parameter-td td_text">actor_roles</td><td class="type-td td_text">ActorRoles array</td><td class="description-td td_text">roles for each actor</td></tr>
<tr ><td class="parameter-td td_text">role_managers</td><td class="type-td td_text">RoleManager array</td><td class="description-td td_text">managers for each role</td></tr>
<tr ><td class="parameter-td td_text">policy_statuses</td><td class="type-td td_text">PolicyStatus array</td><td class="description-td td_text">status for each policy</td></tr>
<tr ><td class="parameter-td td_text">policy_manager_capabilities</td><td class="type-td td_text">PolicyManagerCapability array</td><td class="description-td td_text">capabilities for each manager for each policy</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Role**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/Role.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">name</td><td class="type-td td_text">string</td><td class="description-td td_text">The role name</td></tr>
<tr ><td class="parameter-td td_text">role_id</td><td class="type-td td_text">uint32</td><td class="description-td td_text">The role ID</td></tr>
<tr ><td class="parameter-td td_text">permissions</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Integer representing the bitwise combination of all actions assigned to the role</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ActorRoles**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/ActorRoles.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">actor</td><td class="type-td td_text">string</td><td class="description-td td_text">The actor name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">The roles for the actor</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/RoleManager.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of roles associated with the manager</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">is_disabled</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is disabled</td></tr>
<tr ><td class="parameter-td td_text">is_sealed</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is sealed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyManagerCapability.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">can_disable</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can disable the policy</td></tr>
<tr ><td class="parameter-td td_text">can_seal</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can seal the policy</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Action**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/v1beta1/Action.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">MINT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">RECEIVE</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">BURN</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SEND</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">SUPER_BURN</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_POLICY_MANAGERS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_CONTRACT_HOOK</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_PERMISSIONS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_MANAGERS</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## RolesByActor

Defines a gRPC query method that returns roles for the actor in the namespace

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/4_RolesByActor.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/4_RolesByActor.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    denom = "inj"
    actor = "actor"
    roles = await client.fetch_permissions_roles_by_actor(denom=denom, actor=actor)
    print(roles)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/4_RolesByActor/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/4_RolesByActor/example.go -->
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
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	namespaceDenom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"
	actor := senderAddress.String()

	ctx := context.Background()

	res, err := chainClient.FetchPermissionsRolesByActor(ctx, namespaceDenom, actor)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryRolesByActorRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">actor</td><td class="type-td td_text">string</td><td class="description-td td_text">The actor's Injective address</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "roles": [
  "ModifyRolePermission"
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryRolesByActorResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of roles</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## ActorsByRole

Defines a gRPC query method that returns a namespace's roles associated with the provided actor

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/5_ActorsByRole.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/5_ActorsByRole.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    denom = "inj"
    role = "roleName"
    addresses = await client.fetch_permissions_actors_by_role(denom=denom, role=role)
    print(addresses)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/5_ActorsByRole/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/5_ActorsByRole/example.go -->
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
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	namespaceDenom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"
	role := "blacklisted"

	ctx := context.Background()

	res, err := chainClient.FetchPermissionsActorsByRole(ctx, namespaceDenom, role)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryActorsByRoleRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">role</td><td class="type-td td_text">string</td><td class="description-td td_text">The role to query actors for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "actors": [
  "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z"
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryActorsByRoleResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">actors</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of actors' Injective addresses</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## RoleManagers

Defines a gRPC query method that returns a namespace's role managers

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/6_RoleManagers.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/6_RoleManagers.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    denom = "inj"
    managers = await client.fetch_permissions_role_managers(denom=denom)
    print(managers)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/6_RoleManagers/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/6_RoleManagers/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"

	res, err := chainClient.FetchPermissionsRoleManagers(ctx, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryRoleManagersRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "role_managers": [
  {
   "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
   "roles": [
    "EVERYONE",
    "Admin",
    "Minter",
    "OtherMinter",
    "Receiver",
    "SenderAndReceiver",
    "Burner",
    "SuperBurner",
    "ModifyPolicyManagers",
    "ModifyContractHook",
    "ModifyRoleManagers",
    "ModifyRolePermission",
    "TestToModify",
    "TestToModify2",
    "TestToModify3",
    "Blacklisted"
   ]
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryRoleManagersResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">role_managers</td><td class="type-td td_text">RoleManager array</td><td class="description-td td_text">List of role managers</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/RoleManager.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of roles associated with the manager</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## RoleManager

Defines a gRPC query method that returns the roles a given role manager manages for a given namespace

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/7_RoleManager.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/7_RoleManager.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    denom = "inj"
    manager = "manager"
    managers = await client.fetch_permissions_role_manager(denom=denom, manager=manager)
    print(managers)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/7_RoleManager/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/7_RoleManager/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"
	manager := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

	res, err := chainClient.FetchPermissionsRoleManager(ctx, denom, manager)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryRoleManagerRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager Injective address</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "role_manager": {
  "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
  "roles": [
   "EVERYONE",
   "Admin",
   "Minter",
   "OtherMinter",
   "Receiver",
   "SenderAndReceiver",
   "Burner",
   "SuperBurner",
   "ModifyPolicyManagers",
   "ModifyContractHook",
   "ModifyRoleManagers",
   "ModifyRolePermission",
   "TestToModify",
   "TestToModify2",
   "TestToModify3",
   "Blacklisted"
  ]
 }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryRoleManagerResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">role_manager</td><td class="type-td td_text">RoleManager</td><td class="description-td td_text">The role manager details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/RoleManager.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of roles associated with the manager</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PolicyStatuses

Defines a gRPC query method that returns a namespace's policy statuses

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/8_PolicyStatuses.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/8_PolicyStatuses.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    denom = "inj"
    policy_statuses = await client.fetch_permissions_policy_statuses(denom=denom)
    print(policy_statuses)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/8_PolicyStatuses/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/8_PolicyStatuses/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"

	res, err := chainClient.FetchPermissionsPolicyStatuses(ctx, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryPolicyStatusesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "policy_statuses": [
  {
   "action": 134217728
  },
  {
   "action": 268435456
  },
  {
   "action": 536870912
  },
  {
   "action": 1073741824
  },
  {
   "action": 1
  },
  {
   "action": 2
  },
  {
   "action": 4
  },
  {
   "action": 8
  },
  {
   "action": 16
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryPolicyStatusesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">policy_statuses</td><td class="type-td td_text">PolicyStatus array</td><td class="description-td td_text">List of policy statuses</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">is_disabled</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is disabled</td></tr>
<tr ><td class="parameter-td td_text">is_sealed</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is sealed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Action**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/v1beta1/Action.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">MINT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">RECEIVE</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">BURN</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SEND</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">SUPER_BURN</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_POLICY_MANAGERS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_CONTRACT_HOOK</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_PERMISSIONS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_MANAGERS</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PolicyManagerCapabilities

Defines a gRPC query method that returns a namespace's policy manager capabilities

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/9_PolicyManagerCapabilities.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/9_PolicyManagerCapabilities.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    denom = "inj"
    policy_manager_capabilities = await client.fetch_permissions_policy_manager_capabilities(denom=denom)
    print(policy_manager_capabilities)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/9_PolicyManagerCapabilities/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/9_PolicyManagerCapabilities/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"

	res, err := chainClient.FetchPermissionsPolicyStatuses(ctx, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryPolicyManagerCapabilitiesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "policy_statuses": [
  {
   "action": 134217728
  },
  {
   "action": 268435456
  },
  {
   "action": 536870912
  },
  {
   "action": 1073741824
  },
  {
   "action": 1
  },
  {
   "action": 2
  },
  {
   "action": 4
  },
  {
   "action": 8
  },
  {
   "action": 16
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryPolicyManagerCapabilitiesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">policy_manager_capabilities</td><td class="type-td td_text">PolicyManagerCapability array</td><td class="description-td td_text">List of policy manager capabilities</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyManagerCapability.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">can_disable</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can disable the policy</td></tr>
<tr ><td class="parameter-td td_text">can_seal</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can seal the policy</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Action**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/v1beta1/Action.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">MINT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">RECEIVE</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">BURN</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SEND</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">SUPER_BURN</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_POLICY_MANAGERS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_CONTRACT_HOOK</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_PERMISSIONS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_MANAGERS</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Vouchers

Defines a gRPC query method for the vouchers for a given denom

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/10_Vouchers.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/10_Vouchers.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    denom = "inj"
    vouchers = await client.fetch_permissions_vouchers(denom=denom)
    print(vouchers)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/10_Vouchers/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/10_Vouchers/example.go -->
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
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"

	res, err := chainClient.FetchPermissionsVouchers(ctx, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryVouchersRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryVouchersResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">vouchers</td><td class="type-td td_text">AddressVoucher array</td><td class="description-td td_text">List of vouchers</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AddressVoucher**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/AddressVoucher.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">address</td><td class="type-td td_text">string</td><td class="description-td td_text">The Injective address that the voucher is for</td></tr>
<tr ><td class="parameter-td td_text">voucher</td><td class="type-td td_text">github_com_cosmos_cosmos_sdk_types.Coin</td><td class="description-td td_text">The voucher amount</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/Coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">cosmossdk_io_math.Int</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Voucher

Defines a gRPC query method for the vouchers for a given denom and address

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/11_Voucher.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/11_Voucher.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    denom = "inj"
    address = "inj1knhahceyp57j5x7xh69p7utegnnnfgxavmahjr"
    voucher = await client.fetch_permissions_voucher(denom=denom, address=address)
    print(voucher)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/11_Voucher/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/11_Voucher/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"
	address := "inj1knhahceyp57j5x7xh69p7utegnnnfgxavmahjr"

	res, err := chainClient.FetchPermissionsVoucher(ctx, denom, address)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", "\t")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryVoucherRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">address</td><td class="type-td td_text">string</td><td class="description-td td_text">The Injective address of the receiver</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryVoucherResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">voucher</td><td class="type-td td_text">github_com_cosmos_cosmos_sdk_types.Coin</td><td class="description-td td_text">The voucher amount</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/Coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">cosmossdk_io_math.Int</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PermissionsModuleState

Retrieves the entire permissions module's state

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/query/12_PermissionsModuleState.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/query/12_PermissionsModuleState.py -->
```py
import asyncio

from pyinjective.async_client_v2 import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    state = await client.fetch_permissions_module_state()
    print(state)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/query/12_PermissionsModuleState/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/query/12_PermissionsModuleState/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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

	res, err := chainClient.FetchPermissionsModuleState(ctx)
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
 "state": {
  "params": {
   "wasm_hook_query_max_gas": 200000
  },
  "namespaces": [
   {
    "denom": "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/reR",
    "role_permissions": [
     {
      "name": "EVERYONE",
      "permissions": 8
     },
     {
      "name": "Admin",
      "role_id": 1,
      "permissions": 2013265951
     },
     {
      "name": "Minter",
      "role_id": 2,
      "permissions": 3
     },
     {
      "name": "OtherMinter",
      "role_id": 3,
      "permissions": 1
     },
     {
      "name": "Receiver",
      "role_id": 4,
      "permissions": 2
     },
     {
      "name": "SenderAndReceiver",
      "role_id": 5,
      "permissions": 10
     },
     {
      "name": "Burner",
      "role_id": 6,
      "permissions": 4
     },
     {
      "name": "SuperBurner",
      "role_id": 7,
      "permissions": 16
     },
     {
      "name": "ModifyPolicyManagers",
      "role_id": 8,
      "permissions": 134217728
     },
     {
      "name": "ModifyContractHook",
      "role_id": 9,
      "permissions": 268435456
     },
     {
      "name": "ModifyRoleManagers",
      "role_id": 10,
      "permissions": 1073741824
     },
     {
      "name": "ModifyRolePermission",
      "role_id": 11,
      "permissions": 536870912
     },
     {
      "name": "TestToModify",
      "role_id": 12,
      "permissions": 5
     },
     {
      "name": "TestToModify2",
      "role_id": 13,
      "permissions": 7
     },
     {
      "name": "TestToModify3",
      "role_id": 14,
      "permissions": 15
     },
     {
      "name": "Blacklisted",
      "role_id": 15
     }
    ],
    "actor_roles": [
     {
      "actor": "inj1q82aa323r2vxha9mvsz5nvhc0h6unh2duk48gc",
      "roles": [
       "ModifyRolePermission"
      ]
     },
     {
      "actor": "inj1yv7jzmzcxusrvnaj86mjg59x4nc05wtz93tyhv",
      "roles": [
       "SenderAndReceiver"
      ]
     },
     {
      "actor": "inj1y5vuaw7qvltxp6vmynaf74d0gfgduk3c494x0q",
      "roles": [
       "ModifyPolicyManagers"
      ]
     },
     {
      "actor": "inj188dcnc89c5lvxvhxegju722jsnz3huls6sdw3r",
      "roles": [
       "TestToModify2",
       "OtherMinter"
      ]
     },
     {
      "actor": "inj1gxx3mkvrymyw5u7mdrnzjl6q8vcgvj85kfghkg",
      "roles": [
       "TestToModify"
      ]
     },
     {
      "actor": "inj1g5xj7flevr9nqn068wtenhjtlagpm3kd7hgq2x",
      "roles": [
       "Receiver"
      ]
     },
     {
      "actor": "inj12maj7ndrm0ytumcffd4hrl7jk05du69axnjndz",
      "roles": [
       "Burner",
       "Receiver"
      ]
     },
     {
      "actor": "inj1dku85qn8cs2648trk74kluck286sphrvhrfpfe",
      "roles": [
       "ModifyContractHook"
      ]
     },
     {
      "actor": "inj10zyguxjt3m0yfq4ae5s6flvudyqaev2p2nxzv7",
      "roles": [
       "SuperBurner",
       "Receiver"
      ]
     },
     {
      "actor": "inj1sn9yc5e27sd9c6334ufresn9356narlz0s9vdq",
      "roles": [
       "Receiver"
      ]
     },
     {
      "actor": "inj14enjvrdza0m495q77nk6cnl3c9r0u06wsugkdc",
      "roles": [
       "Receiver"
      ]
     },
     {
      "actor": "inj1kuhunpk695kn93twqhfvamg4tx2lcjafpmgx5s",
      "roles": [
       "TestToModify3"
      ]
     },
     {
      "actor": "inj1cr2jzsgmw4tf4t82nk7hskxpcsvd9c84nyy5rg",
      "roles": [
       "SenderAndReceiver"
      ]
     },
     {
      "actor": "inj16jtcqsyng98wk7fu87wpzgyx59ghle980cjrp8",
      "roles": [
       "Blacklisted"
      ]
     },
     {
      "actor": "inj16nj2c4j2e7scq8r5xkkgdjmwhpv7mw0trtjapf",
      "roles": [
       "SenderAndReceiver"
      ]
     },
     {
      "actor": "inj1mhgedl8exqca4mnmmh0r3tsgxcvz8kgj2tjukf",
      "roles": [
       "OtherMinter"
      ]
     },
     {
      "actor": "inj1az9uh3ytwcgjyy9akspdtaerfqca7jswfupgd7",
      "roles": [
       "ModifyRoleManagers"
      ]
     },
     {
      "actor": "inj1a0cl5hagkcncjsylsqryk8rze9m56gda60f68s",
      "roles": [
       "Blacklisted"
      ]
     },
     {
      "actor": "inj1aj6yxg97ynvyewdyf76q47yn49f6t622ftmud6",
      "roles": [
       "Minter"
      ]
     },
     {
      "actor": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "roles": [
       "Admin"
      ]
     }
    ],
    "role_managers": [
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "roles": [
       "EVERYONE",
       "Admin",
       "Minter",
       "OtherMinter",
       "Receiver",
       "SenderAndReceiver",
       "Burner",
       "SuperBurner",
       "ModifyPolicyManagers",
       "ModifyContractHook",
       "ModifyRoleManagers",
       "ModifyRolePermission",
       "TestToModify",
       "TestToModify2",
       "TestToModify3",
       "Blacklisted"
      ]
     }
    ],
    "policy_statuses": [
     {
      "action": 134217728
     },
     {
      "action": 268435456
     },
     {
      "action": 536870912
     },
     {
      "action": 1073741824
     },
     {
      "action": 1
     },
     {
      "action": 2
     },
     {
      "action": 4
     },
     {
      "action": 8
     },
     {
      "action": 16
     }
    ],
    "policy_manager_capabilities": [
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 134217728,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 268435456,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 536870912,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 1073741824,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 1,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 2,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 4,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 8,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 16,
      "can_disable": true,
      "can_seal": true
     }
    ]
   }
  ]
 }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/QueryModuleStateResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">GenesisState</td><td class="description-td td_text">The module state</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**GenesisState**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/GenesisState.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">params</td><td class="type-td td_text">Params</td><td class="description-td td_text">params defines the parameters of the module</td></tr>
<tr ><td class="parameter-td td_text">namespaces</td><td class="type-td td_text">Namespace array</td><td class="description-td td_text">namespaces defines the namespaces of the module</td></tr>
<tr ><td class="parameter-td td_text">vouchers</td><td class="type-td td_text">AddressVoucher array</td><td class="description-td td_text">vouchers defines the vouchers of the module</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Params**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/Params.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">wasm_hook_query_max_gas</td><td class="type-td td_text">uint64</td><td class="description-td td_text">Max amount of gas allowed for wasm hook queries</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Namespace**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/Namespace.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The tokenfactory denom to which this namespace applies to</td></tr>
<tr ><td class="parameter-td td_text">contract_hook</td><td class="type-td td_text">string</td><td class="description-td td_text">The address of smart contract to apply code-based restrictions</td></tr>
<tr ><td class="parameter-td td_text">role_permissions</td><td class="type-td td_text">Role array</td><td class="description-td td_text">permissions for each role</td></tr>
<tr ><td class="parameter-td td_text">actor_roles</td><td class="type-td td_text">ActorRoles array</td><td class="description-td td_text">roles for each actor</td></tr>
<tr ><td class="parameter-td td_text">role_managers</td><td class="type-td td_text">RoleManager array</td><td class="description-td td_text">managers for each role</td></tr>
<tr ><td class="parameter-td td_text">policy_statuses</td><td class="type-td td_text">PolicyStatus array</td><td class="description-td td_text">status for each policy</td></tr>
<tr ><td class="parameter-td td_text">policy_manager_capabilities</td><td class="type-td td_text">PolicyManagerCapability array</td><td class="description-td td_text">capabilities for each manager for each policy</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AddressVoucher**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/AddressVoucher.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">address</td><td class="type-td td_text">string</td><td class="description-td td_text">The Injective address that the voucher is for</td></tr>
<tr ><td class="parameter-td td_text">voucher</td><td class="type-td td_text">github_com_cosmos_cosmos_sdk_types.Coin</td><td class="description-td td_text">The voucher amount</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Role**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/Role.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">name</td><td class="type-td td_text">string</td><td class="description-td td_text">The role name</td></tr>
<tr ><td class="parameter-td td_text">role_id</td><td class="type-td td_text">uint32</td><td class="description-td td_text">The role ID</td></tr>
<tr ><td class="parameter-td td_text">permissions</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Integer representing the bitwise combination of all actions assigned to the role</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ActorRoles**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/ActorRoles.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">actor</td><td class="type-td td_text">string</td><td class="description-td td_text">The actor name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">The roles for the actor</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/RoleManager.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of roles associated with the manager</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">is_disabled</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is disabled</td></tr>
<tr ><td class="parameter-td td_text">is_sealed</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is sealed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyManagerCapability.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">can_disable</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can disable the policy</td></tr>
<tr ><td class="parameter-td td_text">can_seal</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can seal the policy</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Action**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/v1beta1/Action.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">MINT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">RECEIVE</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">BURN</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SEND</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">SUPER_BURN</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_POLICY_MANAGERS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_CONTRACT_HOOK</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_PERMISSIONS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_MANAGERS</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/cosmos/Coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">cosmossdk_io_math.Int</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## CreateNamespace

Message to create a new namespace

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/1_MsgCreateNamespace.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/1_MsgCreateNamespace.py -->
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
    network = Network.devnet()
    client = AsyncClient(network)
    composer = await client.composer()

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=private_key_in_hexa,
        gas_price=gas_price,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    denom = "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"
    role1 = composer.permissions_role(
        name="EVERYONE",
        role_id=0,
        permissions=composer.PERMISSIONS_ACTION["RECEIVE"] | composer.PERMISSIONS_ACTION["SEND"],
    )
    role2 = composer.permissions_role(
        name="admin",
        role_id=1,
        permissions=composer.PERMISSIONS_ACTION["MODIFY_ROLE_PERMISSIONS"]
        | composer.PERMISSIONS_ACTION["MODIFY_ADDRESS_ROLES"],
    )
    role3 = composer.permissions_role(
        name="user",
        role_id=2,
        permissions=composer.PERMISSIONS_ACTION["MINT"]
        | composer.PERMISSIONS_ACTION["RECEIVE"]
        | composer.PERMISSIONS_ACTION["BURN"]
        | composer.PERMISSIONS_ACTION["SEND"],
    )

    actor_role1 = composer.permissions_actor_roles(
        actor="inj1specificactoraddress",
        roles=["admin"],
    )
    actor_role2 = composer.permissions_actor_roles(
        actor="inj1anotheractoraddress",
        roles=["user"],
    )

    role_manager = composer.permissions_role_manager(
        manager="inj1manageraddress",
        roles=["admin"],
    )

    policy_status1 = composer.permissions_policy_status(
        action=composer.PERMISSIONS_ACTION["MINT"],
        is_disabled=False,
        is_sealed=False,
    )
    policy_status2 = composer.permissions_policy_status(
        action=composer.PERMISSIONS_ACTION["BURN"],
        is_disabled=False,
        is_sealed=False,
    )

    policy_manager_capability = composer.permissions_policy_manager_capability(
        manager="inj1policymanageraddress",
        action=composer.PERMISSIONS_ACTION["MODIFY_CONTRACT_HOOK"],
        can_disable=True,
        can_seal=False,
    )

    message = composer.msg_create_namespace(
        sender=address.to_acc_bech32(),
        denom=denom,
        contract_hook="",
        role_permissions=[role1, role2, role3],
        actor_roles=[actor_role1, actor_role2],
        role_managers=[role_manager],
        policy_statuses=[policy_status1, policy_status2],
        policy_manager_capabilities=[policy_manager_capability],
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/1_MsgCreateNamespace/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/1_MsgCreateNamespace/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	permissionstypes "github.com/InjectiveLabs/sdk-go/chain/permissions/types"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"
	role1 := permissionstypes.Role{
		Name:        "EVERYONE",
		RoleId:      0,
		Permissions: uint32(permissionstypes.Action_RECEIVE | permissionstypes.Action_SEND),
	}
	role2 := permissionstypes.Role{
		Name:        "admin",
		RoleId:      1,
		Permissions: uint32(permissionstypes.Action_MODIFY_ROLE_PERMISSIONS),
	}
	role3 := permissionstypes.Role{
		Name:   "user",
		RoleId: 2,
		Permissions: uint32(
			permissionstypes.Action_MINT |
				permissionstypes.Action_RECEIVE |
				permissionstypes.Action_BURN |
				permissionstypes.Action_SEND),
	}

	actor_role1 := permissionstypes.ActorRoles{
		Actor: "inj1specificactoraddress",
		Roles: []string{"admin"},
	}
	actor_role2 := permissionstypes.ActorRoles{
		Actor: "inj1anotheractoraddress",
		Roles: []string{"user"},
	}

	role_manager := permissionstypes.RoleManager{
		Manager: "inj1manageraddress",
		Roles:   []string{"admin"},
	}

	policy_status1 := permissionstypes.PolicyStatus{
		Action:     permissionstypes.Action_MINT,
		IsDisabled: false,
		IsSealed:   false,
	}
	policy_status2 := permissionstypes.PolicyStatus{
		Action:     permissionstypes.Action_BURN,
		IsDisabled: false,
		IsSealed:   false,
	}

	policy_manager_capability := permissionstypes.PolicyManagerCapability{
		Manager:    "inj1policymanageraddress",
		Action:     permissionstypes.Action_MODIFY_CONTRACT_HOOK,
		CanDisable: true,
		CanSeal:    false,
	}

	namespace := permissionstypes.Namespace{
		Denom:                     denom,
		ContractHook:              "",
		RolePermissions:           []*permissionstypes.Role{&role1, &role2, &role3},
		ActorRoles:                []*permissionstypes.ActorRoles{&actor_role1, &actor_role2},
		RoleManagers:              []*permissionstypes.RoleManager{&role_manager},
		PolicyStatuses:            []*permissionstypes.PolicyStatus{&policy_status1, &policy_status2},
		PolicyManagerCapabilities: []*permissionstypes.PolicyManagerCapability{&policy_manager_capability},
	}

	msg := &permissionstypes.MsgCreateNamespace{
		Sender:    senderAddress.String(),
		Namespace: namespace,
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	pollInterval := 100 * time.Millisecond
	response, err := chainClient.SyncBroadcastMsg(ctx, &pollInterval, 5, msg)

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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/MsgCreateNamespace.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">The sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">namespace</td><td class="type-td td_text">Namespace</td><td class="description-td td_text">The namespace information</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Namespace**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/Namespace.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The tokenfactory denom to which this namespace applies to</td></tr>
<tr ><td class="parameter-td td_text">contract_hook</td><td class="type-td td_text">string</td><td class="description-td td_text">The address of smart contract to apply code-based restrictions</td></tr>
<tr ><td class="parameter-td td_text">role_permissions</td><td class="type-td td_text">Role array</td><td class="description-td td_text">permissions for each role</td></tr>
<tr ><td class="parameter-td td_text">actor_roles</td><td class="type-td td_text">ActorRoles array</td><td class="description-td td_text">roles for each actor</td></tr>
<tr ><td class="parameter-td td_text">role_managers</td><td class="type-td td_text">RoleManager array</td><td class="description-td td_text">managers for each role</td></tr>
<tr ><td class="parameter-td td_text">policy_statuses</td><td class="type-td td_text">PolicyStatus array</td><td class="description-td td_text">status for each policy</td></tr>
<tr ><td class="parameter-td td_text">policy_manager_capabilities</td><td class="type-td td_text">PolicyManagerCapability array</td><td class="description-td td_text">capabilities for each manager for each policy</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Role**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/Role.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">name</td><td class="type-td td_text">string</td><td class="description-td td_text">The role name</td></tr>
<tr ><td class="parameter-td td_text">role_id</td><td class="type-td td_text">uint32</td><td class="description-td td_text">The role ID</td></tr>
<tr ><td class="parameter-td td_text">permissions</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Integer representing the bitwise combination of all actions assigned to the role</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ActorRoles**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/ActorRoles.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">actor</td><td class="type-td td_text">string</td><td class="description-td td_text">The actor name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">The roles for the actor</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/RoleManager.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of roles associated with the manager</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">is_disabled</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is disabled</td></tr>
<tr ><td class="parameter-td td_text">is_sealed</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is sealed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyManagerCapability.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">can_disable</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can disable the policy</td></tr>
<tr ><td class="parameter-td td_text">can_seal</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can seal the policy</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Action**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/v1beta1/Action.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">MINT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">RECEIVE</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">BURN</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SEND</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">SUPER_BURN</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_POLICY_MANAGERS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_CONTRACT_HOOK</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_PERMISSIONS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_MANAGERS</td></tr></tbody></table>
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


## UpdateNamespace

Message to update a namespace configuration

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/2_MsgUpdateNamespace.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/2_MsgUpdateNamespace.py -->
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
    network = Network.devnet()

    client = AsyncClient(network)
    composer = await client.composer()

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=private_key_in_hexa,
        gas_price=gas_price,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    denom = "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"

    role1 = composer.permissions_role(
        name="EVERYONE",
        role_id=0,
        permissions=composer.PERMISSIONS_ACTION["UNSPECIFIED"],  # revoke all permissions
    )
    role2 = composer.permissions_role(
        name="user",
        role_id=2,
        permissions=composer.PERMISSIONS_ACTION["RECEIVE"] | composer.PERMISSIONS_ACTION["SEND"],
    )

    role_manager = composer.permissions_role_manager(
        manager="inj1manageraddress",
        roles=["admin", "user"],
    )

    policy_status1 = composer.permissions_policy_status(
        action=composer.PERMISSIONS_ACTION["MINT"],
        is_disabled=True,
        is_sealed=False,
    )
    policy_status2 = composer.permissions_policy_status(
        action=composer.PERMISSIONS_ACTION["BURN"],
        is_disabled=False,
        is_sealed=True,
    )

    policy_manager_capability = composer.permissions_policy_manager_capability(
        manager="inj1policymanageraddress",
        action=composer.PERMISSIONS_ACTION["MODIFY_ROLE_PERMISSIONS"],
        can_disable=True,
        can_seal=False,
    )

    message = composer.msg_update_namespace(
        sender=address.to_acc_bech32(),
        denom=denom,
        contract_hook="inj19ld6swyldyujcn72j7ugnu9twafhs9wxlyye5m",
        role_permissions=[role1, role2],
        role_managers=[role_manager],
        policy_statuses=[policy_status1, policy_status2],
        policy_manager_capabilities=[policy_manager_capability],
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/2_MsgUpdateNamespace/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/2_MsgUpdateNamespace/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	permissionstypes "github.com/InjectiveLabs/sdk-go/chain/permissions/types"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"

	role1 := permissionstypes.Role{
		Name:        "EVERYONE",
		RoleId:      0,
		Permissions: uint32(permissionstypes.Action_UNSPECIFIED),
	}
	role2 := permissionstypes.Role{
		Name:        "user",
		RoleId:      2,
		Permissions: uint32(permissionstypes.Action_RECEIVE | permissionstypes.Action_SEND),
	}

	role_manager := permissionstypes.RoleManager{
		Manager: "inj1manageraddress",
		Roles:   []string{"admin", "user"},
	}

	policy_status1 := permissionstypes.PolicyStatus{
		Action:     permissionstypes.Action_MINT,
		IsDisabled: true,
		IsSealed:   false,
	}
	policy_status2 := permissionstypes.PolicyStatus{
		Action:     permissionstypes.Action_BURN,
		IsDisabled: false,
		IsSealed:   true,
	}

	policy_manager_capability := permissionstypes.PolicyManagerCapability{
		Manager:    "inj1policymanageraddress",
		Action:     permissionstypes.Action_MODIFY_ROLE_PERMISSIONS,
		CanDisable: true,
		CanSeal:    false,
	}

	msg := &permissionstypes.MsgUpdateNamespace{
		Sender:                    senderAddress.String(),
		Denom:                     denom,
		ContractHook:              &permissionstypes.MsgUpdateNamespace_SetContractHook{NewValue: "inj19ld6swyldyujcn72j7ugnu9twafhs9wxlyye5m"},
		RolePermissions:           []*permissionstypes.Role{&role1, &role2},
		RoleManagers:              []*permissionstypes.RoleManager{&role_manager},
		PolicyStatuses:            []*permissionstypes.PolicyStatus{&policy_status1, &policy_status2},
		PolicyManagerCapabilities: []*permissionstypes.PolicyManagerCapability{&policy_manager_capability},
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	pollInterval := 100 * time.Millisecond
	response, err := chainClient.SyncBroadcastMsg(ctx, &pollInterval, 5, msg)

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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/MsgUpdateNamespace.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">The sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">denom whose namespace updates are to be applied</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">contract_hook</td><td class="type-td td_text">MsgUpdateNamespace_SetContractHook</td><td class="description-td td_text">address of smart contract to apply code-based restrictions</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">role_permissions</td><td class="type-td td_text">Role array</td><td class="description-td td_text">role permissions to update</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">role_managers</td><td class="type-td td_text">RoleManager array</td><td class="description-td td_text">role managers to update</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">policy_statuses</td><td class="type-td td_text">PolicyStatus array</td><td class="description-td td_text">policy statuses to update</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">policy_manager_capabilities</td><td class="type-td td_text">PolicyManagerCapability array</td><td class="description-td td_text">policy manager capabilities to update</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MsgUpdateNamespace_SetContractHook**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/MsgUpdateNamespace_SetContractHook.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">new_value</td><td class="type-td td_text">string</td><td class="description-td td_num"></td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Role**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/Role.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">name</td><td class="type-td td_text">string</td><td class="description-td td_text">The role name</td></tr>
<tr ><td class="parameter-td td_text">role_id</td><td class="type-td td_text">uint32</td><td class="description-td td_text">The role ID</td></tr>
<tr ><td class="parameter-td td_text">permissions</td><td class="type-td td_text">uint32</td><td class="description-td td_text">Integer representing the bitwise combination of all actions assigned to the role</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/RoleManager.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">roles</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of roles associated with the manager</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">is_disabled</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is disabled</td></tr>
<tr ><td class="parameter-td td_text">is_sealed</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the policy is sealed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/PolicyManagerCapability.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">manager</td><td class="type-td td_text">string</td><td class="description-td td_text">The manager name</td></tr>
<tr ><td class="parameter-td td_text">action</td><td class="type-td td_text">Action</td><td class="description-td td_text">The action code number</td></tr>
<tr ><td class="parameter-td td_text">can_disable</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can disable the policy</td></tr>
<tr ><td class="parameter-td td_text">can_seal</td><td class="type-td td_text">bool</td><td class="description-td td_text">Whether the manager can seal the policy</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Action**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/v1beta1/Action.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">MINT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">RECEIVE</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">BURN</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SEND</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">SUPER_BURN</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_POLICY_MANAGERS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_CONTRACT_HOOK</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_PERMISSIONS</td></tr>
<tr ><td class="code-td td_num">0</td><td class="name-td td_text">MODIFY_ROLE_MANAGERS</td></tr></tbody></table>
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


## UpdateActorRoles

Message to update the roles assigned to an actor

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/3_MsgUpdateActorRoles.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/3_MsgUpdateActorRoles.py -->
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
    network = Network.devnet()

    client = AsyncClient(network)
    composer = await client.composer()

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=private_key_in_hexa,
        gas_price=gas_price,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    denom = "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"

    role_actors1 = composer.permissions_role_actors(
        role="admin",
        actors=["inj1actoraddress1", "inj1actoraddress2"],
    )
    role_actors2 = composer.permissions_role_actors(
        role="user",
        actors=["inj1actoraddress3"],
    )
    role_actors3 = composer.permissions_role_actors(
        role="user",
        actors=["inj1actoraddress4"],
    )
    role_actors4 = composer.permissions_role_actors(
        role="admin",
        actors=["inj1actoraddress5"],
    )

    message = composer.msg_update_actor_roles(
        sender=address.to_acc_bech32(),
        denom=denom,
        role_actors_to_add=[role_actors1, role_actors2],
        role_actors_to_revoke=[role_actors3, role_actors4],
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/3_MsgUpdateActorRoles/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/3_MsgUpdateActorRoles/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	txtypes "github.com/cosmos/cosmos-sdk/types/tx"

	permissionstypes "github.com/InjectiveLabs/sdk-go/chain/permissions/types"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"
	roleActors1 := permissionstypes.RoleActors{
		Role:   "admin",
		Actors: []string{"inj1actoraddress1", "inj1actoraddress2"},
	}
	roleActors2 := permissionstypes.RoleActors{
		Role:   "user",
		Actors: []string{"inj1actoraddress3"},
	}
	roleActors3 := permissionstypes.RoleActors{
		Role:   "user",
		Actors: []string{"inj1actoraddress4"},
	}
	roleActors4 := permissionstypes.RoleActors{
		Role:   "admin",
		Actors: []string{"inj1actoraddress5"},
	}

	msg := &permissionstypes.MsgUpdateActorRoles{
		Sender:             senderAddress.String(),
		Denom:              denom,
		RoleActorsToAdd:    []*permissionstypes.RoleActors{&roleActors1, &roleActors2},
		RoleActorsToRevoke: []*permissionstypes.RoleActors{&roleActors3, &roleActors4},
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	_, response, err := chainClient.BroadcastMsg(ctx, txtypes.BroadcastMode_BROADCAST_MODE_SYNC, msg)

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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/MsgUpdateActorRoles.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">The sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The namespace denom to which this updates are applied</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">role_actors_to_add</td><td class="type-td td_text">RoleActors array</td><td class="description-td td_text">The roles to add for given actors</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">role_actors_to_revoke</td><td class="type-td td_text">RoleActors array</td><td class="description-td td_text">The roles to revoke from given actors</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleActors**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/RoleActors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">role</td><td class="type-td td_text">string</td><td class="description-td td_text">The role name</td></tr>
<tr ><td class="parameter-td td_text">actors</td><td class="type-td td_text">string array</td><td class="description-td td_text">List of actor names associated with the role</td></tr></tbody></table>
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


## ClaimVoucher

Message to claim existing vouchers for a particular address

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-python-sdk/examples/chain_client/permissions/4_MsgClaimVoucher.py) -->
<!-- The below code snippet is automatically added from ../../tmp-python-sdk/examples/chain_client/permissions/4_MsgClaimVoucher.py -->
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
    network = Network.devnet()

    client = AsyncClient(network)
    composer = await client.composer()

    gas_price = await client.current_chain_gas_price()
    # adjust gas price to make it valid even if it changes between the time it is requested and the TX is broadcasted
    gas_price = int(gas_price * 1.1)

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=private_key_in_hexa,
        gas_price=gas_price,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    denom = "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"

    message = composer.msg_claim_voucher(
        sender=address.to_acc_bech32(),
        denom=denom,
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=../../tmp-go-sdk/examples/chain/permissions/4_MsgClaimVoucher/example.go) -->
<!-- The below code snippet is automatically added from ../../tmp-go-sdk/examples/chain/permissions/4_MsgClaimVoucher/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	txtypes "github.com/cosmos/cosmos-sdk/types/tx"

	permissionstypes "github.com/InjectiveLabs/sdk-go/chain/permissions/types"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"

	msg := &permissionstypes.MsgClaimVoucher{
		Sender: senderAddress.String(),
		Denom:  denom,
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	_, response, err := chainClient.BroadcastMsg(ctx, txtypes.BroadcastMode_BROADCAST_MODE_SYNC, msg)

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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/injective/permissions/MsgClaimVoucher.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">string</td><td class="description-td td_text">The sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">string</td><td class="description-td td_text">The token denom of the voucher to claim</td><td class="required-td td_text">Yes</td></tr></tbody></table>
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
