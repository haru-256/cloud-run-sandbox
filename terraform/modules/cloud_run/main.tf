# allow to use the google cloud service api
resource "google_project_service" "services" {
  for_each = toset(["run.googleapis.com"])

  project            = var.gcp_project_id
  service            = each.value
  disable_on_destroy = true
}

# wait for the service to be enabled
resource "time_sleep" "wait_120_seconds" {
  depends_on      = [google_project_service.services]
  create_duration = "120s"
}

# cloud run
resource "google_cloud_run_v2_service" "service" {
  name                = var.cloud_run_name
  location            = var.region
  project             = var.gcp_project_id
  deletion_protection = false

  # Cloud Run denies all traffic from unauthenticated member.
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.image_name
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
      ports {
        container_port = 8080
      }
      env {
        name  = "LOG_LEVEL"
        value = "info"
      }
    }
    scaling {
      min_instance_count = 0
      max_instance_count = 1
    }
  }

  depends_on = [time_sleep.wait_120_seconds]
}

# allow access to the cloud run service
resource "google_cloud_run_service_iam_member" "cloudrun" {
  for_each = toset([for user in var.allowed_users : "user:${user}"])

  location = google_cloud_run_v2_service.service.location
  project  = var.gcp_project_id
  service  = google_cloud_run_v2_service.service.name
  role     = "roles/run.invoker"
  member   = each.value
}
