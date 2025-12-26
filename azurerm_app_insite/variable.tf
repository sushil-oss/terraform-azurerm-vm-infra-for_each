variable "app_insites" {
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        application_type    = string
        workspace_id        = string
        tags                = map(string)   
        
    }))
}

