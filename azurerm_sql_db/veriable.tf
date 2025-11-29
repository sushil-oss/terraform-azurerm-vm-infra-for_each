variable "sqldbs" {
  type = map(object({
    name                = string
   # location            = string
   # server_name         = string
   # resource_group_name = string
    server_id = optional(string)
  }))

}