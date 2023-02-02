# Azure WAF Policies
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/waf-policy/azurerm/latest)

This terraform module creates an [Azure WAF policy](https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/policy-overview) with OWASP 3.2 enabled

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "waf_policy" {
  source  = "claranet/waf-policy/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  policy_mode = "Detection"

  managed_rule_set_configuration = [
    {
      type    = "OWASP"
      version = "3.2"
    }
  ]

  exclusion_configuration = [

  ]

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
| azurecaf | ~> 1.2, >= 1.2.22 |
| azurerm | ~> 3.22, < 3.36 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_web_application_firewall_policy.waf_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy) | resource |
| [azurecaf_name.wafp](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| custom\_rules\_configuration | Custom rules configuration | `any` | `{}` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment | `string` | n/a | yes |
| exclusion\_configuration | Exclusion configuration | `any` | `[]` | no |
| extra\_tags | Extra tags to add. | `map(string)` | `{}` | no |
| location | Location | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| managed\_rule\_set\_configuration | Managed rule set configuration | `list(map(string))` | <pre>[<br>  {<br>    "type": "OWASP",<br>    "version": "3.2"<br>  }<br>]</pre> | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| policy\_enabled | Enable policy | `string` | `true` | no |
| policy\_file\_limit | Policy file limit | `number` | `100` | no |
| policy\_max\_body\_size | Policy max body size | `number` | `128` | no |
| policy\_mode | Policy Mode | `string` | `"Prevention"` | no |
| policy\_request\_body\_check | Policy request body check | `string` | `true` | no |
| resource\_group\_name | Resource Group Name | `string` | n/a | yes |
| rule\_group\_override\_configuration | The rule group where specific rules should be disabled. Accepted values can be found here: https://www.terraform.io/docs/providers/azurerm/r/application_gateway.html#rule_group_name | <pre>list(object({<br>    rule_group_name = string<br>    disabled_rules  = list(string)<br>  }))</pre> | `[]` | no |
| stack | Project stack name | `string` | n/a | yes |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `waf_policy_custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |
| waf\_policy\_custom\_name | Custom WAF Policy name, generated if not set | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| http\_listener\_ids | A list of HTTP Listener IDs from an azurerm\_application\_gateway. |
| path\_based\_rule\_ids | A list of URL Path Map Path Rule IDs from an azurerm\_application\_gateway. |
| waf\_policy\_id | Waf Policy ID |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/web-application-firewall/ag/policy-overview/](https://docs.microsoft.com/en-us/azure/web-application-firewall/ag/policy-overview/)
