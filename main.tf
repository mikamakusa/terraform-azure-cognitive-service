resource "azurerm_cognitive_account" "this" {
  count                                        = lenght(var.account)
  kind                                         = lookup(var.account[count.index], "kind")
  location                                     = data.azurerm_resource_group.this.location
  name                                         = lookup(var.account[count.index], "name")
  resource_group_name                          = data.azurerm_resource_group.this.name
  sku_name                                     = lookup(var.account[count.index], "sku_name")
  custom_question_answering_search_service_id  = lookup(var.account[count.index], "custom_question_answering_search_service_id")
  custom_subdomain_name                        = lookup(var.account[count.index], "custom_subdomain_name")
  custom_question_answering_search_service_key = lookup(var.account[count.index], "custom_question_answering_search_service_key")
  dynamic_throttling_enabled                   = lookup(var.account[count.index], "dynamic_throttling_enabled")
  fqdns                                        = lookup(var.account[count.index], "fqdns")
  local_auth_enabled                           = lookup(var.account[count.index], "local_auth_enabled")
  metrics_advisor_aad_client_id                = lookup(var.account[count.index], "metrics_advisor_aad_client_id")
  metrics_advisor_aad_tenant_id                = lookup(var.account[count.index], "metrics_advisor_aad_tenant_id")
  metrics_advisor_super_user_name              = lookup(var.account[count.index], "metrics_advisor_super_user_name")
  metrics_advisor_website_name                 = lookup(var.account[count.index], "metrics_advisor_website_name")
  outbound_network_access_restricted           = lookup(var.account[count.index], "outbound_network_access_restricted")
  public_network_access_enabled                = lookup(var.account[count.index], "public_network_access_enabled")
  qna_runtime_endpoint                         = lookup(var.account[count.index], "qna_runtime_endpoint")
  tags = merge(
    var.tags,
    lookup(var.account[count.index], "tags")
  )

  dynamic "network_acls" {
    for_each = lookup(var.account[count.index], "network_acls") == null ? [] : ["network_acls"]
    content {
      default_action = lookup(network_acls.value, "default_action")
      ip_rules       = lookup(network_acls.value, "ip_rules")

      dynamic "virtual_network_rules" {
        for_each = lookup(network_acls.value, "virtual_network_rules") == null ? [] : ["virtual_network_rules"]
        content {
          subnet_id                            = lookup(virtual_network_rules.value, "subnet_id")
          ignore_missing_vnet_service_endpoint = lookup(virtual_network_rules.value, "ignore_missing_vnet_service_endpoint")
        }
      }
    }
  }

  dynamic "customer_managed_key" {
    for_each = lookup(var.account[count.index], "customer_managed_key") == null ? [] : ["customer_managed_key"]
    content {
      key_vault_key_id   = lookup(customer_managed_key.value, "key_vault_key_id")
      identity_client_id = lookup(customer_managed_key.value, "identity_client_id")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.account[count.index], "identity") == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }

  dynamic "storage" {
    for_each = lookup(var.account[count.index], "storage") == null ? [] : ["storage"]
    content {
      storage_account_id = lookup(storage.value, "storage_account_id")
      identity_client_id = lookup(storage.value, "identity_client_id")
    }
  }
}

resource "azurerm_cognitive_account_customer_managed_key" "this" {
  count                = length(var.account) == "0" ? "0" : length(var.account_customer_managed_key)
  cognitive_account_id = try(element(azurerm_cognitive_account.this.*.id, lookup(var.account_customer_managed_key[count.index], "cognitive_account_id")))
  key_vault_key_id     = lookup(var.account_customer_managed_key[count.index], "key_vault_key_id")
  identity_client_id   = lookup(var.account_customer_managed_key[count.index], "identity_client_id")
}

