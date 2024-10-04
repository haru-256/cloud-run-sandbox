terraform {
  required_version = "~>1.9.7"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>6.5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~>6.5.0"
    }
  }

  backend "gcs" {
    bucket = "haru256-sandbox-20241005-tfstate"
  }
}
