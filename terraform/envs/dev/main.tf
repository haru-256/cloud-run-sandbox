# google cloud project
data "google_project" "project" {
  project_id = var.gcp_project_id
}

# create the bucket for terraform state
module "tfstate_bucket" {
  source         = "../../modules/tfstate_gcs_bucket"
  gcp_project_id = data.google_project.project.project_id
}

# logging repository
module "artifact_registry_repository" {
  source         = "../../modules/artifact_registry_repository"
  gcp_project_id = data.google_project.project.project_id
  region         = "us-central1"
  repository_id  = "logging"
  description    = "logging repository"
}
