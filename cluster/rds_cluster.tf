locals {
  port = coalesce(var.db_port, (var.db_engine == "aurora-postgresql" ? 5432 : 3306))
  rds_security_group_id       = join("", aws_security_group.cluster_sg.*.id)
}

resource "aws_rds_cluster" "postgresql" {
  count                                 = var.create_cluster ? 1 : 0
  cluster_identifier                    =  "${var.db_identifier}-cluster"
  global_cluster_identifier             = var.global_cluster_identifier
  engine                                = var.db_engine
  engine_version                        = var.db_engine_version
  availability_zones                    = var.db_aws_availability_zones
  database_name                         = var.is_primary_cluster ? var.db_name : null
  master_username                       = var.is_primary_cluster ? var.db_username : null
  master_password                       = var.is_primary_cluster ? var.db_password : null
  backup_retention_period               = var.db_backup_retention_period
  db_cluster_parameter_group_name       = var.db_parameter_group_name
  preferred_backup_window               = var.db_preferred_backup_window
  port                                  = local.port
  skip_final_snapshot                   = var.db_skip_final_snapshot
  vpc_security_group_ids                = compact(concat(aws_security_group.cluster_sg.*.id, var.db_vpc_security_group_ids))
  db_subnet_group_name                  = var.db_subnet_group_name
  storage_encrypted                     = var.db_storage_encrypted  
  kms_key_id                            = var.db_kms_key_id
  iam_database_authentication_enabled   = var.db_iam_database_authentication_enabled
  source_region                         = var.replica_source_region
  allow_major_version_upgrade           = var.db_allow_major_version_upgrade
  apply_immediately                     = var.db_apply_immediately
  preferred_maintenance_window          = var.db_preferred_maintenance_window
  snapshot_identifier                   = var.db_snapshot_identifier
  enabled_cloudwatch_logs_exports       = var.db_enabled_cloudwatch_logs_exports
  deletion_protection                   = var.db_deletion_protection
  tags                                  = var.db_tags
  timeouts {
    create = lookup(var.db_timeouts, "create", 120)
    delete = lookup(var.db_timeouts, "delete", 120)
    update = lookup(var.db_timeouts, "update", 120)
  }

  lifecycle  {
      ignore_changes = [availability_zones]
  
  }
}

resource "random_string" "lower" {
  length  = 8
  upper   = false
  lower   = true
  number  = false
  special = false
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                        = var.create_cluster ? var.db_dbinstance_count : 0
  identifier                   = var.instance_identifier == null ? "${var.db_identifier}-${random_string.lower.result}" : var.instance_identifier[count.index]
  cluster_identifier           = aws_rds_cluster.postgresql.0.id
  instance_class               = var.db_instance_class
  engine                       = aws_rds_cluster.postgresql.0.engine
  engine_version               = aws_rds_cluster.postgresql.0.engine_version
  db_subnet_group_name         = var.db_subnet_group_name
  db_parameter_group_name      = var.db_parameter_group_name
  publicly_accessible          = var.db_publicly_accessible
  auto_minor_version_upgrade   = var.db_auto_minor_version_upgrade
  apply_immediately            = var.db_apply_immediately
  preferred_maintenance_window = var.db_preferred_maintenance_window
  preferred_backup_window      = var.db_preferred_backup_window
  monitoring_interval          = var.db_monitoring_interval
  monitoring_role_arn          = var.db_monitoring_role_arn
  ca_cert_identifier           = var.db_ca_cert_identifier  
  tags                         = var.db_tags
  timeouts {
    create = lookup(var.db_timeouts, "create", null)
    delete = lookup(var.db_timeouts, "delete", null)
    update = lookup(var.db_timeouts, "update", null)
  }
}

################################################################################
# Security Group
################################################################################

resource "aws_security_group" "cluster_sg" {
  count = var.create_cluster && var.create_security_group ? 1 : 0

  name        = var.security_group_use_name_prefix ? null : "${var.db_identifier}-security-group"
  name_prefix = var.security_group_use_name_prefix ? "${var.db_identifier}-" : null
  vpc_id      = var.vpc_id
  description = coalesce(var.security_group_description, "Control traffic to/from RDS Aurora ${var.db_identifier}")

  tags = merge(var.db_tags, var.security_group_tags, { Name = "${var.db_identifier}-security-group" })

  lifecycle {
    create_before_destroy = true
  }
}

# TODO - change to map of ingress rules under one resource at next breaking change
resource "aws_security_group_rule" "default_ingress" {
  count = var.create_cluster && var.create_security_group ? length(var.allowed_security_groups) : 0

  description = "From allowed SGs"

  type                     = "ingress"
  from_port                = local.port
  to_port                  = local.port
  protocol                 = "tcp"
  source_security_group_id = element(var.allowed_security_groups, count.index)
  security_group_id        = local.rds_security_group_id
}

# TODO - change to map of ingress rules under one resource at next breaking change
resource "aws_security_group_rule" "cidr_ingress" {
  count = var.create_cluster && var.create_security_group && length(var.allowed_cidr_blocks) > 0 ? 1 : 0

  description = "From allowed CIDRs"

  type              = "ingress"
  from_port         = local.port
  to_port           = local.port
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = local.rds_security_group_id
}

resource "aws_security_group_rule" "egress" {
  for_each = var.create_cluster && var.create_security_group ? var.security_group_egress_rules : {}

  # required
  type              = "egress"
  from_port         = lookup(each.value, "from_port", local.port)
  to_port           = lookup(each.value, "to_port", local.port)
  protocol          = "tcp"
  security_group_id = local.rds_security_group_id

  # optional
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  description              = lookup(each.value, "description", null)
  ipv6_cidr_blocks         = lookup(each.value, "ipv6_cidr_blocks", null)
  prefix_list_ids          = lookup(each.value, "prefix_list_ids", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}