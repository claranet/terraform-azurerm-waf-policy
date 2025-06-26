variable "policy_enabled" {
  description = "Describes if the policy is in `enabled` state or `disabled` state. Defaults to `true`."
  type        = string
  default     = true
}

variable "policy_mode" {
  description = "Describes if it is in detection mode or prevention mode at the policy level. Valid values are `Detection` and `Prevention`. Defaults to `Prevention`."
  type        = string
  default     = "Prevention"
}

variable "policy_file_limit" {
  description = "Policy regarding the size limit of uploaded files. Value is in MB. Accepted values are in the range `1` to `4000`. Defaults to `100`."
  type        = number
  nullable    = false
  default     = 100

  validation {
    condition     = var.policy_file_limit >= 1 && var.policy_file_limit <= 4000
    error_message = "The policy_file_limit parameter can only have a value comprised between 1 and 4000."
  }
}

variable "policy_request_body_check_enabled" {
  description = "Describes if the Request Body Inspection is enabled. Defaults to `true`."
  type        = string
  default     = true
}

variable "policy_max_body_size" {
  description = "Policy regarding the maximum request body size. Value is in KB. Accepted values are in the range `8` to `2000`. Defaults to `128`."
  type        = number
  default     = 128

  validation {
    condition     = var.policy_max_body_size >= 8 && var.policy_max_body_size <= 2000
    error_message = "The policy_max_body_size parameter can only have a value comprised between 8(Kb) and 2000(Kb)."
  }
}

variable "policy_request_body_enforcement" {
  description = "Whether the firewall should block a request with body size greater then max_request_body_size_in_kb. Defaults to `true`."
  type        = bool
  default     = true
}

variable "policy_request_body_inspect_limit" {
  description = "Specifies the maximum request body inspection limit in KB for the Web Application Firewall. Accepted values are in the range `8` to `2000`. Defaults to `128`."
  type        = number
  default     = 128

  validation {
    condition     = var.policy_request_body_inspect_limit >= 8 && var.policy_request_body_inspect_limit <= 2000
    error_message = "The policy_request_body_inspect_limit parameter can only have a value comprised between 8(Kb) and 2000(Kb)."
  }
}

variable "policy_js_challenge_cookie_expiration" {
  description = "Specifies the JavaScript challenge cookie validity lifetime in minutes. The user is challenged after the lifetime expires. Accepted values are in the range `5` to `1440`. Defaults to `30`."
  type        = number
  default     = 30

  validation {
    condition     = var.policy_js_challenge_cookie_expiration >= 5 && var.policy_js_challenge_cookie_expiration <= 1440
    error_message = "The policy_js_challenge_cookie_expiration parameter can only have a value comprised between 5 and 1440 minutes."
  }
}

variable "policy_file_upload_enforcement" {
  description = "Whether the firewall should block a request with upload size greater then file_upload_limit_in_mb. Defaults to `true`."
  type        = bool
  default     = true
}

variable "policy_log_scrubbing_enabled" {
  description = "Whether the log scrubbing is enabled or disabled. Defaults to `true`."
  type        = bool
  default     = true
}

variable "policy_log_scrubbing_rules" {
  description = <<EOD
Log scrubbing rules configuration object with following attributes:
```
- enabled:                   Whether this rule is enabled. Defaults to `true`.
- match_variable:            Specifies the variable to be scrubbed from the logs. Possible values are `RequestHeaderNames`, `RequestCookieNames`, `RequestArgNames`, `RequestPostArgNames`, `RequestJSONArgNames` and `RequestIPAddress`.
- selector_match_operator:   Specifies the operating on the selector. Possible values are `Equals` and `EqualsAny`. Defaults to `Equals`.
- selector:                  Specifies which elements in the collection this rule applies to.
```
EOD
  type = list(object({
    enabled                 = optional(bool, true)
    match_variable          = string
    selector_match_operator = optional(string, "Equals")
    selector                = optional(string)
  }))
  default = []
}

