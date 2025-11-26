variable "keys" {
  description = "A map of keys to create in the key vault"
  type = map(object({
    name         = string
    key_vault_id = string
    key_type     = string
    key_size     = number
    key_opts     = list(string)

    rotation_policy = optional(object({
      expire_after         = string
      notify_before_expiry = string
      # automatic = optional(object({
      #   time_before_expiry = string
      }))
    }))
  }



variable "default_key_vault_id" {
  type        = string
  description = "Default Key Vault ID to use if not specified per key"
}
