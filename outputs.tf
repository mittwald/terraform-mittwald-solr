output "url" {
  value = local.url
  description = "The internal URL at which the Solr endpoint will be available."
}

output "container_id" {
  value = resource.mittwald_container_stack.solr.containers[local.container_name].id
  description = "The ID of the Solr container. This might be useful when wanting to connect a virtualhost to this container for external access."
}

output "stack_id" {
  value = resource.mittwald_container_stack.solr.id
  description = "The ID of the Solr container stack."
}