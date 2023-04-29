variable "gcloud_command" {
  description = "Path to the gcloud cli. Used to list enabled services and service accounts."
  type        = string
  default     = null
}

# Retrieve a list of all service accounts with gcloud
data "external" "gcloud_iam_service_accounts_list" {
  count = var.gcloud_command == null ? 0 : 1
  program = [
    "bash",
    "${path.module}/scripts/gcloud.sh",
    var.gcloud_command,
    "--project=${google_project.project.project_id}",
    "iam",
    "service-accounts",
    "list",
  ]
}

# Retrieve a list of all enabled services accounts with gcloud
data "external" "gcloud_services_list" {
  count = var.gcloud_command == null ? 0 : 1
  program = [
    "bash",
    "${path.module}/scripts/gcloud.sh",
    var.gcloud_command,
    "--project=${google_project.project.project_id}",
    "services",
    "list",
  ]
}
