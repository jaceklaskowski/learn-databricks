terraform {
  # Each argument in the required_providers block enables one provider
  # The key determines the provider's local name (its unique identifier within this module)
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version >= "1.19.0"
    }
  }

  required_version = ">= 1.5.0"
}

# https://developer.hashicorp.com/terraform/language/providers/configuration#default-provider-configurations
# A provider block without an alias argument is the default configuration for that provider.
# Resources that don't set the provider meta-argument
# will use the default provider configuration that matches the first word of the resource type name.
# E.g. databricks_repo, databricks_pipeline below
provider "databricks" {}

resource "databricks_repo" "learn_databricks" {
  url = "https://github.com/jaceklaskowski/learn-databricks"
}

resource "databricks_pipeline" "this" {
  name = "My Terraform-deployed DLT Pipeline"
  library {
    notebook {
      path = "${databricks_repo.learn_databricks.path}/Delta Live Tables/my_streaming_table"
    }
  }
}
