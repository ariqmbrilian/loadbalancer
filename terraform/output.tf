output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "caddy_public_ip_address" {
  value = azurerm_linux_virtual_machine.caddy.public_ip_address
}

output "nginx_public_ip_address" {
  value = azurerm_linux_virtual_machine.nginx.public_ip_address
}