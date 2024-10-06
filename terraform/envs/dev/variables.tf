variable "gcp_project_id" {
  type        = string
  description = "The ID of GCP project"
}

variable "gcp_default_region" {
  type        = string
  description = "The name of GCP default region"
}

variable "image_name" {
  type        = string
  description = "The name of the cloud run image"
}

variable "owner_member_email" {
  type        = string
  description = "The email of the owner member"
}
