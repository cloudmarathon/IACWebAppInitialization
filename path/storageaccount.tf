resource "azurerm_storage_account" "newstorageaccount" {
  name                     = var.storage_name
  location                 = azurerm_resource_group.mytestrg2.location
  resource_group_name      = azurerm_resource_group.mytestrg2.name
  account_tier             = var.type
  account_replication_type = var.replicationtype


}