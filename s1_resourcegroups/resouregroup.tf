# web app resource group
resource "azurerm_resource_group" "rg" {
  name = "${var.resource_group_name}-${local.resource_name_prefix}" # rg-web-app-eastus
  location = var.resource_group_location
  tags = local.common_tags
}
