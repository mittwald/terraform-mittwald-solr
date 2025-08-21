variable "solr_config" {
    type = string
    description = "Contents of the solrconfig.xml configuration file; will be uploaded to the Solr core configuration directory"
}

variable "solr_schema" {
    type = string
    description = "Contents of the schema.xml configuration file; will be uploaded to the Solr core configuration directory"
}

variable "solr_stack_id" {
    type = string
    description = "ID of the Solr container stack"
    nullable = false
}

variable "solr_container_id" {
    type = string
    description = "ID of the Solr container"
    nullable = false
}

variable "solr_core_name" {
    type = string
    description = "Name of the Solr core to create"
    default = "core"
}