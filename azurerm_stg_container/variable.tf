variable "containers" {
  type = map(object({
    name                  = string
    container_access_type = string
    storage_account_id    = optional(string)
    storage_account_key = optional(string)
  }))
}