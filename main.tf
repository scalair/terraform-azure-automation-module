# Workaround for errors on module deployment:
# https://docs.microsoft.com/en-us/azure/templates/microsoft.automation/automationaccounts/modules
# https://github.com/terraform-providers/terraform-provider-azurerm/issues/8840
resource "azurerm_resource_group_template_deployment" "this" {
  for_each = { for i, module in var.modules : i => module }

  name                = "module-template-${each.value.name}-${formatdate("YYMMDDhhmmss", timestamp())}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/module-template.json")

  parameters_content = templatefile("${path.module}/module-template.parameters.json",
    {
      module_name        = each.value.name
      automation_account = var.automation_account_name
      uri                = each.value.uri
    }
  )

  lifecycle {
    ignore_changes = [
      name
    ]
  }

  tags = var.tags
}
