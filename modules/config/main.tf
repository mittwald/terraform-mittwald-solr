terraform {
  required_providers {
    mittwald = {
      source = "mittwald/mittwald"
      version = "~> 1.4"
    }
  }
}

resource "mittwald_remote_file" "solrconfig" {
  stack_id = var.solr_stack_id
  container_id = var.solr_container_id

  contents = var.solr_config
  path = "/var/solr/${var.solr_core_name}/conf/solrconfig.xml"
}

resource "mittwald_remote_file" "schema" {
  stack_id = var.solr_stack_id
  container_id = var.solr_container_id

  contents = var.solr_schema
  path = "/var/solr/${var.solr_core_name}/conf/schema.xml"
}