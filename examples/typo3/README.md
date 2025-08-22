# Solr with TYPO3 Integration Example

This example demonstrates how to use the Mittwald Solr Terraform module to set up Apache Solr with TYPO3-specific configuration. The setup includes both the main Solr module and the specialized TYPO3 submodule for seamless integration with TYPO3 CMS.

## Overview

This configuration creates:
- A Solr instance with your specified version
- A Solr core with TYPO3-optimized configuration
- TYPO3-specific schema and plugin setup
- All necessary configurations for TYPO3's EXT:solr extension

## Prerequisites

- Terraform >= 0.14
- Access to a Mittwald project
- TYPO3 installation that will connect to this Solr instance

## Usage

### Basic Configuration

```terraform
// might also be obtained by creating a mittwald_project resource
variable "project_id" {
  type = string
}

module "solr" {
  source = "mittwald/solr/mittwald"

  project_id = var.project_id
  
  solr_version = "9"
  solr_core_name = "mycore"
  solr_heap = "1g"
}

module "solr_typo3" {
  source = "mittwald/solr/mittwald/modules/typo3"

  solr_stack_id = module.solr.stack_id
  solr_container_id = module.solr.container_id
  solr_core_name = module.solr.solr_core_name
  solr_core_language = "english" // or "german", etc.

  typo3_solr_version = "13.0.3"
  typo3_solr_plugin_version = "6.0.0"
}
```

### Multiple Language Support

For multi-language TYPO3 sites, you may need multiple cores:

```terraform
module "solr_english" {
  source = "mittwald/solr/mittwald/modules/typo3"
  
  # ... connection parameters ...
  solr_core_name = "english_core"
  solr_core_language = "english"
}

module "solr_german" {
  source = "mittwald/solr/mittwald/modules/typo3"
  
  # ... connection parameters ...
  solr_core_name = "german_core"
  solr_core_language = "german"
}
```
