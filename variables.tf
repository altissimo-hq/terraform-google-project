variable "auto_create_network" {
  description = "Automatically create a default VPC network (defaults to false)"
  type        = bool
  default     = false
}

variable "billing_account" {
  description = "Billing Account ID (defaults to null if not specified)"
  type        = string
  default     = null
}

variable "folder_id" {
  description = "Parent Google Folder ID (only one of org_id or folder_id may be specified)"
  type        = string
  default     = null
}

variable "iam_policy" {
  description = "Map of Google Project IAM Policy Roles and Members"
  type        = map(list(string))
  default     = {}
}

variable "labels" {
  description = "A map of labels to assign to the project"
  type        = map(string)
  default     = {}
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

variable "skip_delete" {
  description = "Skip deletion of the Project when the Terraform resource is deleted (defaults to true)"
  type        = bool
  default     = true
}
