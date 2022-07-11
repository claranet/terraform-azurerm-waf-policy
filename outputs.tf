output "waf_policy_id" {
  description = "Waf Policy ID"
  value       = azurerm_web_application_firewall_policy.waf_policy.id
}
