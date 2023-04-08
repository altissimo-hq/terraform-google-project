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

# Return a map of all the service accounts that were created
output "service_accounts" {
  description = "Google Service Accounts (map of objects)"
  value = {
    for account in keys(google_service_account.service_account) : account => google_service_account.service_account[account]
  }
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
