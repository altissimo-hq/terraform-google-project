#
# Google Project Services
#

# Enable Project Services
resource "google_project_service" "services" {
  for_each = toset(var.services)
  project  = google_project.project.project_id
  service  = each.key

  disable_dependent_services = true
  disable_on_destroy         = true
}

variable "services" {
  description = "List of Google Project Services to Enable"
  type        = list(string)
  default     = []
}
