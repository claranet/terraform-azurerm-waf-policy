# Custom naming override
variable "waf_policy_custom_name" {
  description = "Custom WAF Policy name, generated if not set"
  type        = string
  default     = ""
}
