locals {
  # Naming locals/constants
  default_policy_name = "${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-waf-policy"

  policy_name = coalesce(var.waf_policy_custom_name, local.default_policy_name)
}
