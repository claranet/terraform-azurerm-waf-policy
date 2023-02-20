locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  policy_name = coalesce(var.waf_policy_custom_name, lower(data.azurecaf_name.wafp.result))
}
