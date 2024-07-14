resource "azurerm_resource_group" "webapprg" {
  name     = var.rg_name
  tags     = var.tags
  location = var.location
}
