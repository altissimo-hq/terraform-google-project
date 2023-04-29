#
# Project IAM Policy
#

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
  count       = var.iam_policy == null ? 0 : 1
  project     = google_project.project.project_id
  policy_data = data.google_iam_policy.project.policy_data
}
