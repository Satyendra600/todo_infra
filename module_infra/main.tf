module "resource_group" {
  source   = "../module/aurerm_resourcegroup"
  rg_name  = "rg_satyamjio"
  location = "eastus"
}

module "vnet" {
  depends_on    = [module.resource_group]
  source        = "../module/azurerm_vnet"
  vnet_name     = "vnet_satya"
  location      = "eastus"
  rg_name       = "rg_satyamjio"
  address_space = ["10.0.0.0/16"]
}
module "subnet_frontend" {
  depends_on       = [module.vnet]
  source           = "../module/azurerm_subnet"
  subnet_name      = "subnet_frontend"
  rg_name          = "rg_satyamjio"
  vnet_name        = "vnet_satya"
  address_prefixes = ["10.0.0.0/17"]


}
module "subnet_backend" {
  depends_on       = [module.vnet]
  source           = "../module/azurerm_subnet"
  subnet_name      = "subnet_backed"
  rg_name          = "rg_satyamjio"
  vnet_name        = "vnet_satya"
  address_prefixes = ["10.0.128.0/17"]


}
module "nic_fronted" {
  depends_on = [module.pip_frontend]
  source     = "../module/azurerm_NIC"
  nic_name   = "nic_fronted"
  location   = "eastus"
  rg_name    = "rg_satyamjio"
  subnet_name = "subnet_frontend"
  vnet_name = "vnet_satya"
  pip_name = "pip_frontend"
}
module "nic_backend" {
  depends_on = [module.pip_backend]
  source     = "../module/azurerm_NIC"
  nic_name   = "nic_backend"
  location   = "eastus"
  rg_name    = "rg_satyamjio"
  subnet_name = "ubnet_backed"
  vnet_name = "vnet_satya"
  pip_name = "pip_backend"
}
module "vm" {
  source    = "../module/azurerm_vm"
  vm_name   = "gauravvm"
  location  = "eastus"
  rg_name   = "rg_satyamjio"
  nic_name = "nic_satya"
  publisher = "canonical"
  offer     = "ubuntu-24_04-lts"
  sku       = "ubuntu-pro-gen1"
  caching   = "ReadWrite"
}

module "sql_server" {
  depends_on = [ module.resource_group ]
  source    = "../module/SQL_Server"
  sql_server = "satyaserver12"
  rg_name = "rg_satyamjio"
  admin_username  = "Satyendra"
  admin_password  = "S@ty3ndrA_2024"
  location = "West US"

}
module "sql_database" {
  depends_on = [ module.sql_server ]
  source = "../module/SQL_Database"
  sql_database = "sqldatabase"
  server_id = "/subscriptions/ff2c3052-bd08-443f-80dd-1cabe7cbcd50/resourceGroups/rg_satyamjio/providers/Microsoft.Sql/servers/satyaserver12"
  licence = "LicenseIncluded"
  collation = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb = "5"
  sku_name = "S0"
  enclave_type = "VBS"
 
}
module "pip_frontend" {
  depends_on = [ module.subnet_frontend]
  source = "../module/azurerm_pip"
  pip_name = "pip_frontend"
  rg_name = "rg_satyamjio"
  location = "eastus"
  
}
module "pip_backend" {
  depends_on = [ module.subnet_backend ]
  source = "../module/azurerm_pip"
  pip_name = "pip_backend"
  rg_name = "rg_satyamjio"
  location = "eastus"
  
}
module "keyvault"{
  depends_on = [ module.resource_group ]
  source = "../module/azurermkeyvault"
  keyvaultname = "sonekitijori"
  location = "eastus"
  resource_group_name = "rg_satyamjio"
}

module "keyvault_secret_name" {
  depends_on = [module.resource_group]
  source = "../module/keyvault"
    secret_name = "secrettijori"
    value = "Satyendra@107"
    keyvaultname = "sonekitijori"
    resource_group_name = "rg_satyamjio"
  }

