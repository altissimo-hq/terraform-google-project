#
# Google Service Accounts
#

# Create the Service Accounts
resource "google_service_account" "service_account" {
  for_each     = var.service_accounts
  project      = google_project.project.project_id
  account_id   = each.key
  display_name = try(each.value.display_name, each.key)

  disabled = try(each.value.disabled, false)
}

variable "service_accounts" {
  description = "Map of Google Service Accounts to Create"
  type = map(object({
    display_name = optional(string)
    disabled     = optional(bool)
    roles        = optional(list(string))
  }))
  default = {}
}
