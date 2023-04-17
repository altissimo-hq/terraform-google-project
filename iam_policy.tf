#
# Project IAM Policy
#

locals {

  id     = google_project.project.project_id
  number = google_project.project.number

  # Replace the PROJECT_NUMBER and PROJECT_ID placeholders in the IAM Policy
  # Add service account roles to the IAM Policy
  iam_policy = {
    for role, members in var.iam_policy : role => sort(distinct(concat([
      for member in members : replace(
        replace(
          member,
          "PROJECT_NUMBER",
          local.number
        ),
        "PROJECT_ID",
      local.id)
      ], [
      for member in try(local.sa_bindings[role], []) : "serviceAccount:${member}@${local.id}.iam.gserviceaccount.com"
    ])))
  }

  sa_bindings = transpose({ for account, config in var.service_accounts : account => coalesce(config.roles, []) })

}

# Define the IAM Policy object to set on the Project
data "google_iam_policy" "project" {
  dynamic "binding" {
    for_each = local.iam_policy
    content {
      role    = binding.key
      members = binding.value
    }
  }
}

# Set the IAM Policy on the Project
resource "google_project_iam_policy" "project" {
  project     = google_project.project.project_id
  policy_data = data.google_iam_policy.project.policy_data
}

output "project_iam_policy" {
  description = "Google Project IAM Policy (list of binding objects)"
  value       = jsondecode(data.google_iam_policy.project.policy_data)
}

variable "iam_policy" {
  description = "Map of Google Project IAM Policy Roles and Members"
  type        = map(list(string))
  default     = {}
}
