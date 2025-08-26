// might also be obtained by creating a mittwald_project resource
variable "project_id" {
  type = string
}

module "solr" {
  source = "mittwald/solr/mittwald"

  project_id = var.project_id

  solr_version   = "9"
  solr_core_name = "mycore"
  solr_heap      = "1g"
}

module "solr_typo3" {
  source = "mittwald/solr/mittwald//modules/typo3"

  solr_stack_id      = module.solr.stack_id
  solr_container_id  = module.solr.container_id
  solr_core_name     = module.solr.solr_core_name
  solr_core_language = "english" // or "german", etc.

  typo3_solr_version        = "13.0.3"
  typo3_solr_plugin_version = "6.0.0"
}

output "solr_url" {
  value       = module.solr.url
  description = "The internal URL at which the Solr endpoint will be available."
}

output "solr_container_id" {
  value       = module.solr.container_id
  description = "The ID of the Solr container."
}