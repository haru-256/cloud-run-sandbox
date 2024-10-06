variable "gcp_project_id" {
  type        = string
  description = "The ID for your GCP project"
}

variable "region" {
  type        = string
  description = "The region for the repository"
}

variable "cloud_run_name" {
  type        = string
  description = "The name of the cloud run service"
}

variable "image_name" {
  type        = string
  description = "The image name of the cloud run service"
}

variable "allowed_users" {
  type        = list(string)
  description = "The list of users to grant access to the cloud run service"
}
