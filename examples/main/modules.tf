module "waf_policy" {
  source  = "claranet/waf-policy/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  stack          = var.stack

  resource_group_name = module.rg.name

  policy_mode = "Detection"

  managed_rule_set_configuration = [
    {
      type    = "OWASP"
      version = "3.2"
    }
  ]

  exclusion_configuration = []

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

          operator           = "IPMatch"
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

          operator           = "Contains"
          negation_condition = true
          transforms         = null
        }
      ]
    }
  ]
}
