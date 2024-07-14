# resource "azurerm_resource_group" "webapprg" {
#   name     = var.rg_name
#   tags     = var.tags
#   location = var.location
# }
# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name = "${var.resource_group_name}-${local.resource_name_prefix}-${random_string.myrandom.id}"
  location = var.resource_group_location
  tags = local.common_tags
}
