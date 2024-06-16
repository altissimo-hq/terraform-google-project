locals {

  # Create a map of default labels to apply
  default_labels = {
    billing = lower(var.billing_account),
  }

  # Merge the default labels with the user-defined labels
  labels = merge(local.default_labels, var.labels)

  id     = google_project.project.project_id
  number = google_project.project.number

  # Replace the PROJECT_NUMBER and PROJECT_ID placeholders in the IAM Policy
  # Add service account roles to the IAM Policy
  iam_policy = var.iam_policy == null ? {} : {
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

  sa_bindings = transpose({
    for account, config in var.service_accounts : account => coalesce(config.roles, [])
  })

  # Retrieve a list of service accounts with gcloud
  gcloud_service_accounts = var.gcloud_command == null ? null : jsondecode(data.external.gcloud_iam_service_accounts_list[0].result.data)

  # Generate a list of service account names
  gcloud_service_account_emails = var.gcloud_command == null ? null : [
    for service_account in local.gcloud_service_accounts : service_account.email
  ]

  # Retrieve a list of enabled services with gcloud
  gcloud_services = var.gcloud_command == null ? null : jsondecode(data.external.gcloud_services_list[0].result.data)

  # Generate a list of service names
  forbidden_services = [
    "bigquery-json.googleapis.com",
    "dataproc-control.googleapis.com",
    "source.googleapis.com",
    "stackdriverprovisioning.googleapis.com",
  ]
  gcloud_service_names = var.gcloud_command == null ? null : [
    for service in local.gcloud_services : service.config.name if contains(local.forbidden_services, service.config.name)
  ]

  # Generate a list of service account emails
  service_account_emails = [
    for account in keys(var.service_accounts) : "${account}@${google_project.project.project_id}.iam.gserviceaccount.com"
  ]

}
