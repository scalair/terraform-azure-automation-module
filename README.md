# terraform-azure-automation-module

Terraform module that import PowerShell modules into an automation account, based on the [`azurerm_automation_module` terraform resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_module).

## Usage

```hcl
module "terraform-azure-automation-module" {
  source    = "github.com/scalair/terraform-azure-automation-module"

  resource_group_name     = "rg-loadtesting-francecentral"
  automation_account_name = "aa-sslrenew-1cd709"
  modules                 = [
    {
      "name": "ACME-PS",
      "uri": "https://www.powershellgallery.com/api/v2/package/ACME-PS/1.3.1"
    },
    {
      "name": "Posh-ACME",
      "uri": "https://www.powershellgallery.com/api/v2/package/sh-ACME/4.0.0-beta"
    }
  ]
}
```
