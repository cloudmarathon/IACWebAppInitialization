# Generic Input Variables
# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "sap"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}

# Azure Resource Group Name 
variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  default = "rg-default"  
}

# Azure Resources Location
variable "resource_group_location" {
  description = "Region in which Azure Resources to be created"
  type = string
  default = "eastus2"  
}

variable "web_linuxvm_instance_count" {
  description = "number of instances"
  type = any
  default = 3
}

variable "lb_inbound_nat_ports" {
  description = "inbound port rules"
  type = any
  default = ["1022", "2022", "3022", "4022", "5022"]
}