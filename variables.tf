variable "recipients" {
  type = list(object({
    name                               = string
    authentication_type                = string
    comment                            = optional(string)
    data_recipient_global_metastore_id = optional(string)
    ip_access_list                     = optional(list(string))
  }))
  description = "Configuration options for Delta Sharing Recipients"
  default     = []
}

variable "workspace_url" {
  type        = string
  description = "Azure Databricks Workspace URL"
  default     = null
}
