resource "aws_db_proxy" "create_proxy" {
  count = var.create_db_proxy ? 1 : 0
  name                   = var.db_proxy_identifier
  debug_logging          = var.db_proxy_enable_debug_log
  engine_family          = var.db_proxy_engine_family
  idle_client_timeout    = var.db_proxy_idle_client_timeout
  require_tls            = var.db_proxy_enable_tls
  role_arn               = var.db_proxy_role_arn
  vpc_security_group_ids = var.db_proxy_sg_ids
  vpc_subnet_ids         = var.db_proxy_vpc_subnet_ids

  dynamic "auth" {
    for_each = var.secrets
    content {
      auth_scheme = lookup(auth.value, "auth_scheme", "SECRETS")
      description = lookup(auth.value, "description", null)
      iam_auth    = lookup(auth.value, "iam_auth", "DISABLED")
      secret_arn  = auth.value.arn
    }
  }

  tags = var.db_proxy_tags
}
resource "aws_db_proxy_default_target_group" "default_target_group" {
  count = var.create_db_proxy ? 1 : 0

  db_proxy_name = aws_db_proxy.create_proxy[0].name

  connection_pool_config {
    connection_borrow_timeout    = var.db_proxy_connection_borrow_timeout
    init_query                   = var.db_proxy_init_query
    max_connections_percent      = var.db_proxy_max_connections_percent
    max_idle_connections_percent = var.db_proxy_max_idle_connections_percent
    session_pinning_filters      = var.db_proxy_session_pinning_filters
  }
}

resource "aws_db_proxy_target" "db_instance" {
  count = var.create_db_proxy && var.target_db_instance ? 1 : 0

  db_proxy_name          = aws_db_proxy.create_proxy[0].name
  target_group_name      = aws_db_proxy_default_target_group.default_target_group[0].name
  db_instance_identifier = var.db_instance_identifier
}

resource "aws_db_proxy_target" "db_cluster" {
  count = var.create_db_proxy && var.target_db_cluster ? 1 : 0

  db_proxy_name         = aws_db_proxy.create_proxy[0].name
  target_group_name     = aws_db_proxy_default_target_group.default_target_group[0].name
  db_cluster_identifier = var.db_cluster_identifier
}

resource "aws_db_proxy_endpoint" "proxy_endpoint" {
  for_each = var.db_proxy_endpoints

  db_proxy_name          = aws_db_proxy.create_proxy[0].name
  db_proxy_endpoint_name = each.value.name
  vpc_subnet_ids         = each.value.vpc_subnet_ids
  vpc_security_group_ids = lookup(each.value, "vpc_security_group_ids", null)
  target_role            = lookup(each.value, "target_role", null)

  tags = lookup(each.value, "tags", var.db_proxy_tags)
}
resource "aws_cloudwatch_log_group" "db_proxy_loggroup" {
  count = var.create_db_proxy && var.manage_log_group ? 1 : 0

  name              = "/aws/rds/proxy/${var.db_proxy_identifier}"
  retention_in_days = var.log_group_retention_in_days
  kms_key_id        = var.log_group_kms_key_id

  tags = merge(var.db_proxy_tags, var.log_group_tags)
}