variable "resource_group_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "data_private_dns_zone" {
  type     = string
  nullable = true
  default  = null
}

variable "virtual_network" {
  type = string
}

variable "subnet" {
  type = string
}

variable "account" {
  type = list(object({
    id                                           = number
    kind                                         = string
    name                                         = string
    sku                                          = string
    custom_question_answering_search_service_id  = optional(string)
    custom_subdomain_name                        = optional(string)
    custom_question_answering_search_service_key = optional(string)
    dynamic_throttling_enabled                   = optional(bool)
    fqdns                                        = optional(list(string))
    local_auth_enabled                           = optional(bool)
    metrics_advisor_aad_client_id                = optional(string)
    metrics_advisor_aad_tenant_id                = optional(string)
    metrics_advisor_super_user_name              = optional(string)
    metrics_advisor_website_name                 = optional(string)
    outbound_network_access_restricted           = optional(bool)
    public_network_access_enabled                = optional(bool)
    qna_runtime_endpoint                         = optional(string)
    tags                                         = optional(map(string))
    network_acls = optional(list(object({
      default_action = string
      ip_rules       = optional(list(string))
      virtual_network_rules = optional(list(object({
        subnet_id                            = string
        ignore_missing_vnet_service_endpoint = optional(bool)
      })), [])
    })), [])
    customer_managed_key = optional(list(object({
      key_vault_key_id   = string
      identity_client_id = optional(string)
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    storage = optional(list(object({
      storage_account_id = string
      identity_client_id = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
Manages a Cognitive Services Account.
EOF
}

variable "account_customer_managed_key" {
  type = list(object({
    id                   = number
    cognitive_account_id = number
    key_vault_key_id     = string
    identity_client_id   = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "deployment" {
  type = list(object({
    id                   = number
    cognitive_account_id = number
    name                 = string
    rai_policy_name      = optional(string)
    model = list(object({
      format  = string
      name    = string
      version = string
    }))
    scale = list(object({
      type     = string
      tier     = string
      size     = string
      family   = optional(string)
      capacity = optional(number)
    }))
  }))
  default     = []
  description = <<EOF
Manages a Cognitive Services Account Deployment.
cognitive_account_id - (Required) : The ID of the Cognitive Services Account
model / format - (Required) : The format of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created. Possible value is OpenAI
scale / type - (Required) : The name of the SKU. Ex - Standard or P3
scale / tier - (Required) : Possible values are Free, Basic, Standard, Premium, Enterprise
scale / capacity - (Optional) : Tokens-per-Minute (TPM). The unit of measure for this field is in the thousands of Tokens-per-Minute. Defaults to 1 which means that the limitation is 1000 tokens per minute. If the resources SKU supports scale in/out then the capacity field should be included in the resources' configuration.
EOF
}

variable "private_endpoint" {
  type = list(object({
    id   = number
    name = string
    tags = optional(map(string))
    ip_configuration = optional(list(object({
      name               = string
      private_ip_address = string
      member_name        = optional(string)
      subresource_name   = optional(string)
    })), [])
    private_dns_zone_group = optional(list(object({
      private_dns_zone_id = optional(list(string))
    })), [])
    private_service_connection = optional(list(object({
      is_manual_connection              = bool
      name                              = string
      private_connection_resource_alias = optional(string)
      private_connection_resource_id    = optional(number)
      request_message                   = optional(string)
      subresource_names                 = optional(list(string))
    })), [])
  }))
  default = []
}

variable "private_dns_zone" {
  type = list(object({
    id   = number
    name = string
    tags = optional(map(string))
    soa_record = optional(list(object({
      email        = string
      expire_time  = optional(number)
      minimum_ttl  = optional(number)
      refresh_time = optional(number)
      retry_time   = optional(number)
      tags         = optional(map(string))
      ttl          = optional(number)
    })), [])
  }))
  default = []
}

variable "private_dns_zone_virtual_network_link" {
  type = list(object({
    id                   = number
    name                 = string
    private_dns_zone_id  = optional(number)
    registration_enabled = optional(bool)
    tags                 = optional(map(string))
  }))
}