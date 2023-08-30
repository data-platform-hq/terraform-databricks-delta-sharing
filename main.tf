locals {
  # Creates Delta Share Recipients mapping
  recipients_mapping = { for i in var.recipients : i.name => i if length(i.name) != 0 }

  # Creates Delta Share Recipients mapping for Token only type
  recipients_token_only_mapped = { for k, v in local.recipients_mapping : k => v if v.authentication_type == "TOKEN" }
}

resource "databricks_recipient" "this" {
  for_each = local.recipients_mapping

  name                               = each.value.name
  comment                            = coalesce(each.value.comment, "Terraform managed")
  authentication_type                = each.value.authentication_type
  data_recipient_global_metastore_id = lookup(each.value, "data_recipient_global_metastore_id")

  dynamic "ip_access_list" {
    for_each = each.value.authentication_type == "TOKEN" ? [1] : []
    content {
      allowed_ip_addresses = each.value.ip_access_list
    }
  }
}

# Creates HTTP request to Databricks Delta Share API that returns one time Authorization token
data "http" "this" {
  for_each = local.recipients_token_only_mapped

  url    = "https://${var.workspace_url}/api/2.1/unity-catalog/public/data_sharing_activation/${try(regex("[?](.*)", databricks_recipient.this[each.value.name].tokens[0].activation_url)[0], "")}"
  method = "GET"
}
