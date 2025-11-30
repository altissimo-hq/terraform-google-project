# Altissimo - Google Project (Terraform Module)

The repo contains a terraform module for creating a Google Cloud Platform (GCP) project.

In addition to creating the project, this module will enable project services, create service accounts, and manage the project IAM policy.

`altissimo-hq/terraform-google-project`

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_external"></a> [external](#requirement\_external) | >= 2.2.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.42.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | >= 2.2.0 |
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.42.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_policy.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_policy) | resource |
| [google_project_service.services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [external_external.gcloud_iam_service_accounts_list](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.gcloud_services_list](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [google_iam_policy.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_network"></a> [auto\_create\_network](#input\_auto\_create\_network) | Automatically create a default VPC network (defaults to false) | `bool` | `false` | no |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | Billing Account ID (defaults to null if not specified) | `string` | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Parent Google Folder ID (only one of org\_id or folder\_id may be specified) | `string` | `null` | no |
| <a name="input_gcloud_command"></a> [gcloud\_command](#input\_gcloud\_command) | Path to the gcloud cli. Used to list enabled services and service accounts. | `string` | `null` | no |
| <a name="input_iam_policy"></a> [iam\_policy](#input\_iam\_policy) | Map of Google Project IAM Policy Roles and Members | `map(list(string))` | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to assign to the project | `map(string)` | `{}` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | Parent Google Organization ID (only one of org\_id or folder\_id may be specified) | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Google Project ID | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Google Project Display Name (defaults to project\_id if not specified)) | `string` | `null` | no |
| <a name="input_service_accounts"></a> [service\_accounts](#input\_service\_accounts) | Map of Google Service Accounts to Create | <pre>map(object({<br/>    description  = optional(string)<br/>    display_name = optional(string)<br/>    disabled     = optional(bool)<br/>    roles        = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_services"></a> [services](#input\_services) | List of Google Project Services to Enable | `list(string)` | `[]` | no |
| <a name="input_skip_delete"></a> [skip\_delete](#input\_skip\_delete) | Skip deletion of the Project when the Terraform resource is deleted (defaults to true) | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | Google Name (string) |
| <a name="output_number"></a> [number](#output\_number) | Google Project Number (string) |
| <a name="output_project_iam_policy"></a> [project\_iam\_policy](#output\_project\_iam\_policy) | Google Project IAM Policy (list of binding objects) |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | Google Project ID (string) |
| <a name="output_project_number"></a> [project\_number](#output\_project\_number) | Google Project Number (string) [deprecated - use number instead] |
| <a name="output_service_accounts"></a> [service\_accounts](#output\_service\_accounts) | Google Service Accounts (map of objects) |
| <a name="output_services"></a> [services](#output\_services) | Google Project Services (map of objects) |
| <a name="output_unmanaged_project_services"></a> [unmanaged\_project\_services](#output\_unmanaged\_project\_services) | Google Project Services that are enabled but are not managed by Terraform (list of strings) |
| <a name="output_unmanaged_service_accounts"></a> [unmanaged\_service\_accounts](#output\_unmanaged\_service\_accounts) | Google Service Accounts that exist but are not managed by Terraform (list of strings) |
<!-- END_TF_DOCS -->
