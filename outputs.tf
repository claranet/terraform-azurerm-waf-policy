output "waf_policy_id" {
  description = "Waf Policy ID"
  value       = azurerm_web_application_firewall_policy.waf_policy.id
}

output "http_listener_ids" {
  description = "A list of HTTP Listener IDs from an azurerm_application_gateway."
  value       = azurerm_web_application_firewall_policy.waf_policy.http_listener_ids
}

output "path_based_rule_ids" {
  description = "A list of URL Path Map Path Rule IDs from an azurerm_application_gateway."
  value       = azurerm_web_application_firewall_policy.waf_policy.path_based_rule_ids
}