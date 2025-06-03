# Repository versions and URLs
COSMOS_SDK_VERSION := v0.50.13-evm-comet1-inj.3
COSMOS_SDK_REPO := https://github.com/InjectiveLabs/cosmos-sdk.git

INJECTIVE_CORE_VERSION := v1.16.0-beta.2
INJECTIVE_CORE_REPO := https://github.com/InjectiveLabs/injective-core.git

INDEXER_VERSION := v1.16.3
INDEXER_REPO := https://github.com/InjectiveLabs/injective-indexer.git

# Temporary directories
TEMP_DIR := /tmp/injective-docs-repos
COSMOS_SDK_DIR := $(TEMP_DIR)/cosmos-sdk
INJECTIVE_CORE_DIR := $(TEMP_DIR)/injective-core
INDEXER_DIR := $(TEMP_DIR)/injective-indexer

# Declare all phony targets at once
.PHONY: refresh-examples update-errors-documentation update-proto-json clone-repos clean-repos update-all-docs _update-errors _update-proto

# Documentation targets
refresh-examples:
	markdown-autodocs -c code-block -c json-to-html-table -o source/includes/*.md

# Internal targets without repository management
_update-errors:
	@echo "Updating error documentation from repositories..."
	@./scripts/extract_errors.sh $(COSMOS_SDK_DIR) $(INJECTIVE_CORE_DIR)
	@echo "Generating markdown documentation..."
	@./scripts/generate_errors_md.sh

_update-proto:
	@echo "Generating proto JSON files..."
	@./scripts/generate_proto_json_files.sh $(COSMOS_SDK_DIR) $(INJECTIVE_CORE_DIR) $(INDEXER_DIR)

# Public targets with repository management
update-errors-documentation:
	@$(MAKE) clone-repos
	@$(MAKE) _update-errors
	@$(MAKE) clean-repos

update-proto-json:
	@$(MAKE) clone-repos
	@$(MAKE) _update-proto
	@$(MAKE) clean-repos

# Combined documentation update target
update-all-proto-related-files:
	@$(MAKE) clone-repos
	@echo "Updating all documentation..."
	@$(MAKE) -s _update-proto
	@$(MAKE) -s _update-errors
	@$(MAKE) clean-repos
	@echo "All documentation has been updated successfully!"

# Repository management targets
clone-repos:
	@echo "Cloning repositories..."
	@rm -rf $(TEMP_DIR)
	@mkdir -p $(TEMP_DIR)
	@git clone -q --depth 1 --branch $(COSMOS_SDK_VERSION) $(COSMOS_SDK_REPO) $(COSMOS_SDK_DIR)
	@git clone -q --depth 1 --branch $(INJECTIVE_CORE_VERSION) $(INJECTIVE_CORE_REPO) $(INJECTIVE_CORE_DIR)
	@git clone -q --depth 1 --branch $(INDEXER_VERSION) $(INDEXER_REPO) $(INDEXER_DIR)

clean-repos:
	@echo "Cleaning up repositories..."
	@rm -rf $(TEMP_DIR)
