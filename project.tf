#
# Google Project
#

# Create the Project
resource "google_project" "project" {
  project_id = var.project_id
  name       = try(var.project_name, var.project_id)

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
  skip_delete = try(var.skip_delete, true)

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

locals {

  # Create a map of default labels to apply
  default_labels = {
    billing = lower(var.billing_account),
  }

  # Merge the default labels with the user-defined labels
  labels = merge(local.default_labels, var.labels)

}

output "project_id" {
  description = "Google Project ID (string)"
  value       = google_project.project.project_id
}

output "project_number" {
  description = "Google Project Number (string)"
  value       = google_project.project.number
}

variable "project_id" {
  description = "Google Project ID"
  type        = string
}

variable "project_name" {
  description = "Google Project Display Name (defaults to project_id if not specified))"
  type        = string
  default     = null
}

variable "org_id" {
  description = "Parent Google Organization ID (only one of org_id or folder_id may be specified)"
  type        = string
  default     = null
}

variable "folder_id" {
  description = "Parent Google Folder ID (only one of org_id or folder_id may be specified)"
  type        = string
  default     = null
}

variable "billing_account" {
  description = "Billing Account ID (defaults to null if not specified)"
  type        = string
  default     = null
}

variable "labels" {
  description = "A map of labels to assign to the project"
  type        = map(string)
  default     = {}
}

variable "auto_create_network" {
  description = "Automatically create a default VPC network (defaults to false)"
  type        = bool
  default     = false
}

variable "skip_delete" {
  description = "Skip deletion of the Project when the Terraform resource is deleted (defaults to true)"
  type        = bool
  default     = true
}
