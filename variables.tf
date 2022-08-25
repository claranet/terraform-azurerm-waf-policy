variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "custom_name" {
  description = "Custom WAF Policy name, generated if not set"
  type        = string
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
  description = "Location"
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "custom_rules_configuration" {
  description = "Custom rules configuration"
  type        = any
}

variable "policy_enabled" {
  description = "Enable policy"
  type        = string
  default     = true
}

variable "policy_mode" {
  description = "Policy Mode"
  type        = string
  default     = "Prevention"
}

variable "policy_file_limit" {
  description = "Policy file limit"
  type        = string
  default     = "100"
}

variable "policy_request_body_check" {
  description = "Policy request body check"
  type        = string
  default     = true
}

variable "policy_max_body_size" {
  description = "Polixy max body size"
  type        = string
  default     = "128"
}

variable "exclusion_configuration" {
  description = "Exclusion configuration"
  type        = any
  default     = []
}

variable "managed_rule_set_configuration" {
  description = "Managed rule set configuration"
  type        = list(map(string))
  default     = []
}

variable "rule_group_override_configuration" {
  description = "The rule group where specific rules should be disabled. Accepted values can be found here: https://www.terraform.io/docs/providers/azurerm/r/application_gateway.html#rule_group_name"
  type = list(object({
    rule_group_name = string
    disabled_rules  = list(string)
  }))
  default = []
}
