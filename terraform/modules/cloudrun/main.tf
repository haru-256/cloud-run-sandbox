# allow to use the google cloud service api
resource "google_project_service" "services" {
  for_each = ["run.googleapis.com"]

  project            = var.gcp_project_id
  service            = each.value
  disable_on_destroy = true
}

# wait for the service to be enabled
resource "time_sleep" "wait_120_seconds" {
  depends_on      = [google_project_service.services]
  create_duration = "120s"
}
