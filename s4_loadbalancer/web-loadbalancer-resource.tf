data "azurerm_resource_group" "rg" {
  name = "rg-hr-dev-tqrpzb"
}

data "azurerm_virtual_network" "vnet" {
    name = "hr-dev-vnet"
    resource_group_name = "rg-hr-dev-tqrpzb"
}

data "azurerm_network_interface" "web_linuxvm_nic" {
    name = "hr-dev-web-linuxvm-nic"
    resource_group_name = "rg-hr-dev-tqrpzb"
}

# Resource-1: Create Public IP Address for Azure Load Balancer
resource "azurerm_public_ip" "web_lbpublicip" {
  name = "${local.resource_name_prefix}-lbpublicip"
  resource_group_name = data.azurerm_resource_group.rg.name 
  location = data.azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
  tags = local.common_tags
}
# Resource-2: Create Azure Standard Load Balancer
resource "azurerm_lb" "web_lb" {
  name = "${local.resource_name_prefix}-web-lb"
  resource_group_name = data.azurerm_resource_group.rg.name 
  location = data.azurerm_resource_group.rg.location  
  sku = "Standard"
  frontend_ip_configuration {
    name = "web-lb-publicip-1"
    public_ip_address_id = azurerm_public_ip.web_lbpublicip.id
  }
}
# Resource-3: Create LB Backend Pool
resource "azurerm_lb_backend_address_pool" "web_lb_backend_address_pool" {
  name = "web-backend"
  loadbalancer_id = azurerm_lb.web_lb.id
}
# Resource-4: Create LB Probe
resource "azurerm_lb_probe" "web_lb_probe" {
  name = "tcp-probe"
  protocol = "Tcp"
  port = 80
  loadbalancer_id = azurerm_lb.web_lb.id
#   resource_group_name = data.azurerm_resource_group.rg.name 
}
# Resource-5: Create LB Rule
resource "azurerm_lb_rule" "web_lb_rule_app1" {
  name = "web-app1-rule"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
#   backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id 
  probe_id = azurerm_lb_probe.web_lb_probe.id 
  loadbalancer_id = azurerm_lb.web_lb.id
#   resource_group_name = data.azurerm_resource_group.rg.name 
}
# Resource-6: Associate Network Interface and Standard Load Balancer
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association
resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_associate" {
  network_interface_id = data.azurerm_network_interface.web_linuxvm_nic.id 
  ip_configuration_name = data.azurerm_network_interface.web_linuxvm_nic.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id   
}