terraform {
  required_providers {
    mittwald = {
      source = "mittwald/mittwald"
      version = "1.3.0"
    }

    http = {
      source = "hashicorp/http"
      version = "~> 3.5"
    }
  }
}

locals {
  plugin_version = "6.0.0"
  download_files = toset([
    "${var.solr_core_language}/schema.xml",
    "${var.solr_core_language}/${var.solr_core_language}-common-nouns.txt",
    "${var.solr_core_language}/protwords.txt",
    "solrconfig.xml",
    "general_schema_fields.xml",
    "general_schema_types.xml",
    "currency.xml",
    "elevate.xml"
  ])
}

data "http" "typo3_solr_files" {
  for_each = local.download_files
  url = "https://raw.githubusercontent.com/TYPO3-Solr/ext-solr/refs/heads/${var.typo3_solr_version}/Resources/Private/Solr/configsets/ext_solr_13_0_0/conf/${each.value}"
}

resource "mittwald_remote_file" "typo3_solr_files" {
  stack_id = var.solr_stack_id
  container_id = var.solr_container_id
  for_each = local.download_files

  contents = data.http.typo3_solr_files[each.key].response_body
  path = "/var/solr/data/${var.solr_core_name}/conf/${each.value}"
}

resource "mittwald_remote_file" "core_properties" {
  stack_id = var.solr_stack_id
  container_id = var.solr_container_id

  contents = <<EOT
name=${var.solr_core_name}
schema=${var.solr_core_language}/schema.xml
EOT
  path = "/var/solr/data/${var.solr_core_name}/core.properties"
}

resource "mittwald_remote_file" "typo3_solr_plugin" {
  stack_id = var.solr_stack_id
  container_id = var.solr_container_id

  contents_from_url = "https://github.com/TYPO3-Solr/ext-solr/raw/refs/heads/${var.typo3_solr_version}/Resources/Private/Solr/typo3lib/solr-typo3-plugin-${local.plugin_version}.jar"
  path = "/var/solr/data/${var.solr_core_name}/lib/solr-typo3-plugin-${local.plugin_version}.jar"
}