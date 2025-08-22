terraform {
  required_providers {
    mittwald = {
      source = "mittwald/mittwald"
      version = "~> 1.4"
    }
  }
}

locals {
    container_name = "solr"
    container_api_port = 8983

    volume_data_name = "solr-data"

    url = "https://${local.container_name}:${local.container_api_port}"
}

data "mittwald_container_image" "solr" {
  image = "solr:${var.solr_version}"
}

resource "mittwald_container_stack" "solr" {
  project_id = var.project_id
  default_stack = true

  containers = {
    (local.container_name) = {
      image = data.mittwald_container_image.solr.image
      description = "Solr"
      ports = [
        {
          container_port = local.container_api_port
          public_port = local.container_api_port
          protocol = "tcp"
        }
      ]

      entrypoint = data.mittwald_container_image.solr.entrypoint
      command = ["solr-precreate", var.solr_core_name]

      environment = {
        "SOLR_HEAP" = var.solr_heap
        "SOLR_CONFIG_LIB_ENABLED" = "true"
        "SOLR_MODULES" = "scripting,analytics,analysis-extras,langid,clustering,extraction"
      }

      volumes = [
        {
          volume = local.volume_data_name
          mount_path = "/var/solr"
        }
      ]
    }
  }

  volumes = {
    (local.volume_data_name) = {}
  }
}