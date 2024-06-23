data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_private_dns_zone" "this" {
  count = var.data_private_dns_zone ? 1 : 0
  name  = var.data_private_dns_zone
}

data "azurerm_virtual_network" "this" {
  name                = var.virtual_network
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_subnet" "this" {
  name                 = var.subnet
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = data.azurerm_virtual_network.this.name
}