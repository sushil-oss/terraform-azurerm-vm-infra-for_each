variable "secrets" {
    description = " A map of secrets to create in key vault"
    type = map(object({
      name = string
      value = string
      key_vault_id = optional(string)

    }))
}

variable "default_key_vault_id" {
  type        = string
  description = "Default Key Vault ID to use if not specified per secret"
  default     = ""  # Agar default empty hai
}