variable "create_global_cluster" {
  type = bool
  default = true
}
variable "primary_db_region" {
  type = string
}
variable "secondary_db_region" {
  type = string
}

variable "global_cluster_name" {
  type = string
}
variable "global_cluster_engine" {
  type = string
}
variable "global_cluster_engine_version" {
  type = string
}
variable "db_database_name" {
  type = string
}
variable "db_storage_encrypted" {
  type = bool
  default = false
}
variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default = "db.t3.medium"
}

variable "primary_db_vpc_id" {
  description = "ID of the VPC where to create security group of Primary Cluster"
  type        = string
  default     = ""
}
variable "secondary_db_vpc_id" {
  description = "ID of the VPC where to create security group of Secondary Cluster"
  type        = string
  default     = ""
}

variable "db_primary_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = ""
}
variable "db_secondary_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = ""
}
variable "create_security_group" {
  description = "Determines whether to create security group for RDS cluster"
  type        = bool
  default     = true
}

variable "allowed_security_groups_primarydb" {
  description = "A list of Security Group ID's to allow access to"
  type        = list(string)
  default     = []
}
variable "allowed_security_groups_secondarydb" {
  description = "A list of Security Group ID's to allow access to"
  type        = list(string)
  default     = []
}
variable "allowed_cidr_blocks_primarydb" {
  description = "A list of CIDR blocks which are allowed to access the database"
  type        = list(string)
  default     = []
}
variable "allowed_cidr_blocks_secondarydb" {
  description = "A list of CIDR blocks which are allowed to access the database"
  type        = list(string)
  default     = []
}
variable "db_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  type        = bool
  default     = true
}
variable "db_tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {
    Terraform = true
  }
}
variable "primary_db_tags" {
  description = "A mapping of tags to assign to primary cluster"
  type        = map(string)
  default     = {
    Terraform = true
  }
}
variable "secondary_db_tags" {
  description = "A mapping of tags to assign to secondary cluster"
  type        = map(string)
  default     = {
    Terraform = true
  }
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "db_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
}