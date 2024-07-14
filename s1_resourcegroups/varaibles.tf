variable "rg_name" {
  description = "The name of the resource group where the resources will be created."
  type        = string
  default     = "defaultResourceGroup"
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {
    environment = "dev"
    project     = "terraform-sample"
  }
}
