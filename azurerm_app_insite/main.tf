resource "azurerm_application_insights" "appinsite" {
    for_each            = var.app_insites
    name                = each.value.name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    application_type    = each.value.application_type
    workspace_id = each.value.workspace_id
    tags = {
      environment = "staging"
    }
}

