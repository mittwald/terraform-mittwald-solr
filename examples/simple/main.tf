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

output "solr_url" {
  value       = module.solr.url
  description = "The internal URL at which the Solr endpoint will be available."
}

output "solr_container_id" {
  value       = module.solr.container_id
  description = "The ID of the Solr container."
}