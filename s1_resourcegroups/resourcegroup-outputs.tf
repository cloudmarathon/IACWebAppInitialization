output "resource group name" {
  description = "Name of the resource group"
  value = azurerm_resource_group.rg.name
}

output "rg location" {
    description = "value of the location Resource group"
    value = azurerm_resource_group.rg.location
}