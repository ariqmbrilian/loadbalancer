# Create public IPs
resource "azurerm_public_ip" "caddy-ip" {
  name                = "caddyPublicIP"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
}

# Create network interface
resource "azurerm_network_interface" "caddy-nic" {
  name                = "caddyNIC"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "caddy_nic_configuration"
    subnet_id                     = azurerm_subnet.lb-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.caddy-ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "caddy-nsga" {
  network_interface_id      = azurerm_network_interface.caddy-nic.id
  network_security_group_id = azurerm_network_security_group.lb-nsg.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "caddy" {
  name                            = "caddy"
  location                        = azurerm_resource_group.main.location
  resource_group_name             = azurerm_resource_group.main.name
  computer_name                   = "caddy"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.caddy-nic.id]
  size                            = "Standard_D4s_v3"

  os_disk {
    name                 = "caddyOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  provisioner "file" {
     source = "../preconf.sh"
     destination = "/tmp/preconf.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "/bin/bash /tmp/preconf.sh",
      "sudo chown $USER /var/run/docker.sock",
      "git clone https://github.com/ariqmbrilian/loadbalancer.git && cd loadbalancer",
      "./script build",
      "./script start-caddy"
    ]
  }
  connection {
    host     = self.public_ip_address
    type     = "ssh"
    user     = var.username
    password = var.password
    timeout  = "4m"
    agent    = false
  }
}
