variable "project_id" {
  type        = string
  description = "Project ID in which to start OpenSearch"
}

variable "solr_version" {
  type        = string
  default     = "9"
  description = "Solr version to install; this needs to be a valid tag from https://hub.docker.com/r/solr/tags"
}

variable "solr_core_name" {
  type        = string
  default     = "core"
  description = "Name of the Solr core to create"
}

variable "solr_heap" {
  type        = string
  default     = "512m"
  description = "Heap size for Solr, e.g., '2g' for 2 gigabytes or '512m' for 512 megabytes"
}