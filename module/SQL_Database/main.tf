resource "azurerm_mssql_database" "satyadatabase" {
  name         = var.sql_database
  server_id    = var.server_id
  collation    = var.collation
  license_type = var.licence
  max_size_gb  = var.max_size_gb
  sku_name     = var.sku_name
  enclave_type = var.enclave_type



  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