resource "azurerm_cognitive_deployment" "this" {
  count                = length(var.account) == "0" ? "0" : length(var.deployment)
  cognitive_account_id = try(element(azurerm_cognitive_account.this.*.id, lookup(var.deployment[count.index], "cognitive_account_id")))
  name                 = lookup(var.deployment[count.index], "name")
  rai_policy_name      = lookup(var.deployment[count.index], "rai_policy_name")


  dynamic "model" {
    for_each = lookup(var.deployment[count.index], "model")
    content {
      format  = lookup(model.value, "format")
      name    = lookup(model.value, "name")
      version = lookup(model.value, "version")
    }
  }

  dynamic "scale" {
    for_each = lookup(var.deployment[count.index], "scale")
    content {
      type     = lookup(scale.value, "type")
      tier     = lookup(scale.value, "tier")
      size     = lookup(scale.value, "size")
      family   = lookup(scale.value, "family")
      capacity = lookup(scale.value, "capacity")
    }
  }
}

resource "azurerm_private_endpoint" "this" {
  count               = length(var.private_endpoint)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.private_endpoint[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  subnet_id           = data.azurerm_subnet.this.name
  tags                = merge(var.tags, lookup(var.private_endpoint[count.index], "tags"))

  #   dynamic "ip_configuration" {
  #     for_each = lookup(var.private_endpoint[count.index], "ip_configuration") == null ? [] : ["ip_configuration"]
  #     content {
  #       name               = ""
  #       private_ip_address = ""
  #       member_name        = ""
  #       subresource_name   = ""
  #     }
  #   }

  dynamic "private_dns_zone_group" {
    for_each = lookup(var.private_endpoint[count.index], "private_dns_zone_group") == null ? [] : ["private_dns_zone_group"]
    content {
      name                 = try(element(azurerm_private_dns_zone.this.*.name, lookup(private_dns_zone_group.value, "private_dns_zone_id")))
      private_dns_zone_ids = try(element(azurerm_private_dns_zone.this.*.id, lookup(private_dns_zone_group.value, "private_dns_zone_id")))
    }
  }

  dynamic "private_service_connection" {
    for_each = lookup(var.private_endpoint[count.index], "private_service_connection") == null ? [] : ["private_service_connection"]
    content {
      is_manual_connection              = lookup(private_service_connection.value, "is_manual_connection")
      name                              = lookup(private_service_connection.value, "name")
      private_connection_resource_alias = lookup(private_service_connection.value, "private_connection_resource_alias")
      private_connection_resource_id    = try(element(azurerm_cognitive_account.this.*.id, lookup(private_service_connection.value, "private_connection_resource_id")))
      request_message                   = lookup(private_service_connection.value, "request_message")
      subresource_names                 = lookup(private_service_connection.value, "subresource_names")
    }
  }
}

resource "azurerm_private_dns_zone" "this" {
  count               = var.data_private_dns_zone ? 0 : 1 && length(var.private_dns_zone)
  name                = lookup(var.private_dns_zone[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  tags                = merge(var.tags, lookup(var.private_dns_zone[count.index], "tags"))

  dynamic "soa_record" {
    for_each = lookup(var.private_dns_zone[count.index], "soa_record") == null ? [] : ["soa_record"]
    content {
      email        = lookup(soa_record.value, "email")
      expire_time  = lookup(soa_record.value, "expire_time")
      minimum_ttl  = lookup(soa_record.value, "minimum_ttl")
      refresh_time = lookup(soa_record.value, "refresh_time")
      retry_time   = lookup(soa_record.value, "retry_time")
      tags         = lookup(soa_record.value, "tags")
      ttl          = lookup(soa_record.value, "ttl")
    }
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  count                 = length(var.private_dns_zone) == 0 ? 0 : length(var.private_dns_zone_virtual_network_link)
  name                  = lookup(var.private_dns_zone_virtual_network_link[count.index], "name")
  private_dns_zone_name = try(element(azurerm_private_dns_zone.this.*.name, lookup(var.private_dns_zone_virtual_network_link[count.index], "private_dns_zone_id")))
  resource_group_name   = data.azurerm_resource_group.this.name
  virtual_network_id    = data.azurerm_virtual_network.this.id
  registration_enabled  = lookup(var.private_dns_zone_virtual_network_link[count.index], "registration_enabled")
  tags                  = merge(var.tags, lookup(var.private_dns_zone_virtual_network_link[count.index], "tags"))
}