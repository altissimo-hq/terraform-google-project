variable "gcloud_command" {
  description = "Path to the gcloud cli. Used to list enabled services and service accounts."
  type        = string
  default     = null
}

# Retrieve a list of all service accounts with gcloud
data "external" "gcloud-iam-service-accounts-list" {
  count = var.gcloud_command == null ? 0 : 1
  program = [
    "bash",
    "${path.module}/gcloud.sh",
    var.gcloud_command,
    "--project=${google_project.project.project_id}",
    "iam",
    "service-accounts",
    "list",
  ]
}

# Retrieve a list of all enabled services accounts with gcloud
data "external" "gcloud-services-list" {
  count = var.gcloud_command == null ? 0 : 1
  program = [
    "bash",
    "${path.module}/gcloud.sh",
    var.gcloud_command,
    "--project=${google_project.project.project_id}",
    "services",
    "list",
  ]
}

locals {

  # Retrieve a list of service accounts with gcloud
  gcloud_service_accounts = var.gcloud_command == null ? null : jsondecode(data.external.gcloud-iam-service-accounts-list[0].result.data)

  # Generate a list of service account names
  gcloud_service_account_emails = var.gcloud_command == null ? null : [for service_account in local.gcloud_service_accounts : service_account.email]

  # Retrieve a list of enabled services with gcloud
  gcloud_services = var.gcloud_command == null ? null : jsondecode(data.external.gcloud-services-list[0].result.data)

  # Generate a list of service names
  gcloud_service_names = var.gcloud_command == null ? null : [for service in local.gcloud_services : service.config.name]

  # Generate a list of service account emails
  service_account_emails = [for account in keys(var.service_accounts) : "${account}@${google_project.project.project_id}.iam.gserviceaccount.com"]

}

output "unmanaged_project_services" {
  description = "Google Project Services that are enabled but are not managed by Terraform (list of strings)"
  value       = var.gcloud_command == null ? null : setsubtract(local.gcloud_service_names, var.services)
}

output "unmanaged_service_accounts" {
  description = "Google Service Accounts that exist but are not managed by Terraform (list of strings)"
  value       = var.gcloud_command == null ? null : setsubtract(local.gcloud_service_account_emails, local.service_account_emails)
}
