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

## Limitations

### A resource with the ID already exists

Because Azure automatically imports a bunch of modules when the `Automation Account` is created, you can get this kind of error when you want to add a module where its name already exist in the `Automation Account`.
There are several reason to add a module that already exists, for instance if you want to upgrade the module version.

Here is the related error in my personal use-case when I tried to import a new version of `AzureRM.Profile` :

`Error: A resource with the ID "/subscriptions/<subcription_id>/resourceGroups/<rg_name>/providers/Microsoft.Automation/
automationAccounts/<account_name>/modules/AzureRM.Profile" already exists - to be managed via Terraform this resource needs to be imported into the State.`

It fails because the module already exist, whereas the module is actually not in the terraform state.

So, we need to import it. Let's do it :

```bash
terraform import "azurerm_automation_module.module[3]" /subscriptions/<subcription_id>/resourceGroups/<rg_name>/providers/Microsoft.Automation/
automationAccounts/<account_name>/modules/AzureRM.Profile

Import successful!
```

**In the previous example, the index `3` in** `azurerm_automation_module.module[3]` **depends on the index of the module within the declared ``modules`` variables.**

Finally, you can apply again :

```bash
terraform apply
```
