# Locals Block for custom data
data "azurerm_resource_group" "rg" {
  name = "rg-hr-dev-tqrpzb"
}

data "azurerm_virtual_network" "vnet" {
    name = "hr-dev-vnet"
    resource_group_name = "rg-hr-dev-tqrpzb"
}

data "azurerm_subnet" "websubnet" {
    name = "hr-dev-vnet-websubnet"
    resource_group_name = "rg-hr-dev-tqrpzb"
    virtual_network_name = "hr-dev-vnet"
}

data "azurerm_subnet" "bastionsubnet"{
    name = "hr-dev-vnet-bastionsubnet"
    resource_group_name = "rg-hr-dev-tqrpzb"
    virtual_network_name = "hr-dev-vnet"
}
locals {
webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to cloud marathon - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to cloud marathon - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to cloud marathon - WebVM App1 - App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html
CUSTOM_DATA  
}

resource "azurerm_key_vault" "kv" {
  name                        = "${local.resource_name_prefix}-kv"
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = "7ff8596a-3615-4bcc-a513-0f5ffcd93bf2"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

sku_name = "standard"

access_policy {
    tenant_id = "7ff8596a-3615-4bcc-a513-0f5ffcd93bf2"
    object_id = "9acf7dc0-56fe-485f-9e9b-eb3a6f130b35"
    key_permissions = [
      "Get",
    ]

    secret_permissions = [
       "Set",
       "Get",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get",
    ]
  }

}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "vmsecret" {
  name         = "${local.resource_name_prefix}-kv-vmsecret"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.kv.id
}

output "secret_value" {
  value     = azurerm_key_vault_secret.vmsecret.value
  sensitive = true
}

# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  name = "${local.resource_name_prefix}-web-linuxvm"
  #computer_name = "web-linux-vm"  # Hostname of the VM (Optional)
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  size = "Standard_DS1_v2"
  admin_username = "azureuser"
  disable_password_authentication = "false"
  admin_password = azurerm_key_vault_secret.vmsecret.value
  network_interface_ids = [ azurerm_network_interface.web_linuxvm_nic.id ]
#   admin_ssh_key {
#     username = "azureuser"
#     public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
#   }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    sku = "83-gen2"
    version = "latest"
  }
  #custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")    
  custom_data = base64encode(local.webvm_custom_data)  

}