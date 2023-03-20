terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.13.0"
    }
  }

  required_version = ">= 1.4.0"
}

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
