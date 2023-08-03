# Azure Databricks Delta Sharing Terraform module
Terraform module for creation Azure Databricks Delta Sharing

## Usage

```hcl
data "azurerm_databricks_workspace" "example" {
  name                = "example-workspace"
  resource_group_name = "example-rg"
}

# Databricks Provider configuration
provider "databricks" {
  alias                       = "workspace"
  host                        = data.azurerm_databricks_workspace.example.workspace_url
  azure_workspace_resource_id = data.azurerm_databricks_workspace.example.id
}

module "delta_sharing" {
  source  = "data-platform-hq/delta-sharing/databricks"
  version = "~> 1.0"

  recipients = [{
    name                               = "databricks-to-databricks"
    authentication_type                = "DATABRICKS"
    data_recipient_global_metastore_id = "gcp:europe-west3:xxxxxx-xxxx-xxxxx-xxxxxxxx"
  }, {
    name                = "external-token"
    authentication_type = "TOKEN"
    ip_access_list      =  ["0.0.0.0/0"]
  }]

  providers = {
    databricks = databricks.workspace
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                         | Version   |
| ---------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform)    | >= 1.0.0  |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >= 1.21.0 |

## Providers

| Name                                                                   | Version |
| ---------------------------------------------------------------------- | ------- |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | 1.21.0  |

## Inputs

| Name | Description | Type | Default                                                                                                                                               | Required |
|------|-------------|------|-------------------------------------------------------------------------------------------------------------------------------------------------------|:--------:|
| <a name="input_recipients"></a> [recipients](#input\_recipients)| Configuration options for Delta Sharing Recipients | <pre>list(object({<br>  name                               = string<br>  authentication_type                = string<br>  comment                            = optional(string)<br>  data_recipient_global_metastore_id = optional(string)<br>  ip_access_list                     = optional(list(string))<br>}))</pre> | []| no |


## Modules

No modules.

## Resources

| Name                                                                                                                                                                | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [databricks_recipient.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/recipient)| resource |



## Outputs

| Name                                                                                | Description                                          |
|-------------------------------------------------------------------------------------| ---------------------------------------------------- |
| <a name="output_activation_urls"></a> [activation\_urls](#output\_activation\_urls) | List of objects with parameters Delta Share Recipient Name and it's one-time activation url with access token.|


<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-databricks-delta-sharing/blob/main/LICENSE)
