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
module "artifact_registory_repository" {
  source                 = "../../modules/artifact_registory_repository"
  gcp_project_id         = data.google_project.project.project_id
  region                 = "us-central1"
  repository_id          = "logging"
  repository_description = "logging repository"
}

module "cloud_run" {
  source         = "../../modules/cloud_run"
  gcp_project_id = data.google_project.project.project_id
  region         = "us-central1"
  cloud_run_name = "logging"
  image_name     = var.image_name
  allowed_users  = [var.owner_member_email]
}
