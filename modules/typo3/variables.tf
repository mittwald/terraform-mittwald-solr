variable "solr_stack_id" {
  type        = string
  description = "ID of the Solr container stack"
  nullable    = false
}

variable "solr_container_id" {
  type        = string
  description = "ID of the Solr container"
  nullable    = false
}

variable "solr_core_name" {
  type        = string
  description = "Name of the Solr core to create"
  default     = "core"
}

variable "solr_core_language" {
  type        = string
  description = "Language of the Solr core, e.g., 'english' for English or 'german' for German"
}

variable "typo3_solr_version" {
  type        = string
  description = "Version of the TYPO3 Solr extension to use"
  default     = "13.0.3"
}

variable "typo3_solr_plugin_version" {
  type        = string
  description = "Version of the TYPO3 Solr plugin to use. Note: This should match the plugin version shipped with the EXT:solr version."
  default     = "6.0.0"
}

variable "ssh_user" {
  type        = string
  description = "SSH user for accessing the server; when omitted, this will default to the logged-in mStudio user"
  nullable    = true
  default     = null
}

variable "ssh_private_key" {
  type        = string
  description = "SSH private key for accessing the server; when omitted, this will default to ~/.ssh/id_rsa. Important: This variable should contain the actual private key contents, not the path to the key file. Use the file function to load the key contents from a file."
  nullable    = true
  default     = null
  sensitive   = true
}