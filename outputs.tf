output "activation_urls" {
  description = "List of objects with parameters Delta Share Recipient Name and it's one-time activation url with access token. "
  value = [for k, v in local.recipients_mapped : {
    name           = k,
    activation_url = databricks_recipient.this[k].tokens[0].activation_url
  } if v.authentication_type == "TOKEN"]
}
