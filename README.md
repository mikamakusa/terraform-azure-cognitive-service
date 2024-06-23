## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.107.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.107.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cognitive_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) | resource |
| [azurerm_cognitive_account_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account_customer_managed_key) | resource |
| [azurerm_cognitive_deployment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | Manages a Cognitive Services Account. | <pre>list(object({<br>    id                                           = number<br>    kind                                         = string<br>    name                                         = string<br>    sku                                          = string<br>    custom_question_answering_search_service_id  = optional(string)<br>    custom_subdomain_name                        = optional(string)<br>    custom_question_answering_search_service_key = optional(string)<br>    dynamic_throttling_enabled                   = optional(bool)<br>    fqdns                                        = optional(list(string))<br>    local_auth_enabled                           = optional(bool)<br>    metrics_advisor_aad_client_id                = optional(string)<br>    metrics_advisor_aad_tenant_id                = optional(string)<br>    metrics_advisor_super_user_name              = optional(string)<br>    metrics_advisor_website_name                 = optional(string)<br>    outbound_network_access_restricted           = optional(bool)<br>    public_network_access_enabled                = optional(bool)<br>    qna_runtime_endpoint                         = optional(string)<br>    tags                                         = optional(map(string))<br>    network_acls = optional(list(object({<br>      default_action = string<br>      ip_rules       = optional(list(string))<br>      virtual_network_rules = optional(list(object({<br>        subnet_id                            = string<br>        ignore_missing_vnet_service_endpoint = optional(bool)<br>      })), [])<br>    })), [])<br>    customer_managed_key = optional(list(object({<br>      key_vault_key_id   = string<br>      identity_client_id = optional(string)<br>    })), [])<br>    identity = optional(list(object({<br>      type         = string<br>      identity_ids = optional(list(string))<br>    })), [])<br>    storage = optional(list(object({<br>      storage_account_id = string<br>      identity_client_id = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_account_customer_managed_key"></a> [account\_customer\_managed\_key](#input\_account\_customer\_managed\_key) | n/a | <pre>list(object({<br>    id                   = number<br>    cognitive_account_id = number<br>    key_vault_key_id     = string<br>    identity_client_id   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_data_private_dns_zone"></a> [data\_private\_dns\_zone](#input\_data\_private\_dns\_zone) | n/a | `string` | `null` | no |
| <a name="input_deployment"></a> [deployment](#input\_deployment) | Manages a Cognitive Services Account Deployment.<br>cognitive\_account\_id - (Required) : The ID of the Cognitive Services Account<br>model / format - (Required) : The format of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created. Possible value is OpenAI<br>scale / type - (Required) : The name of the SKU. Ex - Standard or P3<br>scale / tier - (Required) : Possible values are Free, Basic, Standard, Premium, Enterprise<br>scale / capacity - (Optional) : Tokens-per-Minute (TPM). The unit of measure for this field is in the thousands of Tokens-per-Minute. Defaults to 1 which means that the limitation is 1000 tokens per minute. If the resources SKU supports scale in/out then the capacity field should be included in the resources' configuration. | <pre>list(object({<br>    id                   = number<br>    cognitive_account_id = number<br>    name                 = string<br>    rai_policy_name      = optional(string)<br>    model = list(object({<br>      format  = string<br>      name    = string<br>      version = string<br>    }))<br>    scale = list(object({<br>      type     = string<br>      tier     = string<br>      size     = string<br>      family   = optional(string)<br>      capacity = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_private_dns_zone"></a> [private\_dns\_zone](#input\_private\_dns\_zone) | n/a | <pre>list(object({<br>    id   = number<br>    name = string<br>    tags = optional(map(string))<br>    soa_record = optional(list(object({<br>      email        = string<br>      expire_time  = optional(number)<br>      minimum_ttl  = optional(number)<br>      refresh_time = optional(number)<br>      retry_time   = optional(number)<br>      tags         = optional(map(string))<br>      ttl          = optional(number)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_private_dns_zone_virtual_network_link"></a> [private\_dns\_zone\_virtual\_network\_link](#input\_private\_dns\_zone\_virtual\_network\_link) | n/a | <pre>list(object({<br>    id                   = number<br>    name                 = string<br>    private_dns_zone_id  = optional(number)<br>    registration_enabled = optional(bool)<br>    tags                 = optional(map(string))<br>  }))</pre> | n/a | yes |
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint) | n/a | <pre>list(object({<br>    id   = number<br>    name = string<br>    tags = optional(map(string))<br>    ip_configuration = optional(list(object({<br>      name               = string<br>      private_ip_address = string<br>      member_name        = optional(string)<br>      subresource_name   = optional(string)<br>    })), [])<br>    private_dns_zone_group = optional(list(object({<br>      private_dns_zone_id = optional(list(string))<br>    })), [])<br>    private_service_connection = optional(list(object({<br>      is_manual_connection              = bool<br>      name                              = string<br>      private_connection_resource_alias = optional(string)<br>      private_connection_resource_id    = optional(number)<br>      request_message                   = optional(string)<br>      subresource_names                 = optional(list(string))<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_coginitive_service_endpoint"></a> [coginitive\_service\_endpoint](#output\_coginitive\_service\_endpoint) | n/a |
| <a name="output_cognitive_service_id"></a> [cognitive\_service\_id](#output\_cognitive\_service\_id) | n/a |
| <a name="output_cognitive_service_keys"></a> [cognitive\_service\_keys](#output\_cognitive\_service\_keys) | n/a |
| <a name="output_cognitive_service_subdomain"></a> [cognitive\_service\_subdomain](#output\_cognitive\_service\_subdomain) | n/a |
