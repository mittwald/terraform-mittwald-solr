# Simple usage example

This example shows a minimal usage of the `mittwald/solr/mittwald` module.

It will provision a Solr instance in a container, which will then be available for internal use in your hosting environment. To connect to your Solr instance, use the `module.solr.url` output variable.

```hcl
module "solr" {
  source = "mittwald/solr/mittwald"

  project_id = var.project_id
}
```

## Configuration options

The module supports several configuration variables:

- `solr_version`: The Solr version to install (default: "9")
- `solr_core_name`: Name of the Solr core to create (default: "core")
- `solr_heap`: Heap size for Solr, e.g., '2g' for 2 gigabytes or '512m' for 512 megabytes (default: "512m")

```hcl
module "solr" {
  source = "mittwald/solr/mittwald"

  project_id = var.project_id
  solr_version = "9"
  solr_core_name = "products"
  solr_heap = "2g"
}
```

## Connecting a domain with virtualhost

To make your Solr instance accessible from the internet via a custom domain, you can use the `mittwald_virtualhost` resource. This example shows how to connect a domain to your Solr instance:

```hcl
resource "mittwald_virtualhost" "solr" {
  project_id = var.project_id
  hostname   = "solr.example"
  
  paths = {
    "/" = {
      container = {
        container_id = module.solr.container_id
        port = "8983/tcp"
      }
    }
  }
}
```

After applying this configuration, your Solr instance will be accessible at `https://solr.example.com`. The module's `container_id` output is used to connect the virtualhost to the Solr container, and traffic to the domain will be routed to the Solr service running on port 8983.