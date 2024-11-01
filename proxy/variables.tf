variable "create_db_proxy" {
  type = bool
  default = true
}
variable "db_proxy_identifier" {
  type = string
}
variable "db_proxy_enable_debug_log" {
  type = bool
  default = false
}
variable "db_proxy_engine_family" {
  type = string
}
variable "db_proxy_idle_client_timeout" {
  type = number
  default = 1800
}
variable "db_proxy_enable_tls" {
  type = bool
  default = true
}
variable "db_proxy_role_arn" {
  type = string
}
variable "db_proxy_sg_ids" {
  type = list(string)
  default = []
}
variable "db_proxy_vpc_subnet_ids" {
  type = list(string)
}
# variable "secrets" {
#   description = "Map of secerets to be used by RDS Proxy for authentication to the database"
#   type        = map(object({ arn = string, description = string, kms_key_id = string }))
#   default     = {}
# }
variable "secrets" {
  type = list(any)
  default     = []
}
variable "auth_scheme" {
  description = "The type of authentication that the proxy uses for connections from the proxy to the underlying database. One of `SECRETS`"
  type        = string
  default     = "SECRETS"
}

variable "iam_auth" {
  description = "Whether to require or disallow AWS Identity and Access Management (IAM) authentication for connections to the proxy. One of `DISABLED`, `REQUIRED`"
  type        = string
  default     = "DISABLED"
}
variable "db_proxy_tags" {
  type = map(any)
  default = {}
}
# Proxy Default Target Group
variable "db_proxy_connection_borrow_timeout" {
  description = "The number of seconds for a proxy to wait for a connection to become available in the connection pool"
  type        = number
  default     = null
}

variable "db_proxy_init_query" {
  description = "One or more SQL statements for the proxy to run when opening each new database connection"
  type        = string
  default     = ""
}

variable "db_proxy_max_connections_percent" {
  description = "The maximum size of the connection pool for each target in a target group"
  type        = number
  default     = 90
}

variable "db_proxy_max_idle_connections_percent" {
  description = "Controls how actively the proxy closes idle database connections in the connection pool"
  type        = number
  default     = 50
}

variable "db_proxy_session_pinning_filters" {
  description = "Each item in the list represents a class of SQL operations that normally cause all later statements in a session using a proxy to be pinned to the same underlying database connection"
  type        = list(string)
  default     = []
}
# Proxy Target
variable "target_db_instance" {
  description = "Determines whether DB instance is targetted by proxy"
  type        = bool
  default     = false
}

variable "db_instance_identifier" {
  description = "DB instance identifier"
  type        = string
  default     = ""
}

variable "target_db_cluster" {
  description = "Determines whether DB cluster is targetted by proxy"
  type        = bool
  default     = false
}

variable "db_cluster_identifier" {
  description = "DB cluster identifier"
  type        = string
  default     = ""
}
# Proxy endpoints
variable "db_proxy_endpoints" {
  description = "Map of DB proxy endpoints to create and their attributes (see `aws_db_proxy_endpoint`)"
  type        = any
  default     = {}
}
# CloudWatch Logs
variable "manage_log_group" {
  description = "Determines whether Terraform will create/manage the CloudWatch log group or not. Note - this will fail if set to true after the log group has been created as the resource will already exist"
  type        = bool
  default     = true
}

variable "log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the log group"
  type        = number
  default     = 30
}

variable "log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = null
}

variable "log_group_tags" {
  description = "A map of tags to apply to the CloudWatch log group"
  type        = map(string)
  default     = {}
}