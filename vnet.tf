resource "azurerm_resource_group" "RG_vnet" {
  name     = "RG_vnet"
  location = "West Europe"
}

resource "azurerm_network_security_group" "NSG_1" {
  name                = "NSG_1"
  location            = "${azurerm_resource_group.RG_vnet.location}"
  resource_group_name = "${azurerm_resource_group.RG_vnet.name}"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  resource_group_name = "${azurerm_resource_group.RG_vnet.name}"
  address_space       = ["10.0.0.0/16"]
  location            = "West Europe"
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
    security_group = "${azurerm_network_security_group.NSG_1.id}"
  }

  tags {
    environment = "Development"
  }
}
