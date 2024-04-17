# Create public IPs
resource "azurerm_public_ip" "nginx-ip" {
  name                = "nginxPublicIP"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
}

# Create network interface
resource "azurerm_network_interface" "nginx-nic" {
  name                = "nginxNIC"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "nginx_nic_configuration"
    subnet_id                     = azurerm_subnet.lb-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.nginx-ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nginx-nsga" {
  network_interface_id      = azurerm_network_interface.nginx-nic.id
  network_security_group_id = azurerm_network_security_group.lb-nsg.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "nginx" {
  name                            = "nginx"
  location                        = azurerm_resource_group.main.location
  resource_group_name             = azurerm_resource_group.main.name
  computer_name                   = "nginx"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nginx-nic.id]
  size                            = "Standard_DS1_v2"

  os_disk {
    name                 = "nginxOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install docker.io -y",
      "git clone https://github.com/devopsschool-training-notes/terraform-ey-june-2021",
      "sudo docker run -d -p 80:80 httpd"
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
