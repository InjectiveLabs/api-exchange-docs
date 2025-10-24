# Error Codes

This section lists all error codes from various modules in the Injective ecosystem.

## 06-solomachine module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/06-solomachine_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">06-solomachine</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid header</td></tr>
<tr ><td class="module-name-td td_text">06-solomachine</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid sequence</td></tr>
<tr ><td class="module-name-td td_text">06-solomachine</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid signature and data</td></tr>
<tr ><td class="module-name-td td_text">06-solomachine</td><td class="error-code-td td_num">5</td><td class="description-td td_text">signature verification failed</td></tr>
<tr ><td class="module-name-td td_text">06-solomachine</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid solo machine proof</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## 07-tendermint module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/07-tendermint_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid chain-id</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid trusting period</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid unbonding period</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid header height</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid header</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid max clock drift</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">8</td><td class="description-td td_text">processed time not found</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">9</td><td class="description-td td_text">processed height not found</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">10</td><td class="description-td td_text">packet-specified delay period has not been reached</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">11</td><td class="description-td td_text">time since latest trusted state has passed the trusting period</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">12</td><td class="description-td td_text">time since latest trusted state has passed the unbonding period</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">13</td><td class="description-td td_text">invalid proof specs</td></tr>
<tr ><td class="module-name-td td_text">07-tendermint</td><td class="error-code-td td_num">14</td><td class="description-td td_text">invalid validator set</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Auction module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/auction_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">auction</td><td class="error-code-td td_num">1</td><td class="description-td td_text">invalid bid denom</td></tr>
<tr ><td class="module-name-td td_text">auction</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid bid round</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Authz module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/authz_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">authz</td><td class="error-code-td td_num">2</td><td class="description-td td_text">authorization not found</td></tr>
<tr ><td class="module-name-td td_text">authz</td><td class="error-code-td td_num">3</td><td class="description-td td_text">expiration time of authorization should be more than current time</td></tr>
<tr ><td class="module-name-td td_text">authz</td><td class="error-code-td td_num">4</td><td class="description-td td_text">unknown authorization type</td></tr>
<tr ><td class="module-name-td td_text">authz</td><td class="error-code-td td_num">5</td><td class="description-td td_text">grant key not found</td></tr>
<tr ><td class="module-name-td td_text">authz</td><td class="error-code-td td_num">6</td><td class="description-td td_text">authorization expired</td></tr>
<tr ><td class="module-name-td td_text">authz</td><td class="error-code-td td_num">7</td><td class="description-td td_text">grantee and granter should be different</td></tr>
<tr ><td class="module-name-td td_text">authz</td><td class="error-code-td td_num">9</td><td class="description-td td_text">authorization can be given to msg with only one signer</td></tr>
<tr ><td class="module-name-td td_text">authz</td><td class="error-code-td td_num">12</td><td class="description-td td_text">max tokens should be positive</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Bandoracle module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/bandoracle_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">1</td><td class="description-td td_text">owasm compilation failed</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">2</td><td class="description-td td_text">bad wasm execution</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">3</td><td class="description-td td_text">data source not found</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">4</td><td class="description-td td_text">oracle script not found</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">5</td><td class="description-td td_text">request not found</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">6</td><td class="description-td td_text">raw request not found</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">7</td><td class="description-td td_text">reporter not found</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">8</td><td class="description-td td_text">result not found</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">9</td><td class="description-td td_text">reporter already exists</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">10</td><td class="description-td td_text">validator not requested</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">11</td><td class="description-td td_text">validator already reported</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">12</td><td class="description-td td_text">invalid report size</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">13</td><td class="description-td td_text">reporter not authorized</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">14</td><td class="description-td td_text">editor not authorized</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">16</td><td class="description-td td_text">validator already active</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">17</td><td class="description-td td_text">too soon to activate</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">18</td><td class="description-td td_text">too long name</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">19</td><td class="description-td td_text">too long description</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">20</td><td class="description-td td_text">empty executable</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">21</td><td class="description-td td_text">empty wasm code</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">22</td><td class="description-td td_text">too large executable</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">23</td><td class="description-td td_text">too large wasm code</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">24</td><td class="description-td td_text">invalid min count</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">25</td><td class="description-td td_text">invalid ask count</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">26</td><td class="description-td td_text">too large calldata</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">27</td><td class="description-td td_text">too long client id</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">28</td><td class="description-td td_text">empty raw requests</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">29</td><td class="description-td td_text">empty report</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">30</td><td class="description-td td_text">duplicate external id</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">31</td><td class="description-td td_text">too long schema</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">32</td><td class="description-td td_text">too long url</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">33</td><td class="description-td td_text">too large raw report data</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">34</td><td class="description-td td_text">insufficient available validators</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">35</td><td class="description-td td_text">cannot create with [do-not-modify] content</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">36</td><td class="description-td td_text">cannot reference self as reporter</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">37</td><td class="description-td td_text">obi decode failed</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">38</td><td class="description-td td_text">uncompression failed</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">39</td><td class="description-td td_text">request already expired</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">40</td><td class="description-td td_text">bad drbg initialization</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">41</td><td class="description-td td_text">max oracle channels</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">42</td><td class="description-td td_text">invalid ICS20 version</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">43</td><td class="description-td td_text">not enough fee</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">44</td><td class="description-td td_text">invalid owasm gas</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">45</td><td class="description-td td_text">sending oracle request via IBC is disabled</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">46</td><td class="description-td td_text">invalid request key</td></tr>
<tr ><td class="module-name-td td_text">bandoracle</td><td class="error-code-td td_num">47</td><td class="description-td td_text">too long request key</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Bank module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/bank_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">bank</td><td class="error-code-td td_num">2</td><td class="description-td td_text">no inputs to send transaction</td></tr>
<tr ><td class="module-name-td td_text">bank</td><td class="error-code-td td_num">3</td><td class="description-td td_text">no outputs to send transaction</td></tr>
<tr ><td class="module-name-td td_text">bank</td><td class="error-code-td td_num">4</td><td class="description-td td_text">sum inputs != sum outputs</td></tr>
<tr ><td class="module-name-td td_text">bank</td><td class="error-code-td td_num">5</td><td class="description-td td_text">send transactions are disabled</td></tr>
<tr ><td class="module-name-td td_text">bank</td><td class="error-code-td td_num">6</td><td class="description-td td_text">client denom metadata not found</td></tr>
<tr ><td class="module-name-td td_text">bank</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid key</td></tr>
<tr ><td class="module-name-td td_text">bank</td><td class="error-code-td td_num">8</td><td class="description-td td_text">duplicate entry</td></tr>
<tr ><td class="module-name-td td_text">bank</td><td class="error-code-td td_num">9</td><td class="description-td td_text">multiple senders not allowed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Capability module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/capability_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">capability</td><td class="error-code-td td_num">2</td><td class="description-td td_text">capability name not valid</td></tr>
<tr ><td class="module-name-td td_text">capability</td><td class="error-code-td td_num">3</td><td class="description-td td_text">provided capability is nil</td></tr>
<tr ><td class="module-name-td td_text">capability</td><td class="error-code-td td_num">4</td><td class="description-td td_text">capability name already taken</td></tr>
<tr ><td class="module-name-td td_text">capability</td><td class="error-code-td td_num">5</td><td class="description-td td_text">given owner already claimed capability</td></tr>
<tr ><td class="module-name-td td_text">capability</td><td class="error-code-td td_num">6</td><td class="description-td td_text">capability not owned by module</td></tr>
<tr ><td class="module-name-td td_text">capability</td><td class="error-code-td td_num">7</td><td class="description-td td_text">capability not found</td></tr>
<tr ><td class="module-name-td td_text">capability</td><td class="error-code-td td_num">8</td><td class="description-td td_text">owners not found for capability</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Chainlink module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/chainlink_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">1</td><td class="description-td td_text">stale report</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">2</td><td class="description-td td_text">incomplete proposal</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">3</td><td class="description-td td_text">repeated oracle address</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">4</td><td class="description-td td_text">too many signers</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">5</td><td class="description-td td_text">incorrect config</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">6</td><td class="description-td td_text">config digest doesn't match</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">7</td><td class="description-td td_text">wrong number of signatures</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">8</td><td class="description-td td_text">incorrect signature</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">9</td><td class="description-td td_text">no transmitter specified</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">10</td><td class="description-td td_text">incorrect transmission data</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">11</td><td class="description-td td_text">no transmissions found</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">12</td><td class="description-td td_text">median value is out of bounds</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">13</td><td class="description-td td_text">LINK denom doesn't match</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">14</td><td class="description-td td_text">Reward Pool doesn't exist</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">15</td><td class="description-td td_text">wrong number of payees and transmitters</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">16</td><td class="description-td td_text">action is restricted to the module admin</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">17</td><td class="description-td td_text">feed already exists</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">19</td><td class="description-td td_text">feed doesnt exists</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">20</td><td class="description-td td_text">action is admin-restricted</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">21</td><td class="description-td td_text">insufficient reward pool</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">22</td><td class="description-td td_text">payee already set</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">23</td><td class="description-td td_text">action is payee-restricted</td></tr>
<tr ><td class="module-name-td td_text">chainlink</td><td class="error-code-td td_num">24</td><td class="description-td td_text">feed config not found</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Channel module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/channel_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">2</td><td class="description-td td_text">channel already exists</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">3</td><td class="description-td td_text">channel not found</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid channel</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid channel state</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid channel ordering</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid counterparty channel</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">8</td><td class="description-td td_text">invalid channel capability</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">9</td><td class="description-td td_text">channel capability not found</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">10</td><td class="description-td td_text">sequence send not found</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">11</td><td class="description-td td_text">sequence receive not found</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">12</td><td class="description-td td_text">sequence acknowledgement not found</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">13</td><td class="description-td td_text">invalid packet</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">14</td><td class="description-td td_text">packet timeout</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">15</td><td class="description-td td_text">too many connection hops</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">16</td><td class="description-td td_text">invalid acknowledgement</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">17</td><td class="description-td td_text">acknowledgement for packet already exists</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">18</td><td class="description-td td_text">invalid channel identifier</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">19</td><td class="description-td td_text">packet already received</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">20</td><td class="description-td td_text">packet commitment not found</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">21</td><td class="description-td td_text">packet sequence is out of order</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">22</td><td class="description-td td_text">packet messages are redundant</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">23</td><td class="description-td td_text">message is redundant, no-op will be performed</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">24</td><td class="description-td td_text">invalid channel version</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">25</td><td class="description-td td_text">packet has not been sent</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">26</td><td class="description-td td_text">invalid packet timeout</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">27</td><td class="description-td td_text">upgrade error receipt not found</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">28</td><td class="description-td td_text">invalid upgrade</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">29</td><td class="description-td td_text">invalid upgrade sequence</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">30</td><td class="description-td td_text">upgrade not found</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">31</td><td class="description-td td_text">incompatible counterparty upgrade</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">32</td><td class="description-td td_text">invalid upgrade error</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">33</td><td class="description-td td_text">restore failed</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">34</td><td class="description-td td_text">upgrade timed-out</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">35</td><td class="description-td td_text">upgrade timeout is invalid</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">36</td><td class="description-td td_text">pending inflight packets exist</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">37</td><td class="description-td td_text">upgrade timeout failed</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">38</td><td class="description-td td_text">invalid pruning limit</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">39</td><td class="description-td td_text">timeout not reached</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">40</td><td class="description-td td_text">timeout elapsed</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">41</td><td class="description-td td_text">pruning sequence start not found</td></tr>
<tr ><td class="module-name-td td_text">channel</td><td class="error-code-td td_num">42</td><td class="description-td td_text">recv start sequence not found</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Client module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/client_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">2</td><td class="description-td td_text">light client already exists</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">3</td><td class="description-td td_text">light client is invalid</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">4</td><td class="description-td td_text">light client not found</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">5</td><td class="description-td td_text">light client is frozen due to misbehaviour</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid client metadata</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">7</td><td class="description-td td_text">consensus state not found</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">8</td><td class="description-td td_text">invalid consensus state</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">9</td><td class="description-td td_text">client type not found</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">10</td><td class="description-td td_text">invalid client type</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">11</td><td class="description-td td_text">commitment root not found</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">12</td><td class="description-td td_text">invalid client header</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">13</td><td class="description-td td_text">invalid light client misbehaviour</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">14</td><td class="description-td td_text">client state verification failed</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">15</td><td class="description-td td_text">client consensus state verification failed</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">16</td><td class="description-td td_text">connection state verification failed</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">17</td><td class="description-td td_text">channel state verification failed</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">18</td><td class="description-td td_text">packet commitment verification failed</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">19</td><td class="description-td td_text">packet acknowledgement verification failed</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">20</td><td class="description-td td_text">packet receipt verification failed</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">21</td><td class="description-td td_text">next sequence receive verification failed</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">22</td><td class="description-td td_text">self consensus state not found</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">23</td><td class="description-td td_text">unable to update light client</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">24</td><td class="description-td td_text">invalid recovery client</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">25</td><td class="description-td td_text">invalid client upgrade</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">26</td><td class="description-td td_text">invalid height</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">27</td><td class="description-td td_text">invalid client state substitute</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">28</td><td class="description-td td_text">invalid upgrade proposal</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">29</td><td class="description-td td_text">client state is not active</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">30</td><td class="description-td td_text">membership verification failed</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">31</td><td class="description-td td_text">non-membership verification failed</td></tr>
<tr ><td class="module-name-td td_text">client</td><td class="error-code-td td_num">32</td><td class="description-td td_text">client type not supported</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Commitment module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/commitment_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">commitment</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid proof</td></tr>
<tr ><td class="module-name-td td_text">commitment</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid prefix</td></tr>
<tr ><td class="module-name-td td_text">commitment</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid merkle proof</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Connection module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/connection_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">connection</td><td class="error-code-td td_num">2</td><td class="description-td td_text">connection already exists</td></tr>
<tr ><td class="module-name-td td_text">connection</td><td class="error-code-td td_num">3</td><td class="description-td td_text">connection not found</td></tr>
<tr ><td class="module-name-td td_text">connection</td><td class="error-code-td td_num">4</td><td class="description-td td_text">light client connection paths not found</td></tr>
<tr ><td class="module-name-td td_text">connection</td><td class="error-code-td td_num">5</td><td class="description-td td_text">connection path is not associated to the given light client</td></tr>
<tr ><td class="module-name-td td_text">connection</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid connection state</td></tr>
<tr ><td class="module-name-td td_text">connection</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid counterparty connection</td></tr>
<tr ><td class="module-name-td td_text">connection</td><td class="error-code-td td_num">8</td><td class="description-td td_text">invalid connection</td></tr>
<tr ><td class="module-name-td td_text">connection</td><td class="error-code-td td_num">9</td><td class="description-td td_text">invalid connection version</td></tr>
<tr ><td class="module-name-td td_text">connection</td><td class="error-code-td td_num">10</td><td class="description-td td_text">connection version negotiation failed</td></tr>
<tr ><td class="module-name-td td_text">connection</td><td class="error-code-td td_num">11</td><td class="description-td td_text">invalid connection identifier</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Crisis module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/crisis_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">crisis</td><td class="error-code-td td_num">2</td><td class="description-td td_text">sender address is empty</td></tr>
<tr ><td class="module-name-td td_text">crisis</td><td class="error-code-td td_num">3</td><td class="description-td td_text">unknown invariant</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Distribution module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/distribution_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">2</td><td class="description-td td_text">delegator address is empty</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">3</td><td class="description-td td_text">withdraw address is empty</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">4</td><td class="description-td td_text">validator address is empty</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">5</td><td class="description-td td_text">no delegation distribution info</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">6</td><td class="description-td td_text">no validator distribution info</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">7</td><td class="description-td td_text">no validator commission to withdraw</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">8</td><td class="description-td td_text">set withdraw address disabled</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">9</td><td class="description-td td_text">community pool does not have sufficient coins to distribute</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">10</td><td class="description-td td_text">invalid community pool spend proposal amount</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">11</td><td class="description-td td_text">invalid community pool spend proposal recipient</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">12</td><td class="description-td td_text">validator does not exist</td></tr>
<tr ><td class="module-name-td td_text">distribution</td><td class="error-code-td td_num">13</td><td class="description-td td_text">delegation does not exist</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Erc20 module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/erc20_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">erc20</td><td class="error-code-td td_num">2</td><td class="description-td td_text">attempting to create a token pair for bank denom that already has a pair associated</td></tr>
<tr ><td class="module-name-td td_text">erc20</td><td class="error-code-td td_num">3</td><td class="description-td td_text">unauthorized account</td></tr>
<tr ><td class="module-name-td td_text">erc20</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid genesis</td></tr>
<tr ><td class="module-name-td td_text">erc20</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid token pair</td></tr>
<tr ><td class="module-name-td td_text">erc20</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid ERC20 contract address</td></tr>
<tr ><td class="module-name-td td_text">erc20</td><td class="error-code-td td_num">7</td><td class="description-td td_text">unknown bank denom or zero supply</td></tr>
<tr ><td class="module-name-td td_text">erc20</td><td class="error-code-td td_num">8</td><td class="description-td td_text">error uploading ERC20 contract</td></tr>
<tr ><td class="module-name-td td_text">erc20</td><td class="error-code-td td_num">9</td><td class="description-td td_text">invalid token factory denom</td></tr>
<tr ><td class="module-name-td td_text">erc20</td><td class="error-code-td td_num">10</td><td class="description-td td_text">respective erc20:... denom has existing supply</td></tr>
<tr ><td class="module-name-td td_text">erc20</td><td class="error-code-td td_num">11</td><td class="description-td td_text">invalid query request</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Evidence module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/evidence_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">evidence</td><td class="error-code-td td_num">2</td><td class="description-td td_text">unregistered handler for evidence type</td></tr>
<tr ><td class="module-name-td td_text">evidence</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid evidence</td></tr>
<tr ><td class="module-name-td td_text">evidence</td><td class="error-code-td td_num">5</td><td class="description-td td_text">evidence already exists</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Evm module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/evm_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid storage state</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">3</td><td class="description-td td_text">execution reverted</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">4</td><td class="description-td td_text">chain configuration not found</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid chain configuration</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid zero address</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">7</td><td class="description-td td_text">empty hash</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">8</td><td class="description-td td_text">block bloom not found</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">9</td><td class="description-td td_text">transaction receipt not found</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">10</td><td class="description-td td_text">EVM Create operation is disabled</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">11</td><td class="description-td td_text">EVM Call operation is disabled</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">12</td><td class="description-td td_text">invalid transaction amount</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">13</td><td class="description-td td_text">invalid gas price</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">14</td><td class="description-td td_text">invalid gas fee</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">15</td><td class="description-td td_text">evm transaction execution failed</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">16</td><td class="description-td td_text">invalid gas refund amount</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">17</td><td class="description-td td_text">inconsistent gas</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">18</td><td class="description-td td_text">invalid gas cap</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">19</td><td class="description-td td_text">invalid base fee</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">20</td><td class="description-td td_text">gas computation overflow/underflow</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">21</td><td class="description-td td_text">account type is not a valid ethereum account</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">22</td><td class="description-td td_text">invalid gas limit</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">23</td><td class="description-td td_text">failed to apply state override</td></tr>
<tr ><td class="module-name-td td_text">evm</td><td class="error-code-td td_num">24</td><td class="description-td td_text">EVM Create operation is not authorized for user</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Exchange module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/exchange_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">1</td><td class="description-td td_text">failed to validate order</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">2</td><td class="description-td td_text">spot market not found</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">3</td><td class="description-td td_text">spot market exists</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">4</td><td class="description-td td_text">struct field error</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">5</td><td class="description-td td_text">failed to validate market</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">6</td><td class="description-td td_text">subaccount has insufficient deposits</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">7</td><td class="description-td td_text">unrecognized order type</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">8</td><td class="description-td td_text">position quantity insufficient for order</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">9</td><td class="description-td td_text">order hash is not valid</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">10</td><td class="description-td td_text">subaccount id is not valid</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">11</td><td class="description-td td_text">invalid ticker</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">12</td><td class="description-td td_text">invalid base denom</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">13</td><td class="description-td td_text">invalid quote denom</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">14</td><td class="description-td td_text">invalid oracle</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">15</td><td class="description-td td_text">invalid expiry</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">16</td><td class="description-td td_text">invalid price</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">17</td><td class="description-td td_text">invalid quantity</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">18</td><td class="description-td td_text">unsupported oracle type</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">19</td><td class="description-td td_text">order doesnt exist</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">20</td><td class="description-td td_text">spot limit orderbook fill invalid</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">21</td><td class="description-td td_text">perpetual market exists</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">22</td><td class="description-td td_text">expiry futures market exists</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">23</td><td class="description-td td_text">expiry futures market expired</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">24</td><td class="description-td td_text">no liquidity on the orderbook!</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">25</td><td class="description-td td_text">Orderbook liquidity cannot satisfy current worst price</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">26</td><td class="description-td td_text">insufficient margin</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">27</td><td class="description-td td_text">Derivative market not found</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">28</td><td class="description-td td_text">Position not found</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">29</td><td class="description-td td_text">Position direction does not oppose the reduce-only order</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">30</td><td class="description-td td_text">Price Surpasses Bankruptcy Price</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">31</td><td class="description-td td_text">Position not liquidable</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">32</td><td class="description-td td_text">invalid trigger price</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">33</td><td class="description-td td_text">invalid oracle type</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">34</td><td class="description-td td_text">invalid minimum price tick size</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">35</td><td class="description-td td_text">invalid minimum quantity tick size</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">36</td><td class="description-td td_text">invalid minimum order margin</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">37</td><td class="description-td td_text">Exceeds order side count</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">38</td><td class="description-td td_text">Subaccount cannot place a market order when a market order in the same market was already placed in same block</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">39</td><td class="description-td td_text">cannot place a conditional market order when a conditional market order in same relative direction already exists</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">40</td><td class="description-td td_text">An equivalent market launch proposal already exists.</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">41</td><td class="description-td td_text">Invalid Market Status</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">42</td><td class="description-td td_text">base denom cannot be same with quote denom</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">43</td><td class="description-td td_text">oracle base cannot be same with oracle quote</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">44</td><td class="description-td td_text">MakerFeeRate does not match TakerFeeRate requirements</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">45</td><td class="description-td td_text">Ensure that MaintenanceMarginRatio < InitialMarginRatio <= ReduceMarginRatio</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">46</td><td class="description-td td_text">OracleScaleFactor cannot be greater than MaxOracleScaleFactor</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">47</td><td class="description-td td_text">Spot exchange is not enabled yet</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">48</td><td class="description-td td_text">Derivatives exchange is not enabled yet</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">49</td><td class="description-td td_text">Oracle price delta exceeds threshold</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">50</td><td class="description-td td_text">Invalid hourly interest rate</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">51</td><td class="description-td td_text">Invalid hourly funding rate cap</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">52</td><td class="description-td td_text">Only perpetual markets can update funding parameters</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">53</td><td class="description-td td_text">Invalid trading reward campaign</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">54</td><td class="description-td td_text">Invalid fee discount schedule</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">55</td><td class="description-td td_text">invalid liquidation order</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">56</td><td class="description-td td_text">Unknown error happened for campaign distributions</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">57</td><td class="description-td td_text">Invalid trading reward points update</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">58</td><td class="description-td td_text">Invalid batch msg update</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">59</td><td class="description-td td_text">Post-only order exceeds top of book price</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">60</td><td class="description-td td_text">Order type not supported for given message</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">61</td><td class="description-td td_text">Sender must match dmm account</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">62</td><td class="description-td td_text">already opted out of rewards</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">63</td><td class="description-td td_text">Invalid margin ratio</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">64</td><td class="description-td td_text">Provided funds are below minimum</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">65</td><td class="description-td td_text">Position is below initial margin requirement</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">66</td><td class="description-td td_text">Pool has non-positive total lp token supply</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">67</td><td class="description-td td_text">Passed lp token burn amount is greater than total lp token supply</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">68</td><td class="description-td td_text">unsupported action</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">69</td><td class="description-td td_text">position quantity cannot be negative</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">70</td><td class="description-td td_text">binary options market exists</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">71</td><td class="description-td td_text">binary options market not found</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">72</td><td class="description-td td_text">invalid settlement</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">73</td><td class="description-td td_text">account doesnt exist</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">74</td><td class="description-td td_text">sender should be a market admin</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">75</td><td class="description-td td_text">market is already scheduled to settle</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">76</td><td class="description-td td_text">market not found</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">77</td><td class="description-td td_text">denom decimal should be greater than 0 and not greater than max scale factor</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">78</td><td class="description-td td_text">state is invalid</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">79</td><td class="description-td td_text">transient orders up to cancellation not supported</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">80</td><td class="description-td td_text">invalid trade</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">81</td><td class="description-td td_text">no margin locked in subaccount</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">82</td><td class="description-td td_text">Invalid access level to perform action</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">83</td><td class="description-td td_text">Invalid address</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">84</td><td class="description-td td_text">Invalid argument</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">85</td><td class="description-td td_text">Invalid funds direction</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">86</td><td class="description-td td_text">No funds provided</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">87</td><td class="description-td td_text">Invalid signature</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">88</td><td class="description-td td_text">no funds to unlock</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">89</td><td class="description-td td_text">No msgs provided</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">90</td><td class="description-td td_text">No msg provided</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">91</td><td class="description-td td_text">Invalid amount</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">92</td><td class="description-td td_text">The current feature has been disabled</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">93</td><td class="description-td td_text">Order has too much margin</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">94</td><td class="description-td td_text">Subaccount nonce is invalid</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">95</td><td class="description-td td_text">insufficient funds</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">96</td><td class="description-td td_text">exchange is in post-only mode</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">97</td><td class="description-td td_text">client order id already exists</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">98</td><td class="description-td td_text">client order id is invalid. Max length is 36 chars</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">99</td><td class="description-td td_text">market cannot be settled in emergency mode</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">100</td><td class="description-td td_text">invalid notional</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">101</td><td class="description-td td_text">stale oracle price</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">102</td><td class="description-td td_text">invalid stake grant</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">103</td><td class="description-td td_text">insufficient stake for grant</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">104</td><td class="description-td td_text">invalid permissions</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">105</td><td class="description-td td_text">the decimals specified for the denom is incorrect</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">106</td><td class="description-td td_text">insufficient market balance</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">107</td><td class="description-td td_text">invalid expiration block</td></tr>
<tr ><td class="module-name-td td_text">exchange</td><td class="error-code-td td_num">108</td><td class="description-td td_text">v1 perpetual and expiry market launch proposal is not supported</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Feegrant module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/feegrant_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">feegrant</td><td class="error-code-td td_num">2</td><td class="description-td td_text">fee limit exceeded</td></tr>
<tr ><td class="module-name-td td_text">feegrant</td><td class="error-code-td td_num">3</td><td class="description-td td_text">fee allowance expired</td></tr>
<tr ><td class="module-name-td td_text">feegrant</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid duration</td></tr>
<tr ><td class="module-name-td td_text">feegrant</td><td class="error-code-td td_num">5</td><td class="description-td td_text">no allowance</td></tr>
<tr ><td class="module-name-td td_text">feegrant</td><td class="error-code-td td_num">6</td><td class="description-td td_text">allowed messages are empty</td></tr>
<tr ><td class="module-name-td td_text">feegrant</td><td class="error-code-td td_num">7</td><td class="description-td td_text">message not allowed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Feeibc module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/feeibc_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid ICS29 middleware version</td></tr>
<tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">3</td><td class="description-td td_text">no account found for given refund address</td></tr>
<tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">4</td><td class="description-td td_text">balance not found for given account address</td></tr>
<tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">5</td><td class="description-td td_text">there is no fee escrowed for the given packetID</td></tr>
<tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">6</td><td class="description-td td_text">relayers must not be set. This feature is not supported</td></tr>
<tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">7</td><td class="description-td td_text">counterparty payee must not be empty</td></tr>
<tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">8</td><td class="description-td td_text">forward relayer address not found</td></tr>
<tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">9</td><td class="description-td td_text">fee module is not enabled for this channel. If this error occurs after channel setup, fee module may not be enabled</td></tr>
<tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">10</td><td class="description-td td_text">relayer address must be stored for async WriteAcknowledgement</td></tr>
<tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">11</td><td class="description-td td_text">the fee module is currently locked, a severe bug has been detected</td></tr>
<tr ><td class="module-name-td td_text">feeibc</td><td class="error-code-td td_num">12</td><td class="description-td td_text">unsupported action</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Gov module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/gov_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">3</td><td class="description-td td_text">inactive proposal</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">4</td><td class="description-td td_text">proposal already active</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid proposal content</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid proposal type</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid vote option</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">8</td><td class="description-td td_text">invalid genesis state</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">9</td><td class="description-td td_text">no handler exists for proposal type</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">10</td><td class="description-td td_text">proposal message not recognized by router</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">11</td><td class="description-td td_text">no messages proposed</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">12</td><td class="description-td td_text">invalid proposal message</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">13</td><td class="description-td td_text">expected gov account as only signer for proposal message</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">15</td><td class="description-td td_text">metadata too long</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">16</td><td class="description-td td_text">minimum deposit is too small</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">18</td><td class="description-td td_text">invalid proposer</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">20</td><td class="description-td td_text">voting period already ended</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">21</td><td class="description-td td_text">invalid proposal</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">22</td><td class="description-td td_text">summary too long</td></tr>
<tr ><td class="module-name-td td_text">gov</td><td class="error-code-td td_num">23</td><td class="description-td td_text">invalid deposit denom</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Host module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/host_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">host</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid identifier</td></tr>
<tr ><td class="module-name-td td_text">host</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid path</td></tr>
<tr ><td class="module-name-td td_text">host</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid packet</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Hyperlane module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/hyperlane_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">hyperlane</td><td class="error-code-td td_num">1</td><td class="description-td td_text">no receiver ISM</td></tr>
<tr ><td class="module-name-td td_text">hyperlane</td><td class="error-code-td td_num">2</td><td class="description-td td_text">required hook not set</td></tr>
<tr ><td class="module-name-td td_text">hyperlane</td><td class="error-code-td td_num">3</td><td class="description-td td_text">default hook not set</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Ibc module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/ibc_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">1</td><td class="description-td td_text">invalid sequence</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">2</td><td class="description-td td_text">unauthorized</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">3</td><td class="description-td td_text">insufficient funds</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">4</td><td class="description-td td_text">unknown request</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid address</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid coins</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">7</td><td class="description-td td_text">out of gas</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">8</td><td class="description-td td_text">invalid request</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">9</td><td class="description-td td_text">invalid height</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">10</td><td class="description-td td_text">invalid version</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">11</td><td class="description-td td_text">invalid chain-id</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">12</td><td class="description-td td_text">invalid type</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">13</td><td class="description-td td_text">failed packing protobuf message to Any</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">14</td><td class="description-td td_text">failed unpacking protobuf message from Any</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">15</td><td class="description-td td_text">internal logic error</td></tr>
<tr ><td class="module-name-td td_text">ibc</td><td class="error-code-td td_num">16</td><td class="description-td td_text">not found</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Ibchooks module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/ibchooks_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">ibchooks</td><td class="error-code-td td_num">2</td><td class="description-td td_text">error in wasmhook message validation</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Icacontroller module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/icacontroller_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">icacontroller</td><td class="error-code-td td_num">2</td><td class="description-td td_text">controller submodule is disabled</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Icahost module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/icahost_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">icahost</td><td class="error-code-td td_num">2</td><td class="description-td td_text">host submodule is disabled</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Injective module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/injective_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">injective</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid chain ID</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Insurance module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/insurance_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">1</td><td class="description-td td_text">insurance fund already exists</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">2</td><td class="description-td td_text">insurance fund not found</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">3</td><td class="description-td td_text">redemption already exists</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid deposit amount</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid deposit denom</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">6</td><td class="description-td td_text">insurance payout exceeds deposits</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid ticker</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">8</td><td class="description-td td_text">invalid quote denom</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">9</td><td class="description-td td_text">invalid oracle</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">10</td><td class="description-td td_text">invalid expiration time</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">11</td><td class="description-td td_text">invalid marketID</td></tr>
<tr ><td class="module-name-td td_text">insurance</td><td class="error-code-td td_num">12</td><td class="description-td td_text">invalid share denom</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Interchainaccounts module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/interchainaccounts_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">2</td><td class="description-td td_text">unknown data type</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">3</td><td class="description-td td_text">account already exist</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">4</td><td class="description-td td_text">port is already bound</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid message sent to channel end</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid outgoing data</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid route</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">8</td><td class="description-td td_text">interchain account not found</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">9</td><td class="description-td td_text">interchain account is already set</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">10</td><td class="description-td td_text">active channel already set for this owner</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">11</td><td class="description-td td_text">no active channel for this owner</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">12</td><td class="description-td td_text">invalid interchain accounts version</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">13</td><td class="description-td td_text">invalid account address</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">14</td><td class="description-td td_text">interchain account does not support this action</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">15</td><td class="description-td td_text">invalid controller port</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">16</td><td class="description-td td_text">invalid host port</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">17</td><td class="description-td td_text">timeout timestamp must be in the future</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">18</td><td class="description-td td_text">codec is not supported</td></tr>
<tr ><td class="module-name-td td_text">interchainaccounts</td><td class="error-code-td td_num">19</td><td class="description-td td_text">invalid account reopening</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Ism module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/ism_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">1</td><td class="description-td td_text">unexpected error</td></tr>
<tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid multisig configuration</td></tr>
<tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid announce</td></tr>
<tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">4</td><td class="description-td td_text">mailbox does not exist</td></tr>
<tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid signature</td></tr>
<tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid ism type</td></tr>
<tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">7</td><td class="description-td td_text">unknown ism id</td></tr>
<tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">8</td><td class="description-td td_text">no route found</td></tr>
<tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">9</td><td class="description-td td_text">unauthorized</td></tr>
<tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">10</td><td class="description-td td_text">invalid owner</td></tr>
<tr ><td class="module-name-td td_text">ism</td><td class="error-code-td td_num">11</td><td class="description-td td_text">route for domain already exists</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Oracle module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/oracle_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">1</td><td class="description-td td_text">relayer address is empty</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">2</td><td class="description-td td_text">bad rates count</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">3</td><td class="description-td td_text">bad resolve times</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">4</td><td class="description-td td_text">bad request ID</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">5</td><td class="description-td td_text">relayer not authorized</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">6</td><td class="description-td td_text">bad price feed base count</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">7</td><td class="description-td td_text">bad price feed quote count</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">8</td><td class="description-td td_text">unsupported oracle type</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">9</td><td class="description-td td_text">bad messages count</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">10</td><td class="description-td td_text">bad Coinbase message</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">11</td><td class="description-td td_text">bad Ethereum signature</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">12</td><td class="description-td td_text">bad Coinbase message timestamp</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">13</td><td class="description-td td_text">Coinbase price not found</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">14</td><td class="description-td td_text">Prices must be positive</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">15</td><td class="description-td td_text">Prices must be less than 10 million.</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">16</td><td class="description-td td_text">Invalid Band IBC Request</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">17</td><td class="description-td td_text">sample error</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">18</td><td class="description-td td_text">invalid packet timeout</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">19</td><td class="description-td td_text">invalid symbols count</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">20</td><td class="description-td td_text">could not claim port capability</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">21</td><td class="description-td td_text">invalid IBC Port ID</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">22</td><td class="description-td td_text">invalid IBC Channel ID</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">23</td><td class="description-td td_text">invalid Band IBC request interval</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">24</td><td class="description-td td_text">Invalid Band IBC Update Request Proposal</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">25</td><td class="description-td td_text">Band IBC Oracle Request not found</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">26</td><td class="description-td td_text">Base Info is empty</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">27</td><td class="description-td td_text">provider is empty</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">28</td><td class="description-td td_text">invalid provider name</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">29</td><td class="description-td td_text">invalid symbol</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">30</td><td class="description-td td_text">relayer already exists</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">31</td><td class="description-td td_text">provider price not found</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">32</td><td class="description-td td_text">invalid oracle request</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">33</td><td class="description-td td_text">no price for oracle was found</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">34</td><td class="description-td td_text">no address for Pyth contract found</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">35</td><td class="description-td td_text">unauthorized Pyth price relay</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">36</td><td class="description-td td_text">unauthorized Pyth price relay</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">37</td><td class="description-td td_text">unauthorized Pyth price relay</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">38</td><td class="description-td td_text">unauthorized Pyth price relay</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">39</td><td class="description-td td_text">empty price attestations</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">40</td><td class="description-td td_text">bad Stork message timestamp</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">41</td><td class="description-td td_text">sender stork is empty</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">42</td><td class="description-td td_text">invalid stork signature</td></tr>
<tr ><td class="module-name-td td_text">oracle</td><td class="error-code-td td_num">43</td><td class="description-td td_text">stork asset id not unique</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Params module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/params_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">params</td><td class="error-code-td td_num">2</td><td class="description-td td_text">unknown subspace</td></tr>
<tr ><td class="module-name-td td_text">params</td><td class="error-code-td td_num">3</td><td class="description-td td_text">failed to set parameter</td></tr>
<tr ><td class="module-name-td td_text">params</td><td class="error-code-td td_num">4</td><td class="description-td td_text">submitted parameter changes are empty</td></tr>
<tr ><td class="module-name-td td_text">params</td><td class="error-code-td td_num">5</td><td class="description-td td_text">parameter subspace is empty</td></tr>
<tr ><td class="module-name-td td_text">params</td><td class="error-code-td td_num">6</td><td class="description-td td_text">parameter key is empty</td></tr>
<tr ><td class="module-name-td td_text">params</td><td class="error-code-td td_num">7</td><td class="description-td td_text">parameter value is empty</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Peggy module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/peggy_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">1</td><td class="description-td td_text">internal</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">2</td><td class="description-td td_text">duplicate</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">4</td><td class="description-td td_text">timeout</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">5</td><td class="description-td td_text">unknown</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">6</td><td class="description-td td_text">empty</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">7</td><td class="description-td td_text">outdated</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">8</td><td class="description-td td_text">unsupported</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">9</td><td class="description-td td_text">non contiguous event nonce</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">10</td><td class="description-td td_text">no unbatched txs found</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">11</td><td class="description-td td_text">can not set orchestrator addresses more than once</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">12</td><td class="description-td td_text">supply cannot exceed max ERC20 value</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">13</td><td class="description-td td_text">invalid ethereum sender on claim</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">14</td><td class="description-td td_text">invalid ethereum destination</td></tr>
<tr ><td class="module-name-td td_text">peggy</td><td class="error-code-td td_num">15</td><td class="description-td td_text">missing previous claim for validator</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Permissions module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/permissions_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">2</td><td class="description-td td_text">attempting to create a namespace for denom that already exists</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">3</td><td class="description-td td_text">unauthorized account</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid genesis</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid namespace</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid permissions</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">7</td><td class="description-td td_text">unknown role</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">8</td><td class="description-td td_text">unknown contract address</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">9</td><td class="description-td td_text">restricted action</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">10</td><td class="description-td td_text">invalid role</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">11</td><td class="description-td td_text">namespace for denom does not exist</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">12</td><td class="description-td td_text">wasm hook query error</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">13</td><td class="description-td td_text">voucher was not found</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">14</td><td class="description-td td_text">invalid contract hook</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">15</td><td class="description-td td_text">unknown policy</td></tr>
<tr ><td class="module-name-td td_text">permissions</td><td class="error-code-td td_num">16</td><td class="description-td td_text">unauthorized policy change</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Port module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/port_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">port</td><td class="error-code-td td_num">2</td><td class="description-td td_text">port is already binded</td></tr>
<tr ><td class="module-name-td td_text">port</td><td class="error-code-td td_num">3</td><td class="description-td td_text">port not found</td></tr>
<tr ><td class="module-name-td td_text">port</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid port</td></tr>
<tr ><td class="module-name-td td_text">port</td><td class="error-code-td td_num">5</td><td class="description-td td_text">route not found</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Post_dispatch module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/post_dispatch_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">post_dispatch</td><td class="error-code-td td_num">1</td><td class="description-td td_text">mailbox does not exist</td></tr>
<tr ><td class="module-name-td td_text">post_dispatch</td><td class="error-code-td td_num">2</td><td class="description-td td_text">sender is not designated mailbox</td></tr>
<tr ><td class="module-name-td td_text">post_dispatch</td><td class="error-code-td td_num">3</td><td class="description-td td_text">hook does not exist or isn't registered</td></tr>
<tr ><td class="module-name-td td_text">post_dispatch</td><td class="error-code-td td_num">4</td><td class="description-td td_text">unauthorized</td></tr>
<tr ><td class="module-name-td td_text">post_dispatch</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid owner</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Sdk module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/sdk_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">2</td><td class="description-td td_text">tx parse error</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid sequence</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">4</td><td class="description-td td_text">unauthorized</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">5</td><td class="description-td td_text">insufficient funds</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">6</td><td class="description-td td_text">unknown request</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid address</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">8</td><td class="description-td td_text">invalid pubkey</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">9</td><td class="description-td td_text">unknown address</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">10</td><td class="description-td td_text">invalid coins</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">11</td><td class="description-td td_text">out of gas</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">12</td><td class="description-td td_text">memo too large</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">13</td><td class="description-td td_text">insufficient fee</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">14</td><td class="description-td td_text">maximum number of signatures exceeded</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">15</td><td class="description-td td_text">no signatures supplied</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">16</td><td class="description-td td_text">failed to marshal JSON bytes</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">17</td><td class="description-td td_text">failed to unmarshal JSON bytes</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">18</td><td class="description-td td_text">invalid request</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">19</td><td class="description-td td_text">tx already in mempool</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">20</td><td class="description-td td_text">mempool is full</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">21</td><td class="description-td td_text">tx too large</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">22</td><td class="description-td td_text">key not found</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">23</td><td class="description-td td_text">invalid account password</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">24</td><td class="description-td td_text">tx intended signer does not match the given signer</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">25</td><td class="description-td td_text">invalid gas adjustment</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">26</td><td class="description-td td_text">invalid height</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">27</td><td class="description-td td_text">invalid version</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">28</td><td class="description-td td_text">invalid chain-id</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">29</td><td class="description-td td_text">invalid type</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">30</td><td class="description-td td_text">tx timeout height</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">31</td><td class="description-td td_text">unknown extension options</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">32</td><td class="description-td td_text">incorrect account sequence</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">33</td><td class="description-td td_text">failed packing protobuf message to Any</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">34</td><td class="description-td td_text">failed unpacking protobuf message from Any</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">35</td><td class="description-td td_text">internal logic error</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">36</td><td class="description-td td_text">conflict</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">37</td><td class="description-td td_text">feature not supported</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">38</td><td class="description-td td_text">not found</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">39</td><td class="description-td td_text">Internal IO error</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">40</td><td class="description-td td_text">error in app.toml</td></tr>
<tr ><td class="module-name-td td_text">sdk</td><td class="error-code-td td_num">41</td><td class="description-td td_text">invalid gas limit</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Slashing module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/slashing_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">slashing</td><td class="error-code-td td_num">2</td><td class="description-td td_text">address is not associated with any known validator</td></tr>
<tr ><td class="module-name-td td_text">slashing</td><td class="error-code-td td_num">3</td><td class="description-td td_text">validator does not exist for that address</td></tr>
<tr ><td class="module-name-td td_text">slashing</td><td class="error-code-td td_num">4</td><td class="description-td td_text">validator still jailed; cannot be unjailed</td></tr>
<tr ><td class="module-name-td td_text">slashing</td><td class="error-code-td td_num">5</td><td class="description-td td_text">validator not jailed; cannot be unjailed</td></tr>
<tr ><td class="module-name-td td_text">slashing</td><td class="error-code-td td_num">6</td><td class="description-td td_text">validator has no self-delegation; cannot be unjailed</td></tr>
<tr ><td class="module-name-td td_text">slashing</td><td class="error-code-td td_num">7</td><td class="description-td td_text">validator's self delegation less than minimum; cannot be unjailed</td></tr>
<tr ><td class="module-name-td td_text">slashing</td><td class="error-code-td td_num">8</td><td class="description-td td_text">no validator signing info found</td></tr>
<tr ><td class="module-name-td td_text">slashing</td><td class="error-code-td td_num">9</td><td class="description-td td_text">validator already tombstoned</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Staking module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/staking_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">2</td><td class="description-td td_text">empty validator address</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">3</td><td class="description-td td_text">validator does not exist</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">4</td><td class="description-td td_text">validator already exist for this operator address; must use new validator operator address</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">5</td><td class="description-td td_text">validator already exist for this pubkey; must use new validator pubkey</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">6</td><td class="description-td td_text">validator pubkey type is not supported</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">7</td><td class="description-td td_text">validator for this address is currently jailed</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">8</td><td class="description-td td_text">failed to remove validator</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">9</td><td class="description-td td_text">commission must be positive</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">10</td><td class="description-td td_text">commission cannot be more than 100%</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">11</td><td class="description-td td_text">commission cannot be more than the max rate</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">12</td><td class="description-td td_text">commission cannot be changed more than once in 24h</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">13</td><td class="description-td td_text">commission change rate must be positive</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">14</td><td class="description-td td_text">commission change rate cannot be more than the max rate</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">15</td><td class="description-td td_text">commission cannot be changed more than max change rate</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">16</td><td class="description-td td_text">validator's self delegation must be greater than their minimum self delegation</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">17</td><td class="description-td td_text">minimum self delegation cannot be decrease</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">18</td><td class="description-td td_text">empty delegator address</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">19</td><td class="description-td td_text">no delegation for (address, validator) tuple</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">20</td><td class="description-td td_text">delegator does not exist with address</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">21</td><td class="description-td td_text">delegator does not contain delegation</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">22</td><td class="description-td td_text">insufficient delegation shares</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">23</td><td class="description-td td_text">cannot delegate to an empty validator</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">24</td><td class="description-td td_text">not enough delegation shares</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">25</td><td class="description-td td_text">entry not mature</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">26</td><td class="description-td td_text">no unbonding delegation found</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">27</td><td class="description-td td_text">too many unbonding delegation entries for (delegator, validator) tuple</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">28</td><td class="description-td td_text">no redelegation found</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">29</td><td class="description-td td_text">cannot redelegate to the same validator</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">30</td><td class="description-td td_text">too few tokens to redelegate (truncates to zero tokens)</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">31</td><td class="description-td td_text">redelegation destination validator not found</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">32</td><td class="description-td td_text">redelegation to this validator already in progress; first redelegation to this validator must complete before next redelegation</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">33</td><td class="description-td td_text">too many redelegation entries for (delegator, src-validator, dst-validator) tuple</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">34</td><td class="description-td td_text">cannot delegate to validators with invalid (zero) ex-rate</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">35</td><td class="description-td td_text">both shares amount and shares percent provided</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">36</td><td class="description-td td_text">neither shares amount nor shares percent provided</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">37</td><td class="description-td td_text">invalid historical info</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">38</td><td class="description-td td_text">no historical info found</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">39</td><td class="description-td td_text">empty validator public key</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">40</td><td class="description-td td_text">commission cannot be less than min rate</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">41</td><td class="description-td td_text">unbonding operation not found</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">42</td><td class="description-td td_text">cannot un-hold unbonding operation that is not on hold</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">43</td><td class="description-td td_text">expected authority account as only signer for proposal message</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">44</td><td class="description-td td_text">redelegation source validator not found</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">45</td><td class="description-td td_text">unbonding type not found</td></tr>
<tr ><td class="module-name-td td_text">staking</td><td class="error-code-td td_num">70</td><td class="description-td td_text">commission rate too small</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Store module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/store_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">store</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid proof</td></tr>
<tr ><td class="module-name-td td_text">store</td><td class="error-code-td td_num">3</td><td class="description-td td_text">tx parse error</td></tr>
<tr ><td class="module-name-td td_text">store</td><td class="error-code-td td_num">4</td><td class="description-td td_text">unknown request</td></tr>
<tr ><td class="module-name-td td_text">store</td><td class="error-code-td td_num">5</td><td class="description-td td_text">internal logic error</td></tr>
<tr ><td class="module-name-td td_text">store</td><td class="error-code-td td_num">6</td><td class="description-td td_text">conflict</td></tr>
<tr ><td class="module-name-td td_text">store</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid request</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Table_testdata module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/table_testdata_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">table_testdata</td><td class="error-code-td td_num">2</td><td class="description-td td_text">test</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Tokenfactory module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/tokenfactory_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">2</td><td class="description-td td_text">attempting to create a denom that already exists (has bank metadata)</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">3</td><td class="description-td td_text">unauthorized account</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid denom</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid creator</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">6</td><td class="description-td td_text">invalid authority metadata</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid genesis</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">8</td><td class="description-td td_text">subdenom too long, max length is 44 bytes</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">9</td><td class="description-td td_text">subdenom too short, min length is 1 bytes</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">10</td><td class="description-td td_text">nested subdenom too short, each one should have at least 1 bytes</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">11</td><td class="description-td td_text">creator too long, max length is 75 bytes</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">12</td><td class="description-td td_text">denom does not exist</td></tr>
<tr ><td class="module-name-td td_text">tokenfactory</td><td class="error-code-td td_num">13</td><td class="description-td td_text">amount has to be positive</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Transfer module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/transfer_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">transfer</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid packet timeout</td></tr>
<tr ><td class="module-name-td td_text">transfer</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid denomination for cross-chain transfer</td></tr>
<tr ><td class="module-name-td td_text">transfer</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid ICS20 version</td></tr>
<tr ><td class="module-name-td td_text">transfer</td><td class="error-code-td td_num">5</td><td class="description-td td_text">invalid token amount</td></tr>
<tr ><td class="module-name-td td_text">transfer</td><td class="error-code-td td_num">6</td><td class="description-td td_text">denomination trace not found</td></tr>
<tr ><td class="module-name-td td_text">transfer</td><td class="error-code-td td_num">7</td><td class="description-td td_text">fungible token transfers from this chain are disabled</td></tr>
<tr ><td class="module-name-td td_text">transfer</td><td class="error-code-td td_num">8</td><td class="description-td td_text">fungible token transfers to this chain are disabled</td></tr>
<tr ><td class="module-name-td td_text">transfer</td><td class="error-code-td td_num">9</td><td class="description-td td_text">max transfer channels</td></tr>
<tr ><td class="module-name-td td_text">transfer</td><td class="error-code-td td_num">10</td><td class="description-td td_text">invalid transfer authorization</td></tr>
<tr ><td class="module-name-td td_text">transfer</td><td class="error-code-td td_num">11</td><td class="description-td td_text">invalid memo</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Tx module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/tx_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">tx</td><td class="error-code-td td_num">1</td><td class="description-td td_text">tx parse error</td></tr>
<tr ><td class="module-name-td td_text">tx</td><td class="error-code-td td_num">2</td><td class="description-td td_text">unknown protobuf field</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Txfees module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/txfees_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">txfees</td><td class="error-code-td td_num">1</td><td class="description-td td_text">invalid fee token</td></tr>
<tr ><td class="module-name-td td_text">txfees</td><td class="error-code-td td_num">2</td><td class="description-td td_text">more than one coin in fee</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Undefined module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/undefined_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">undefined</td><td class="error-code-td td_num">1</td><td class="description-td td_text">internal</td></tr>
<tr ><td class="module-name-td td_text">undefined</td><td class="error-code-td td_num">2</td><td class="description-td td_text">stop iterating</td></tr>
<tr ><td class="module-name-td td_text">undefined</td><td class="error-code-td td_num">111222</td><td class="description-td td_text">panic</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Upgrade module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/upgrade_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">upgrade</td><td class="error-code-td td_num">2</td><td class="description-td td_text">module version not found</td></tr>
<tr ><td class="module-name-td td_text">upgrade</td><td class="error-code-td td_num">3</td><td class="description-td td_text">upgrade plan not found</td></tr>
<tr ><td class="module-name-td td_text">upgrade</td><td class="error-code-td td_num">4</td><td class="description-td td_text">upgraded client not found</td></tr>
<tr ><td class="module-name-td td_text">upgrade</td><td class="error-code-td td_num">5</td><td class="description-td td_text">upgraded consensus state not found</td></tr>
<tr ><td class="module-name-td td_text">upgrade</td><td class="error-code-td td_num">6</td><td class="description-td td_text">expected authority account as only signer for proposal message</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Warp module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/warp_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">warp</td><td class="error-code-td td_num">1</td><td class="description-td td_text">not enough collateral</td></tr>
<tr ><td class="module-name-td td_text">warp</td><td class="error-code-td td_num">2</td><td class="description-td td_text">token not found</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Wasm module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/wasm_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">2</td><td class="description-td td_text">create wasm contract failed</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">3</td><td class="description-td td_text">contract account already exists</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">4</td><td class="description-td td_text">instantiate wasm contract failed</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">5</td><td class="description-td td_text">execute wasm contract failed</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">6</td><td class="description-td td_text">insufficient gas</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid genesis</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">8</td><td class="description-td td_text">not found</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">9</td><td class="description-td td_text">query wasm contract failed</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">10</td><td class="description-td td_text">invalid CosmosMsg from the contract</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">11</td><td class="description-td td_text">migrate wasm contract failed</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">12</td><td class="description-td td_text">empty</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">13</td><td class="description-td td_text">exceeds limit</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">14</td><td class="description-td td_text">invalid</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">15</td><td class="description-td td_text">duplicate</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">16</td><td class="description-td td_text">max transfer channels</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">17</td><td class="description-td td_text">unsupported for this contract</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">18</td><td class="description-td td_text">pinning contract failed</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">19</td><td class="description-td td_text">unpinning contract failed</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">20</td><td class="description-td td_text">unknown message from the contract</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">21</td><td class="description-td td_text">invalid event</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">22</td><td class="description-td td_text">no such contract</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">27</td><td class="description-td td_text">max query stack size exceeded</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">28</td><td class="description-td td_text">no such code</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">29</td><td class="description-td td_text">wasmvm error</td></tr>
<tr ><td class="module-name-td td_text">wasm</td><td class="error-code-td td_num">30</td><td class="description-td td_text">max call depth exceeded</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Wasm-hooks module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/wasm-hooks_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">wasm-hooks</td><td class="error-code-td td_num">3</td><td class="description-td td_text">cannot marshal the ICS20 packet</td></tr>
<tr ><td class="module-name-td td_text">wasm-hooks</td><td class="error-code-td td_num">4</td><td class="description-td td_text">invalid packet data</td></tr>
<tr ><td class="module-name-td td_text">wasm-hooks</td><td class="error-code-td td_num">5</td><td class="description-td td_text">cannot create response</td></tr>
<tr ><td class="module-name-td td_text">wasm-hooks</td><td class="error-code-td td_num">6</td><td class="description-td td_text">wasm error</td></tr>
<tr ><td class="module-name-td td_text">wasm-hooks</td><td class="error-code-td td_num">7</td><td class="description-td td_text">bad sender</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

## Xwasm module

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/errors/xwasm_errors.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="module-name-th">module_name</th><th class="error-code-th">error_code</th><th class="description-th">description</th></tr></thead><tbody ><tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">1</td><td class="description-td td_text">invalid gas limit</td></tr>
<tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">2</td><td class="description-td td_text">invalid gas price</td></tr>
<tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">3</td><td class="description-td td_text">invalid contract address</td></tr>
<tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">4</td><td class="description-td td_text">contract already registered</td></tr>
<tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">5</td><td class="description-td td_text">duplicate contract</td></tr>
<tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">6</td><td class="description-td td_text">no contract addresses found</td></tr>
<tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">7</td><td class="description-td td_text">invalid code id</td></tr>
<tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">8</td><td class="description-td td_text">not possible to deduct gas fees</td></tr>
<tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">9</td><td class="description-td td_text">missing granter address</td></tr>
<tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">10</td><td class="description-td td_text">granter address does not exist</td></tr>
<tr ><td class="module-name-td td_text">xwasm</td><td class="error-code-td td_num">11</td><td class="description-td td_text">invalid funding mode</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

