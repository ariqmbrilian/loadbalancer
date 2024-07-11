resource "azurerm_resource_group" "main" {
  location = var.location
  name     = var.resource_group_name
}


# Create virtual network
resource "azurerm_virtual_network" "lb-vnet" {
  name                = "lb-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Create subnet
resource "azurerm_subnet" "lb-subnet" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.lb-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "lb-nsg" {
  name                = "myNetworkSecurityGroup"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}