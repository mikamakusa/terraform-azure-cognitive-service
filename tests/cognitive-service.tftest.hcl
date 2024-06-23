run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "cognitive_service_with_public_endpoint" {
  command = apply

  variables {
    tags = {
      terraform = true
      module    = "cognitive_service"
      endpoint  = "public"
    }
    resource_group_name = "openai-rg"
    account = [
      {
        id                            = 0
        name                          = "openai-account"
        kind                          = "CognitiveServices"
        sku_name                      = "DC0"
        dynamic_throttling_enabled    = true
        public_network_access_enabled = true
      }
    ]
    deployment = [
      {
        id                    = 0
        cognitive_account_id  = 0
        name                  = "gpt-35-turbo"
        model = [
          {
            format  = "OpenAI"
            name    = "gpt-35-turbo"
            version = "0301"
          }
        ]
        scale = [
          {
            type = "Standard"
          }
        ]
      }
    ]
  }
}

run "cognitive_service_with_private_endpoint" {
  command = apply

  variables {
    tags = {
      terraform = true
      module    = "cognitive_service"
      endpoint  = "private"
    }
    resource_group_name = "openai-rg"
    virtual_network     = "vnet1"
    subnet              = "subnet1"
    account = [
      {
        id                            = 0
        name                          = "openai-account"
        kind                          = "CognitiveServices"
        sku_name                      = "DC0"
        dynamic_throttling_enabled    = true
        public_network_access_enabled = true
      }
    ]
    deployment = [
      {
        id                    = 0
        cognitive_account_id  = 0
        name                  = "gpt-35-turbo"
        model = [
          {
            format  = "OpenAI"
            name    = "gpt-35-turbo"
            version = "0301"
          }
        ]
        scale = [
          {
            type = "Standard"
          }
        ]
      }
    ]
    private_dns_zone_virtual_network_link = [
      {
        id                    = 0
        name                  = "dns_zone_link"
        registration_enabled  = true
        private_dns_zone_id   = 0
      }
    ]
    private_dns_zone = [
      {
        id    = 0
        name  = "openai_pe"
      }
    ]
  }
}