resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.size
  admin_username      = data.azurerm_key_vault_secret.vm_username.value
  admin_password      = data.azurerm_key_vault_secret.vm_password.value
  network_interface_ids = [
    data.azurerm_network_interface.nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
}
data "azurerm_network_interface" "nic" {
  name                = var.nic_name
  resource_group_name = var.rg_name
}
data "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
}
data "azurerm_key_vault_secret" "vm_username" {
  name         = var.vm_username
  key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "vm_password" {
  name         = var.vm_password
  key_vault_id = data.azurerm_key_vault.kv.id
}