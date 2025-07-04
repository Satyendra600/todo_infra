resource "azurerm_key_vault_secret" "satyamtijori" {
  name         =var.secret_name
  value        = var.value
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
data "azurerm_key_vault" "key_vault" {
  name                = var.keyvaultname
  resource_group_name = var.resource_group_name
}