variable "custom_rules_configuration" {
  description = <<EOD
Custom rules configuration object with following attributes:
```
- enabled:                        Describes if the policy is in enabled state or disabled state. Defaults to `true`.
- name:                           Gets name of the resource that is unique within a policy. This name can be used to access the resource.
- priority:                       Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.
- rule_type:                      Describes the type of rule. Possible values are `MatchRule`, `RateLimitRule` and `Invalid`.
- action:                         Type of action. Possible values are `Allow`, `Block`, `JSChallenge` and `Log`.
- rate_limit_duration:            Specifies the duration at which the rate limit policy will be applied. Should be used with `RateLimitRule` rule type. Possible values are `FiveMins` and `OneMin`.
- rate_limit_threshold:           Specifies the threshold value for the rate limit policy. Must be greater than or equal to 1 if provided.
- group_rate_limit_by:            Specifies what grouping the rate limit will count requests by. Possible values are `GeoLocation`, `ClientAddr` and `None`.
- match_conditions_configuration: One or more `match_conditions` blocks as defined below.
- match_variable_configuration:   One or more match_variables blocks as defined below.
- variable_name:                  The name of the Match Variable. Possible values are RemoteAddr, RequestMethod, QueryString, PostArgs, RequestUri, RequestHeaders, RequestBody and RequestCookies.
- selector:                       Describes field of the matchVariable collection
- match_values:                   A list of match values.
- operator:                       Describes operator to be matched. Possible values are `Any`, `IPMatch`, `GeoMatch`, `Equal`, `Contains`, `LessThan`, `GreaterThan`, `LessThanOrEqual`, `GreaterThanOrEqual`, `BeginsWith`, `EndsWith` and `Regex`.
- negation_condition:             Describes if this is negate condition or not
- transforms:                     A list of transformations to do before the match is attempted. Possible values are `HtmlEntityDecode`, `Lowercase`, `RemoveNulls`, `Trim`, `Uppercase`, `UrlDecode` and `UrlEncode`.
```
EOD
  type = list(object({
    enabled              = optional(bool, true)
    name                 = optional(string)
    priority             = optional(number)
    rule_type            = optional(string)
    action               = optional(string)
    rate_limit_duration  = optional(string)
    rate_limit_threshold = optional(number)
    group_rate_limit_by  = optional(string)
    match_conditions_configuration = optional(list(object({
      match_variable_configuration = optional(list(object({
        variable_name = optional(string)
        selector      = optional(string, null)
      })))
      match_values       = optional(list(string))
      operator           = optional(string)
      negation_condition = optional(string, null)
      transforms         = optional(list(string), null)
    })))
  }))
  default = []
}

variable "exclusion_configuration" {
  description = <<EOD
Exclusion rules configuration object with following attributes:
```
- match_variable:          The name of the Match Variable. Accepted values can be found [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy#match_variable).
- selector:                Describes field of the matchVariable collection.
- selector_match_operator: Describes operator to be matched. Possible values: `Contains`, `EndsWith`, `Equals`, `EqualsAny`, `StartsWith`.
- excluded_rule_set:       One or more `excluded_rule_set` block defined below.
  - type:                  The rule set type. The only possible value is `OWASP`. Defaults to `OWASP`.
  - version:               The rule set version. The only possible value is `3.2`. Defaults to `3.2`.
  - rule_group:            One or more `rule_group` block defined below.
    - rule_group_name:     The name of rule group for exclusion. Accepted values can be found [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy#rule_group_name).
    - excluded_rules:      One or more Rule IDs for exclusion.
```
EOD
  type = list(object({
    match_variable          = optional(string)
    selector                = optional(string)
    selector_match_operator = optional(string)
    excluded_rule_set = optional(list(object({
      type    = optional(string, "OWASP")
      version = optional(string, "3.2")
      rule_group = optional(list(object({
        rule_group_name = string
        excluded_rules  = optional(list(string), [])
      })), [])
    })), [])
  }))
  default = []
}

variable "managed_rule_set_configuration" {
  description = "Managed rule set configuration."
  type = list(object({
    type    = optional(string, "OWASP")
    version = optional(string, "3.2")
    rule_group_override_configuration = optional(list(object({
      rule_group_name = optional(string, null)
      rule = optional(list(object({
        id      = string
        enabled = optional(bool)
        action  = optional(string)
      })), [])
    })))

  }))
  default = []
}
