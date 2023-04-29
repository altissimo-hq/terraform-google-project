output "number" {
  description = "Google Project Number (string)"
  value       = google_project.project.number
}

output "project_id" {
  description = "Google Project ID (string)"
  value       = google_project.project.project_id
}

output "project_number" {
  description = "Google Project Number (string) [deprecated - use number instead]"
  value       = google_project.project.number
}

output "project_iam_policy" {
  description = "Google Project IAM Policy (list of binding objects)"
  value       = jsondecode(data.google_iam_policy.project.policy_data)
}

output "unmanaged_project_services" {
  description = "Google Project Services that are enabled but are not managed by Terraform (list of strings)"
  value       = var.gcloud_command == null ? null : setsubtract(local.gcloud_service_names, var.services)
}

output "unmanaged_service_accounts" {
  description = "Google Service Accounts that exist but are not managed by Terraform (list of strings)"
  value       = var.gcloud_command == null ? null : setsubtract(local.gcloud_service_account_emails, local.service_account_emails)
}
