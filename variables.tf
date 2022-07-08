variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "name_prefix" {
  description = "Optional prefix for resource name"
  type        = string
  default     = ""
}

variable "custom_name" {
  description = "Custom WAF Policy name, generated if not set"
  default     = ""
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "location" {
  type = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "custom_rules_configuration" {
  type    = any
  default = []
}

variable "match_conditions_configuration" {
  type    = any
  default = []
}

variable "custom_match_variables" {
  type    = any
  default = {}
}

variable "custom_tags" {
  type    = map(string)
  default = {}
}

variable "creation_date" {
  type = string
}

variable "countries" {
  type = string
}

variable "policy_enabled" {
  type    = string
  default = true
}

variable "policy_mode" {
  type    = string
  default = "Prevention"
}

variable "policy_file_limit" {
  type    = string
  default = "100"
}

variable "policy_request_body_check" {
  type    = string
  default = true
}

variable "policy_max_body_size" {
  type    = string
  default = "128"
}

variable "exclusion_configuration" {
  type    = any
  default = []
}

variable "managed_rule_set_configuration" {
  type    = any
  default = []
}

variable "rule_group_override_configuration" {
  description = "The rule group where specific rules should be disabled. Accepted values can be found here: https://www.terraform.io/docs/providers/azurerm/r/application_gateway.html#rule_group_name"
  type = list(object({
    rule_group_name = string
    disabled_rules  = list(string)
  }))
  default = []
}
