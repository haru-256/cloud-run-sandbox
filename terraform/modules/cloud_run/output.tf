output "cloudrun_service_name" {
  value       = google_cloud_run_v2_service.service.id
  description = "an identifier for the resource with format"
}

output "cloudrun_service_uri" {
  value       = google_cloud_run_v2_service.service.uri
  description = "The main URI in which this Service is serving traffic."
}
