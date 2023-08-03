locals {
  recipients_mapped = { for i in var.recipients : i.name => i if length(i.name) != 0 }
}

resource "databricks_recipient" "this" {
  for_each = local.recipients_mapped

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
