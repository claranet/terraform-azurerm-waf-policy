output "id" {
  description = "WAF Policy ID."
  value       = azurerm_web_application_firewall_policy.main.id
}

output "name" {
  description = "WAF Policy name."
  value       = azurerm_web_application_firewall_policy.main.name
}

output "resource" {
  description = "WAF Policy resource object."
  value       = azurerm_web_application_firewall_policy.main
}

output "http_listener_ids" {
  description = "A list of HTTP Listener IDs from an azurerm_application_gateway."
  value       = azurerm_web_application_firewall_policy.main.http_listener_ids
}

output "path_based_rule_ids" {
  description = "A list of URL Path Map Path Rule IDs from an azurerm_application_gateway."
  value       = azurerm_web_application_firewall_policy.main.path_based_rule_ids
}
