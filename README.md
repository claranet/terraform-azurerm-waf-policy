# waf-policy

Azure WAF Policies

```hcl
module "azure-region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  azure_region = module.azure-region.location
  client_name  = var.client_name
  environment  = var.environment
  stack        = var.stack
}

module "waf_policy" {
  source = "claranet/waf_policy/azurerm"
  version = "x.x.x"

  location            = module.azure-region.location
  location_short = module.azure-region.location_short

  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  name_prefix = local.name_prefix

  policy_mode = "Detection"

  managed_rule_set_configuration = [
    {
      type    = "OWASP"
      version = "3.1"
    }
  ]

  exclusion_configuration = [
  
  ]

  custom_rules_configuration = [
    {
      name      = "DenyAll"
      priority  = 1
      rule_type = "MatchRule"
      action    = "Block"

      match_conditions_configuration = [
        {
          match_variable_configuration = [
            {
              variable_name = "RemoteAddr"
              selector      = null
            }
          ]

          match_values = [
            "X.X.X.X"
          ]

          operator = "IPMatch"
          negation_condition = true
          transforms         = null
      },
      {
          match_variable_configuration = [
            {
              variable_name = "RequestUri"
              selector      = null
            },
            {
              variable_name = "RequestUri"
              selector      = null
            }
          ]

          match_values = [
            "Azure",
            "Cloud"
          ]

          operator = "Contains"
          negation_condition = true
          transforms         = null
      }
      ]
    }
  ]
}
```