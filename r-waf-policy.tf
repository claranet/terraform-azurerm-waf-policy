resource "azurerm_web_application_firewall_policy" "waf_policy" {
  location            = var.location
  name                = local.policy_name
  resource_group_name = var.resource_group_name

  policy_settings {
    enabled                     = var.policy_enabled
    mode                        = var.policy_mode
    file_upload_limit_in_mb     = var.policy_file_limit
    request_body_check          = var.policy_request_body_check_enabled
    max_request_body_size_in_kb = var.policy_max_body_size
  }

  managed_rules {
    dynamic "managed_rule_set" {
      for_each = var.managed_rule_set_configuration

      content {
        type    = managed_rule_set.value.type
        version = managed_rule_set.value.version
        dynamic "rule_group_override" {
          for_each = managed_rule_set.value.rule_group_override_configuration != null ? managed_rule_set.value.rule_group_override_configuration : []

          content {
            rule_group_name = rule_group_override.value.rule_group_name
            dynamic "rule" {
              for_each = try(rule_group_override.value.rule, [])

              content {
                id      = rule.value.id
                enabled = rule.value.enabled
                action  = rule.value.action
              }
            }
          }

        }
      }
    }

    dynamic "exclusion" {
      for_each = var.exclusion_configuration

      content {
        match_variable          = exclusion.value.match_variable
        selector                = exclusion.value.selector
        selector_match_operator = exclusion.value.selector_match_operator
        dynamic "excluded_rule_set" {
          for_each = exclusion.value.excluded_rule_set
          iterator = rule_set

          content {
            type    = rule_set.value.type
            version = rule_set.value.version
            dynamic "rule_group" {
              for_each = rule_set.value.rule_group

              content {
                rule_group_name = rule_group.value.rule_group_name
                excluded_rules  = rule_group.value.excluded_rules
              }
            }
          }
        }
      }
    }
  }

  dynamic "custom_rules" {
    for_each = var.custom_rules_configuration

    content {
      name      = custom_rules.value.name
      priority  = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type
      action    = custom_rules.value.action
      dynamic "match_conditions" {
        for_each = custom_rules.value.match_conditions_configuration

        content {
          dynamic "match_variables" {
            for_each = match_conditions.value.match_variable_configuration

            content {
              variable_name = match_variables.value.variable_name
              selector      = match_variables.value.selector
            }
          }
          match_values       = match_conditions.value.match_values
          operator           = match_conditions.value.operator
          negation_condition = match_conditions.value.negation_condition
          transforms         = match_conditions.value.transforms
        }
      }
    }
  }

  #
  # Tags
  #

  tags = merge(local.default_tags, var.extra_tags)
}
