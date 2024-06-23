output "coginitive_service_endpoint" {
  value = try(
    azurerm_cognitive_account.this.*.endpoint
  )
}

output "cognitive_service_id" {
  value = try(
    azurerm_cognitive_account.this.*.id
  )
}

output "cognitive_service_keys" {
  value = try(
    azurerm_cognitive_account.this.*.primary_access_key,
    azurerm_cognitive_account.this.*.secondary_access_key
  )
}

output "cognitive_service_subdomain" {
  value = try(
    azurerm_cognitive_account.this.*.custom_subdomain_name
  )
}