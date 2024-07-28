# All data blocks in this folder
# data block for the resource group
data "azurerm_resource_group" "rg" {
  name = local.resource_group_name
}
