#
# Google Project
#

# Create the Project
resource "google_project" "project" {
  project_id = var.project_id
  name       = coalesce(var.project_name, var.project_id)

  # Set the Project parent to an Organization or Folder
  org_id    = var.org_id
  folder_id = var.folder_id

  # Enable Billing on the Project
  billing_account = var.billing_account

  # Set the Project Labels
  labels = local.labels

  # Do not automatically create a default Compute Network
  auto_create_network = try(var.auto_create_network, false)

  # Do not delete the Project when the Terraform resource is deleted
  deletion_policy = try(var.skip_delete, true) == true ? "ABANDON" : "DELETE"

  lifecycle {
    precondition {
      condition     = var.org_id != null || var.folder_id != null
      error_message = "One of org_id or folder_id must be specified."
    }
    precondition {
      condition     = (var.org_id != null) != (var.folder_id != null)
      error_message = "Only one of org_id or folder_id may be specified."
    }
  }
}
