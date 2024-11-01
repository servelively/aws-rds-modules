## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_aws.secondary"></a> [aws.secondary](#provider\_aws.secondary) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora_primary"></a> [aurora\_primary](#module\_aurora\_primary) | s3::https://s3.amazonaws.com/aws-hid-terraform-modules/hidmodules_v5.0.zip//hidmodules/rds/cluster | n/a |
| <a name="module_aurora_secondary"></a> [aurora\_secondary](#module\_aurora\_secondary) | s3::https://s3.amazonaws.com/aws-hid-terraform-modules/hidmodules_v5.0.zip//hidmodules/rds/cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_rds_global_cluster.global_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_global_cluster) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks_primarydb"></a> [allowed\_cidr\_blocks\_primarydb](#input\_allowed\_cidr\_blocks\_primarydb) | A list of CIDR blocks which are allowed to access the database | `list(string)` | `[]` | no |
| <a name="input_allowed_cidr_blocks_secondarydb"></a> [allowed\_cidr\_blocks\_secondarydb](#input\_allowed\_cidr\_blocks\_secondarydb) | A list of CIDR blocks which are allowed to access the database | `list(string)` | `[]` | no |
| <a name="input_allowed_security_groups_primarydb"></a> [allowed\_security\_groups\_primarydb](#input\_allowed\_security\_groups\_primarydb) | A list of Security Group ID's to allow access to | `list(string)` | `[]` | no |
| <a name="input_allowed_security_groups_secondarydb"></a> [allowed\_security\_groups\_secondarydb](#input\_allowed\_security\_groups\_secondarydb) | A list of Security Group ID's to allow access to | `list(string)` | `[]` | no |
| <a name="input_create_global_cluster"></a> [create\_global\_cluster](#input\_create\_global\_cluster) | n/a | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines whether to create security group for RDS cluster | `bool` | `true` | no |
| <a name="input_db_database_name"></a> [db\_database\_name](#input\_db\_database\_name) | n/a | `string` | n/a | yes |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The instance type of the RDS instance | `string` | `"db.t3.medium"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | n/a | yes |
| <a name="input_db_primary_subnet_group_name"></a> [db\_primary\_subnet\_group\_name](#input\_db\_primary\_subnet\_group\_name) | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `string` | `""` | no |
| <a name="input_db_secondary_subnet_group_name"></a> [db\_secondary\_subnet\_group\_name](#input\_db\_secondary\_subnet\_group\_name) | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `string` | `""` | no |
| <a name="input_db_skip_final_snapshot"></a> [db\_skip\_final\_snapshot](#input\_db\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | `bool` | `true` | no |
| <a name="input_db_storage_encrypted"></a> [db\_storage\_encrypted](#input\_db\_storage\_encrypted) | n/a | `bool` | `false` | no |
| <a name="input_db_tags"></a> [db\_tags](#input\_db\_tags) | A mapping of tags to assign to all resources | `map(string)` | <pre>{<br/>  "Terraform": true<br/>}</pre> | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Username for the master DB user | `string` | n/a | yes |
| <a name="input_global_cluster_engine"></a> [global\_cluster\_engine](#input\_global\_cluster\_engine) | n/a | `string` | n/a | yes |
| <a name="input_global_cluster_engine_version"></a> [global\_cluster\_engine\_version](#input\_global\_cluster\_engine\_version) | n/a | `string` | n/a | yes |
| <a name="input_global_cluster_name"></a> [global\_cluster\_name](#input\_global\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_primary_db_region"></a> [primary\_db\_region](#input\_primary\_db\_region) | n/a | `string` | n/a | yes |
| <a name="input_primary_db_tags"></a> [primary\_db\_tags](#input\_primary\_db\_tags) | A mapping of tags to assign to primary cluster | `map(string)` | <pre>{<br/>  "Terraform": true<br/>}</pre> | no |
| <a name="input_primary_db_vpc_id"></a> [primary\_db\_vpc\_id](#input\_primary\_db\_vpc\_id) | ID of the VPC where to create security group of Primary Cluster | `string` | `""` | no |
| <a name="input_secondary_db_region"></a> [secondary\_db\_region](#input\_secondary\_db\_region) | n/a | `string` | n/a | yes |
| <a name="input_secondary_db_tags"></a> [secondary\_db\_tags](#input\_secondary\_db\_tags) | A mapping of tags to assign to secondary cluster | `map(string)` | <pre>{<br/>  "Terraform": true<br/>}</pre> | no |
| <a name="input_secondary_db_vpc_id"></a> [secondary\_db\_vpc\_id](#input\_secondary\_db\_vpc\_id) | ID of the VPC where to create security group of Secondary Cluster | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_cluster_arn"></a> [primary\_cluster\_arn](#output\_primary\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_primary_cluster_endpoint"></a> [primary\_cluster\_endpoint](#output\_primary\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_primary_cluster_id"></a> [primary\_cluster\_id](#output\_primary\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_primary_cluster_members"></a> [primary\_cluster\_members](#output\_primary\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_primary_cluster_reader_endpoint"></a> [primary\_cluster\_reader\_endpoint](#output\_primary\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_primary_cluster_resource_id"></a> [primary\_cluster\_resource\_id](#output\_primary\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_primary_security_group_id"></a> [primary\_security\_group\_id](#output\_primary\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_secondary_cluster_arn"></a> [secondary\_cluster\_arn](#output\_secondary\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_secondary_cluster_endpoint"></a> [secondary\_cluster\_endpoint](#output\_secondary\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_secondary_cluster_id"></a> [secondary\_cluster\_id](#output\_secondary\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_secondary_cluster_members"></a> [secondary\_cluster\_members](#output\_secondary\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_secondary_cluster_reader_endpoint"></a> [secondary\_cluster\_reader\_endpoint](#output\_secondary\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_secondary_cluster_resource_id"></a> [secondary\_cluster\_resource\_id](#output\_secondary\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_secondary_security_group_id"></a> [secondary\_security\_group\_id](#output\_secondary\_security\_group\_id) | The security group ID of the cluster |
