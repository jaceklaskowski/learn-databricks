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
