variable "resource_group_name" {
  description   = "(Required) The name of the resource group in which the Module is created. Changing this forces a new resource to be created."
  type          = string
  default       = ""
}

variable "automation_account_name" {
  description   = "(Required) The name of the automation account in which the Module is created. Changing this forces a new resource to be created." 
  type          = string
  default       = ""
}

variable "modules" {
  description   = "A list of maps of module to install. Where 'name' is the module name, and 'uri' is the URI of the module."
  type          = list(object({
    name        = string
    uri         = string
  }))
  default       = []
}
