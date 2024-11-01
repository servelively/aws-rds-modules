resource "aws_db_instance" "db_instance" {
  count = var.db_create ? 1 : 0
  identifier = var.db_identifier
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  storage_type      = var.db_storage_type
  storage_encrypted = var.db_storage_encrypted
  kms_key_id        = var.db_kms_key_id
  license_model     = var.db_license_model

  name                                = var.db_name
  username                            = var.db_username
  password                            = var.db_password
  port                                = var.db_port
  iam_database_authentication_enabled = var.db_iam_database_authentication_enabled
  vpc_security_group_ids =  var.db_vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name
  parameter_group_name   = var.db_parameter_group_name
  option_group_name      = var.db_option_group_name
  multi_az            = var.db_multi_az
  publicly_accessible = var.db_publicly_accessible
  ca_cert_identifier  = var.db_ca_cert_identifier

  allow_major_version_upgrade = var.db_allow_major_version_upgrade
  auto_minor_version_upgrade  = var.db_auto_minor_version_upgrade
  apply_immediately           = var.db_apply_immediately
  maintenance_window          = var.db_maintenance_window

  snapshot_identifier   = var.db_snapshot_identifier
  skip_final_snapshot   = var.db_skip_final_snapshot
  backup_retention_period = var.db_backup_retention_period
  backup_window           = var.db_backup_window
  max_allocated_storage   = var.db_max_allocated_storage
  monitoring_interval     = var.db_monitoring_interval
  monitoring_role_arn     = var.db_monitoring_role_arn
  enabled_cloudwatch_logs_exports = var.db_enabled_cloudwatch_logs_exports
  deletion_protection      = var.db_deletion_protection
  delete_automated_backups = var.db_delete_automated_backups
  tags = var.db_tags
  replicate_source_db     = var.db_replicate_source
  timeouts {
    create = lookup(var.db_timeouts, "create", null)
    delete = lookup(var.db_timeouts, "delete", null)
    update = lookup(var.db_timeouts, "update", null)
  }
}