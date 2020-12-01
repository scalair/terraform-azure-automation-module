variable "resource_group_name" {
  description = "(Required) The name of the resource group in which the Module is created. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "automation_account_name" {
  description = "(Required) The name of the automation account in which the Module is created. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "modules" {
  description = "A list of maps of module to install. Where 'name' is the module name, and 'uri' is the URI of the module."
  type = list(object({
    name = string
    uri  = string
  }))
  default = []
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Resource Group Template Deployment."
  type        = map
  default     = {}
}
