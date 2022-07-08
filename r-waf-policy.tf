resource "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = coalesce(var.custom_name, local.default_name)
  resource_group_name = var.resource_group_name
  location            = var.location
  location_short = var.location_short

  policy_settings {
    enabled                     = var.policy_enabled
    mode                        = var.policy_mode
    file_upload_limit_in_mb     = var.policy_file_limit
    request_body_check          = var.policy_request_body_check
    max_request_body_size_in_kb = var.policy_max_body_size
  }

  managed_rules {
    dynamic "managed_rule_set" {
      for_each = var.managed_rule_set_configuration
      content {
        type    = lookup(managed_rule_set.value, "type")
        version = lookup(managed_rule_set.value, "version")
        dynamic "rule_group_override" {
          for_each = var.rule_group_override_configuration
          content {
            rule_group_name = lookup(rule_group_override.value, "rule_group_name", null)
            disabled_rules  = lookup(rule_group_override.value, "disabled_rules", null)
          }
        }
      }
    }

    dynamic "exclusion" {
      for_each = var.exclusion_configuration
      content {
        match_variable          = lookup(exclusion.value, "match_variable")
        selector                = lookup(exclusion.value, "selector")
        selector_match_operator = lookup(exclusion.value, "selector_match_operator")
      }
    }
  }
  
  dynamic "custom_rules" {
    for_each = var.custom_rules_configuration
    content {
      name      = lookup(custom_rules.value, "name")
      priority  = lookup(custom_rules.value, "priority")
      rule_type = lookup(custom_rules.value, "rule_type")
      action    = lookup(custom_rules.value, "action")

      dynamic "match_conditions" {
        for_each = var.match_conditions_configuration
        content {
          dynamic "match_variables" {
            for_each = var.custom_match_variables
            content {
            variable_name = lookup(match_conditions.value, "variable_name")
            selector      = lookup(match_conditions.value, "selector")
            }
          }
          match_values       = lookup(match_conditions.value, "match_values")
          operator           = lookup(match_conditions.value, "operator")
          negation_condition = lookup(match_conditions.value, "negation_condition")
          transforms         = lookup(match_conditions.value, "transforms")
        }
      }
    }
  }

  #
  # Tags
  #
  
  tags = merge(module.tags.asset_custom_tags, var.custom_tags)
}
