terraform {
  required_version = ">=1.0.0"

  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = ">=1.21.0"
    }
    http = {
      source  = "hashicorp/http"
      version = ">=3.4.0"
    }
  }
}
