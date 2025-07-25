# Azure WAF Policies
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/waf-policy/azurerm/latest)

This terraform module creates an [Azure WAF policy](https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/policy-overview) with OWASP 3.2 enabled

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
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
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2.28 |
| azurerm | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_web_application_firewall_policy.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy) | resource |
| [azurecaf_name.wafp](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_name | WAF Policy custom name. | `string` | `null` | no |
| custom\_rules\_configuration | Custom rules configuration object with following attributes:<pre>- enabled:                        Describes if the policy is in enabled state or disabled state. Defaults to `true`.<br/>- name:                           Gets name of the resource that is unique within a policy. This name can be used to access the resource.<br/>- priority:                       Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.<br/>- rule_type:                      Describes the type of rule. Possible values are `MatchRule`, `RateLimitRule` and `Invalid`.<br/>- action:                         Type of action. Possible values are `Allow`, `Block`, `JSChallenge` and `Log`.<br/>- rate_limit_duration:            Specifies the duration at which the rate limit policy will be applied. Should be used with `RateLimitRule` rule type. Possible values are `FiveMins` and `OneMin`.<br/>- rate_limit_threshold:           Specifies the threshold value for the rate limit policy. Must be greater than or equal to 1 if provided.<br/>- group_rate_limit_by:            Specifies what grouping the rate limit will count requests by. Possible values are `GeoLocation`, `ClientAddr` and `None`.<br/>- match_conditions_configuration: One or more `match_conditions` blocks as defined below.<br/>- match_variable_configuration:   One or more match_variables blocks as defined below.<br/>- variable_name:                  The name of the Match Variable. Possible values are RemoteAddr, RequestMethod, QueryString, PostArgs, RequestUri, RequestHeaders, RequestBody and RequestCookies.<br/>- selector:                       Describes field of the matchVariable collection<br/>- match_values:                   A list of match values.<br/>- operator:                       Describes operator to be matched. Possible values are `Any`, `IPMatch`, `GeoMatch`, `Equal`, `Contains`, `LessThan`, `GreaterThan`, `LessThanOrEqual`, `GreaterThanOrEqual`, `BeginsWith`, `EndsWith` and `Regex`.<br/>- negation_condition:             Describes if this is negate condition or not<br/>- transforms:                     A list of transformations to do before the match is attempted. Possible values are `HtmlEntityDecode`, `Lowercase`, `RemoveNulls`, `Trim`, `Uppercase`, `UrlDecode` and `UrlEncode`.</pre> | <pre>list(object({<br/>    enabled              = optional(bool, true)<br/>    name                 = optional(string)<br/>    priority             = optional(number)<br/>    rule_type            = optional(string)<br/>    action               = optional(string)<br/>    rate_limit_duration  = optional(string)<br/>    rate_limit_threshold = optional(number)<br/>    group_rate_limit_by  = optional(string)<br/>    match_conditions_configuration = optional(list(object({<br/>      match_variable_configuration = optional(list(object({<br/>        variable_name = optional(string)<br/>        selector      = optional(string, null)<br/>      })))<br/>      match_values       = optional(list(string))<br/>      operator           = optional(string)<br/>      negation_condition = optional(string, null)<br/>      transforms         = optional(list(string), null)<br/>    })))<br/>  }))</pre> | `[]` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| exclusion\_configuration | Exclusion rules configuration object with following attributes:<pre>- match_variable:          The name of the Match Variable. Accepted values can be found [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy#match_variable).<br/>- selector:                Describes field of the matchVariable collection.<br/>- selector_match_operator: Describes operator to be matched. Possible values: `Contains`, `EndsWith`, `Equals`, `EqualsAny`, `StartsWith`.<br/>- excluded_rule_set:       One or more `excluded_rule_set` block defined below.<br/>  - type:                  The rule set type. The only possible value is `OWASP`. Defaults to `OWASP`.<br/>  - version:               The rule set version. The only possible value is `3.2`. Defaults to `3.2`.<br/>  - rule_group:            One or more `rule_group` block defined below.<br/>    - rule_group_name:     The name of rule group for exclusion. Accepted values can be found [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy#rule_group_name).<br/>    - excluded_rules:      One or more Rule IDs for exclusion.</pre> | <pre>list(object({<br/>    match_variable          = optional(string)<br/>    selector                = optional(string)<br/>    selector_match_operator = optional(string)<br/>    excluded_rule_set = optional(list(object({<br/>      type    = optional(string, "OWASP")<br/>      version = optional(string, "3.2")<br/>      rule_group = optional(list(object({<br/>        rule_group_name = string<br/>        excluded_rules  = optional(list(string), [])<br/>      })), [])<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| extra\_tags | Extra tags to add. | `map(string)` | `{}` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| managed\_rule\_set\_configuration | Managed rule set configuration. | <pre>list(object({<br/>    type    = optional(string, "OWASP")<br/>    version = optional(string, "3.2")<br/>    rule_group_override_configuration = optional(list(object({<br/>      rule_group_name = optional(string, null)<br/>      rule = optional(list(object({<br/>        id      = string<br/>        enabled = optional(bool)<br/>        action  = optional(string)<br/>      })), [])<br/>    })))<br/><br/>  }))</pre> | `[]` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| policy\_enabled | Describes if the policy is in `enabled` state or `disabled` state. Defaults to `true`. | `string` | `true` | no |
| policy\_file\_limit | Policy regarding the size limit of uploaded files. Value is in MB. Accepted values are in the range `1` to `4000`. Defaults to `100`. | `number` | `100` | no |
| policy\_file\_upload\_enforcement | Whether the firewall should block a request with upload size greater then file\_upload\_limit\_in\_mb. Defaults to `true`. | `bool` | `true` | no |
| policy\_js\_challenge\_cookie\_expiration | Specifies the JavaScript challenge cookie validity lifetime in minutes. The user is challenged after the lifetime expires. Accepted values are in the range `5` to `1440`. Defaults to `30`. | `number` | `30` | no |
| policy\_log\_scrubbing\_enabled | Whether the log scrubbing is enabled or disabled. Defaults to `true`. | `bool` | `true` | no |
| policy\_log\_scrubbing\_rules | Log scrubbing rules configuration object with following attributes:<pre>- enabled:                   Whether this rule is enabled. Defaults to `true`.<br/>- match_variable:            Specifies the variable to be scrubbed from the logs. Possible values are `RequestHeaderNames`, `RequestCookieNames`, `RequestArgNames`, `RequestPostArgNames`, `RequestJSONArgNames` and `RequestIPAddress`.<br/>- selector_match_operator:   Specifies the operating on the selector. Possible values are `Equals` and `EqualsAny`. Defaults to `Equals`.<br/>- selector:                  Specifies which elements in the collection this rule applies to.</pre> | <pre>list(object({<br/>    enabled                 = optional(bool, true)<br/>    match_variable          = string<br/>    selector_match_operator = optional(string, "Equals")<br/>    selector                = optional(string)<br/>  }))</pre> | `[]` | no |
| policy\_max\_body\_size | Policy regarding the maximum request body size. Value is in KB. Accepted values are in the range `8` to `2000`. Defaults to `128`. | `number` | `128` | no |
| policy\_mode | Describes if it is in detection mode or prevention mode at the policy level. Valid values are `Detection` and `Prevention`. Defaults to `Prevention`. | `string` | `"Prevention"` | no |
| policy\_request\_body\_check\_enabled | Describes if the Request Body Inspection is enabled. Defaults to `true`. | `string` | `true` | no |
| policy\_request\_body\_enforcement | Whether the firewall should block a request with body size greater then max\_request\_body\_size\_in\_kb. Defaults to `true`. | `bool` | `true` | no |
| policy\_request\_body\_inspect\_limit | Specifies the maximum request body inspection limit in KB for the Web Application Firewall. Accepted values are in the range `8` to `2000`. Defaults to `128`. | `number` | `128` | no |
| resource\_group\_name | Resource Group Name. | `string` | n/a | yes |
| stack | Project stack name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| http\_listener\_ids | A list of HTTP Listener IDs from an azurerm\_application\_gateway. |
| id | WAF Policy ID. |
| name | WAF Policy name. |
| path\_based\_rule\_ids | A list of URL Path Map Path Rule IDs from an azurerm\_application\_gateway. |
| resource | WAF Policy resource object. |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/web-application-firewall/ag/policy-overview/](https://docs.microsoft.com/en-us/azure/web-application-firewall/ag/policy-overview/)
