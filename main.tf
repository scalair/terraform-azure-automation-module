resource "azurerm_automation_module" "module" {
  count                     = length(var.modules)
  
  name                      = var.modules[count.index].name
  resource_group_name       = var.resource_group_name
  automation_account_name   = var.automation_account_name

  module_link {
    uri = var.modules[count.index].uri
  }
}
