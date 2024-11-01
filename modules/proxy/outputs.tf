output "db_proxy_arn" {
  value = join("",aws_db_proxy.create_proxy.*.arn)
}
output "db_proxy_endpoint" {
  value = join("",aws_db_proxy.create_proxy.*.endpoint)
}
output "db_proxy_endpoints" {
  description = "Array containing the full resource object and attributes for all DB proxy endpoints created"
  value       = aws_db_proxy_endpoint.proxy_endpoint
}