output "id" {
  description = "The ID of the Log Analytics Workspace."
  value       = module.log_analytics_workspace.resource.id
}

output "name" {
  description = "The name of the Log Analytics Workspace."
  value       = module.log_analytics_workspace.resource.name
}
