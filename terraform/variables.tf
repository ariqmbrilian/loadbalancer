variable "location" {
  type        = string
  default     = "southeastasia"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  default     = "loadbalancer-rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureuser"
}

variable "password" {
  type        = string
  description = "The password for the local account that will be created on the new VM."
  default     = "Task@999smgo"
}


