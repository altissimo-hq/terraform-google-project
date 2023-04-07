# Altissimo - Google Project (Terraform Module)

The repo contains a terraform module for creating a Google Cloud Platform (GCP) project.

In addition to creating the project, this module will enable project services, create service accounts, and manage the project IAM policy.

`altissimo-hq/terraform-google-project`

---

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.60.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_policy.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_policy) | resource |
| [google_project_service.services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_iam_policy.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_network"></a> [auto\_create\_network](#input\_auto\_create\_network) | Automatically create a default VPC network (defaults to false) | `bool` | `false` | no |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | Billing Account ID (defaults to null if not specified) | `string` | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Parent Google Folder ID (only one of org\_id or folder\_id may be specified) | `string` | `null` | no |
| <a name="input_iam_policy"></a> [iam\_policy](#input\_iam\_policy) | Map of Google Project IAM Policy Roles and Members | `map(list(string))` | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to assign to the project | `map(string)` | `{}` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | Parent Google Organization ID (only one of org\_id or folder\_id may be specified) | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Google Project ID | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Google Project Display Name (defaults to project\_id if not specified)) | `string` | `null` | no |
| <a name="input_service_accounts"></a> [service\_accounts](#input\_service\_accounts) | Map of Google Service Accounts to Create | <pre>map(object({<br>    display_name = optional(string)<br>    disabled     = optional(bool)<br>    roles        = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_services"></a> [services](#input\_services) | List of Google Project Services to Enable | `list(string)` | `[]` | no |
| <a name="input_skip_delete"></a> [skip\_delete](#input\_skip\_delete) | Skip deletion of the Project when the Terraform resource is deleted (defaults to true) | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
