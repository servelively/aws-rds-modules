## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.db_proxy_loggroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_proxy.create_proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy) | resource |
| [aws_db_proxy_default_target_group.default_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy_default_target_group) | resource |
| [aws_db_proxy_endpoint.proxy_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy_endpoint) | resource |
| [aws_db_proxy_target.db_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy_target) | resource |
| [aws_db_proxy_target.db_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_scheme"></a> [auth\_scheme](#input\_auth\_scheme) | The type of authentication that the proxy uses for connections from the proxy to the underlying database. One of `SECRETS` | `string` | `"SECRETS"` | no |
| <a name="input_create_db_proxy"></a> [create\_db\_proxy](#input\_create\_db\_proxy) | n/a | `bool` | `true` | no |
| <a name="input_db_cluster_identifier"></a> [db\_cluster\_identifier](#input\_db\_cluster\_identifier) | DB cluster identifier | `string` | `""` | no |
| <a name="input_db_instance_identifier"></a> [db\_instance\_identifier](#input\_db\_instance\_identifier) | DB instance identifier | `string` | `""` | no |
| <a name="input_db_proxy_connection_borrow_timeout"></a> [db\_proxy\_connection\_borrow\_timeout](#input\_db\_proxy\_connection\_borrow\_timeout) | The number of seconds for a proxy to wait for a connection to become available in the connection pool | `number` | `null` | no |
| <a name="input_db_proxy_enable_debug_log"></a> [db\_proxy\_enable\_debug\_log](#input\_db\_proxy\_enable\_debug\_log) | n/a | `bool` | `false` | no |
| <a name="input_db_proxy_enable_tls"></a> [db\_proxy\_enable\_tls](#input\_db\_proxy\_enable\_tls) | n/a | `bool` | `true` | no |
| <a name="input_db_proxy_endpoints"></a> [db\_proxy\_endpoints](#input\_db\_proxy\_endpoints) | Map of DB proxy endpoints to create and their attributes (see `aws_db_proxy_endpoint`) | `any` | `{}` | no |
| <a name="input_db_proxy_engine_family"></a> [db\_proxy\_engine\_family](#input\_db\_proxy\_engine\_family) | n/a | `string` | n/a | yes |
| <a name="input_db_proxy_identifier"></a> [db\_proxy\_identifier](#input\_db\_proxy\_identifier) | n/a | `string` | n/a | yes |
| <a name="input_db_proxy_idle_client_timeout"></a> [db\_proxy\_idle\_client\_timeout](#input\_db\_proxy\_idle\_client\_timeout) | n/a | `number` | `1800` | no |
| <a name="input_db_proxy_init_query"></a> [db\_proxy\_init\_query](#input\_db\_proxy\_init\_query) | One or more SQL statements for the proxy to run when opening each new database connection | `string` | `""` | no |
| <a name="input_db_proxy_max_connections_percent"></a> [db\_proxy\_max\_connections\_percent](#input\_db\_proxy\_max\_connections\_percent) | The maximum size of the connection pool for each target in a target group | `number` | `90` | no |
| <a name="input_db_proxy_max_idle_connections_percent"></a> [db\_proxy\_max\_idle\_connections\_percent](#input\_db\_proxy\_max\_idle\_connections\_percent) | Controls how actively the proxy closes idle database connections in the connection pool | `number` | `50` | no |
| <a name="input_db_proxy_role_arn"></a> [db\_proxy\_role\_arn](#input\_db\_proxy\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_db_proxy_session_pinning_filters"></a> [db\_proxy\_session\_pinning\_filters](#input\_db\_proxy\_session\_pinning\_filters) | Each item in the list represents a class of SQL operations that normally cause all later statements in a session using a proxy to be pinned to the same underlying database connection | `list(string)` | `[]` | no |
| <a name="input_db_proxy_sg_ids"></a> [db\_proxy\_sg\_ids](#input\_db\_proxy\_sg\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_db_proxy_tags"></a> [db\_proxy\_tags](#input\_db\_proxy\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_db_proxy_vpc_subnet_ids"></a> [db\_proxy\_vpc\_subnet\_ids](#input\_db\_proxy\_vpc\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_iam_auth"></a> [iam\_auth](#input\_iam\_auth) | Whether to require or disallow AWS Identity and Access Management (IAM) authentication for connections to the proxy. One of `DISABLED`, `REQUIRED` | `string` | `"DISABLED"` | no |
| <a name="input_log_group_kms_key_id"></a> [log\_group\_kms\_key\_id](#input\_log\_group\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data | `string` | `null` | no |
| <a name="input_log_group_retention_in_days"></a> [log\_group\_retention\_in\_days](#input\_log\_group\_retention\_in\_days) | Specifies the number of days you want to retain log events in the log group | `number` | `30` | no |
| <a name="input_log_group_tags"></a> [log\_group\_tags](#input\_log\_group\_tags) | A map of tags to apply to the CloudWatch log group | `map(string)` | `{}` | no |
| <a name="input_manage_log_group"></a> [manage\_log\_group](#input\_manage\_log\_group) | Determines whether Terraform will create/manage the CloudWatch log group or not. Note - this will fail if set to true after the log group has been created as the resource will already exist | `bool` | `true` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | variable "secrets" { description = "Map of secerets to be used by RDS Proxy for authentication to the database" type        = map(object({ arn = string, description = string, kms\_key\_id = string })) default     = {} } | `list(any)` | `[]` | no |
| <a name="input_target_db_cluster"></a> [target\_db\_cluster](#input\_target\_db\_cluster) | Determines whether DB cluster is targetted by proxy | `bool` | `false` | no |
| <a name="input_target_db_instance"></a> [target\_db\_instance](#input\_target\_db\_instance) | Determines whether DB instance is targetted by proxy | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_proxy_arn"></a> [db\_proxy\_arn](#output\_db\_proxy\_arn) | n/a |
| <a name="output_db_proxy_endpoint"></a> [db\_proxy\_endpoint](#output\_db\_proxy\_endpoint) | n/a |
| <a name="output_db_proxy_endpoints"></a> [db\_proxy\_endpoints](#output\_db\_proxy\_endpoints) | Array containing the full resource object and attributes for all DB proxy endpoints created |
