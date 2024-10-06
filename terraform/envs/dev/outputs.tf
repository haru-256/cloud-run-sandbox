output "tfstate_bucket_id" {
  value       = module.tfstate_bucket.tfstate_gcs_bucket_id
  description = "The ID of the bucket used to store terraform state"
}

output "cloud_run_service_name" {
  value       = module.cloud_run.cloudrun_service_name
  description = "The name of the cloud run service"
}

output "cloud_run_service_uri" {
  value       = module.cloud_run.cloudrun_service_uri
  description = "The uri of the cloud run service"
}
