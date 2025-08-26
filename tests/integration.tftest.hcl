provider "mittwald" {}

variables {
  project_id = "test-project-id"
}

run "create_solr_with_defaults" {
  command = plan

  assert {
    condition     = mittwald_container_stack.solr.project_id == "test-project-id"
    error_message = "Project ID should match the input variable"
  }

  assert {
    condition     = mittwald_container_stack.solr.default_stack == true
    error_message = "Default stack should be enabled"
  }

  assert {
    condition     = mittwald_container_stack.solr.containers["solr"].image == data.mittwald_container_image.solr.image
    error_message = "Container image should match the data source"
  }

  assert {
    condition     = one(mittwald_container_stack.solr.containers["solr"].ports).container_port == 8983
    error_message = "Container port should be 8983"
  }

  assert {
    condition     = one(mittwald_container_stack.solr.containers["solr"].ports).public_port == 8983
    error_message = "Public port should be 8983"
  }

  assert {
    condition     = mittwald_container_stack.solr.containers["solr"].command[0] == "solr-precreate"
    error_message = "Command should start with solr-precreate"
  }

  assert {
    condition     = mittwald_container_stack.solr.containers["solr"].command[1] == "core"
    error_message = "Default core name should be 'core'"
  }

  assert {
    condition     = mittwald_container_stack.solr.containers["solr"].environment["SOLR_HEAP"] == "512m"
    error_message = "Default heap size should be 512m"
  }

  assert {
    condition     = mittwald_container_stack.solr.containers["solr"].environment["SOLR_CONFIG_LIB_ENABLED"] == "true"
    error_message = "SOLR_CONFIG_LIB_ENABLED should be true"
  }

  assert {
    condition     = mittwald_container_stack.solr.volumes["solr-data"] != null
    error_message = "Data volume should be created"
  }
}

run "create_solr_with_custom_values" {
  command = plan

  variables {
    project_id     = "custom-project"
    solr_version   = "8"
    solr_core_name = "custom-core"
    solr_heap      = "2g"
  }

  assert {
    condition     = mittwald_container_stack.solr.project_id == "custom-project"
    error_message = "Project ID should match the custom value"
  }

  assert {
    condition     = data.mittwald_container_image.solr.image == "solr:8"
    error_message = "Solr version should be 8"
  }

  assert {
    condition     = mittwald_container_stack.solr.containers["solr"].command[1] == "custom-core"
    error_message = "Core name should be 'custom-core'"
  }

  assert {
    condition     = mittwald_container_stack.solr.containers["solr"].environment["SOLR_HEAP"] == "2g"
    error_message = "Heap size should be 2g"
  }
}

run "validate_outputs" {
  command = plan

  assert {
    condition     = output.url == "https://solr:8983"
    error_message = "URL output should be correctly formatted"
  }
}

run "validate_required_modules" {
  command = plan

  assert {
    condition     = contains(keys(mittwald_container_stack.solr.containers["solr"].environment), "SOLR_MODULES")
    error_message = "SOLR_MODULES environment variable should be set"
  }

  assert {
    condition     = contains(split(",", mittwald_container_stack.solr.containers["solr"].environment["SOLR_MODULES"]), "scripting")
    error_message = "Scripting module should be enabled"
  }

  assert {
    condition     = contains(split(",", mittwald_container_stack.solr.containers["solr"].environment["SOLR_MODULES"]), "analytics")
    error_message = "Analytics module should be enabled"
  }
}