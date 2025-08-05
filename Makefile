# Repository versions and URLs
COSMOS_SDK_VERSION := v0.50.13-evm-comet1-inj.4
COSMOS_SDK_REPO := https://github.com/InjectiveLabs/cosmos-sdk.git

INJECTIVE_CORE_VERSION := master
INJECTIVE_CORE_REPO := https://github.com/InjectiveLabs/injective-core.git

INDEXER_VERSION := v1.16.54
INDEXER_REPO := https://github.com/InjectiveLabs/injective-indexer.git

IBC_GO_VERSION := v8.7.0-evm-comet1-inj
IBC_GO_REPO := https://github.com/InjectiveLabs/ibc-go.git

COMETBFT_VERSION := v1.0.1-inj.2
COMETBFT_REPO := https://github.com/InjectiveLabs/cometbft.git

PYTHON_SDK_VERSION := v1.11.0
PYTHON_SDK_REPO := https://github.com/InjectiveLabs/sdk-python.git

GO_SDK_VERSION := v1.58.0
GO_SDK_REPO := https://github.com/InjectiveLabs/sdk-go.git

# Temporary directories
TEMP_DIR := /tmp/injective-docs-repos
COSMOS_SDK_DIR := $(TEMP_DIR)/cosmos-sdk
INJECTIVE_CORE_DIR := $(TEMP_DIR)/injective-core
INDEXER_DIR := $(TEMP_DIR)/injective-indexer
IBC_GO_DIR := $(TEMP_DIR)/ibc-go
COMETBFT_DIR := $(TEMP_DIR)/cometbft
PYTHON_SDK_DIR := tmp-python-sdk
GO_SDK_DIR := tmp-go-sdk

clone-sdk-repos:
	@echo "Cloning SDK repositories..."
	@git clone -q --depth 1 --branch $(PYTHON_SDK_VERSION) $(PYTHON_SDK_REPO) $(PYTHON_SDK_DIR)
	@git clone -q --depth 1 --branch $(GO_SDK_VERSION) $(GO_SDK_REPO) $(GO_SDK_DIR)
	@echo "SDK repositories cloned successfully!"

clean-sdk-repos:
	@echo "Cleaning up SDK repositories..."
	@rm -rf $(PYTHON_SDK_DIR)
	@rm -rf $(GO_SDK_DIR)
	@echo "SDK repositories cleaned successfully!"

# Documentation targets
refresh-examples:
	@$(MAKE) clone-sdk-repos
	markdown-autodocs -c code-block -c json-to-html-table -o source/includes/*.md
	@$(MAKE) clean-sdk-repos

# Internal targets without repository management
_update-errors:
	@echo "Updating error documentation from repositories..."
	@./scripts/extract_errors.sh $(COSMOS_SDK_DIR) $(INJECTIVE_CORE_DIR)
	@echo "Generating markdown documentation..."
	@./scripts/generate_errors_md.sh

_update-proto:
	@echo "Generating proto JSON files..."
	@./scripts/generate_proto_json_files.sh $(COSMOS_SDK_DIR) $(INJECTIVE_CORE_DIR) $(INDEXER_DIR) $(IBC_GO_DIR) $(COMETBFT_DIR)

# Public targets with repository management
update-errors-documentation:
	@$(MAKE) clone-repos
	@$(MAKE) _update-errors
	@$(MAKE) clean-repos

update-proto-json:
	@$(MAKE) clone-repos
	@$(MAKE) _update-proto
	@$(MAKE) clean-repos

# Repository management targets
clone-repos:
	@echo "Cloning repositories..."
	@rm -rf $(TEMP_DIR)
	@mkdir -p $(TEMP_DIR)
	@git clone -q --depth 1 --branch $(COSMOS_SDK_VERSION) $(COSMOS_SDK_REPO) $(COSMOS_SDK_DIR)
	@git clone -q --depth 1 --branch $(INJECTIVE_CORE_VERSION) $(INJECTIVE_CORE_REPO) $(INJECTIVE_CORE_DIR)
	@git clone -q --depth 1 --branch $(INDEXER_VERSION) $(INDEXER_REPO) $(INDEXER_DIR)
	@git clone -q --depth 1 --branch $(IBC_GO_VERSION) $(IBC_GO_REPO) $(IBC_GO_DIR)
	@git clone -q --depth 1 --branch $(COMETBFT_VERSION) $(COMETBFT_REPO) $(COMETBFT_DIR)

clean-repos:
	@echo "Cleaning up repositories..."
	@rm -rf $(TEMP_DIR)

# Combined documentation update target
update-all-proto-related-files:
	@$(MAKE) clone-repos
	@echo "Updating all documentation..."
	@$(MAKE) -s _update-proto
	@$(MAKE) -s _update-errors
	@$(MAKE) clean-repos
	@echo "All documentation has been updated successfully!"

# Declare all phony targets at once
.PHONY: refresh-examples update-errors-documentation update-proto-json clone-repos clean-repos clone-sdk-repos clean-sdk-repos update-all-docs _update-errors _update-proto update-all-proto-related-files
