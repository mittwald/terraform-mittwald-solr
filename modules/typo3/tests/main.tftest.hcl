provider "mittwald" {}

variables {
  project_id = "test-project-id"
}

run "typo3_solr_ssh_vars" {
  command = plan

  variables {
    solr_stack_id             = "test-stack-id"
    solr_container_id         = "test-container-id"
    solr_core_name            = "testcore"
    solr_core_language        = "english"
    typo3_solr_version        = "13.0.3"
    typo3_solr_plugin_version = "6.0.0"
    ssh_user                  = "testuser"
    ssh_private_key           = "test-private-key"
  }

  assert {
    condition     = mittwald_remote_file.typo3_solr_files["solrconfig.xml"].ssh_user == "testuser"
    error_message = "ssh_user should be set correctly in mittwald_remote_file.typo3_solr_files"
  }
  assert {
    condition     = mittwald_remote_file.typo3_solr_files["solrconfig.xml"].ssh_private_key == "test-private-key"
    error_message = "ssh_private_key should be set correctly in mittwald_remote_file.typo3_solr_files"
  }
  assert {
    condition     = mittwald_remote_file.core_properties.ssh_user == "testuser"
    error_message = "ssh_user should be set correctly in mittwald_remote_file.core_properties"
  }
  assert {
    condition     = mittwald_remote_file.core_properties.ssh_private_key == "test-private-key"
    error_message = "ssh_private_key should be set correctly in mittwald_remote_file.core_properties"
  }
  assert {
    condition     = mittwald_remote_file.typo3_solr_plugin.ssh_user == "testuser"
    error_message = "ssh_user should be set correctly in mittwald_remote_file.typo3_solr_plugin"
  }
  assert {
    condition     = mittwald_remote_file.typo3_solr_plugin.ssh_private_key == "test-private-key"
    error_message = "ssh_private_key should be set correctly in mittwald_remote_file.typo3_solr_plugin"
  }
}