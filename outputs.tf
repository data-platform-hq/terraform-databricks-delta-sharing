output "delta_recipient_token" {
  description = "List of objects with Delta Share Recipient Name and it's one-time credentials access token. "
  value = [for k, v in local.recipients_token_only_mapped : {
    name             = k,
    activation_token = data.http.this[k].response_body
  }]
}
