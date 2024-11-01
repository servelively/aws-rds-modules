provider "aws" {
  region = local.primary.region
}

provider "aws" {
  alias  = "secondary"
  region = local.secondary.region
}

locals {
  primary = {
    region      = var.primary_db_region
  }
  secondary = {
    region      = var.secondary_db_region
  }
}

data "aws_caller_identity" "current" {}

################################################################################
# RDS Aurora Module
################################################################################

resource "aws_rds_global_cluster" "global_cluster" {
  count = var.create_global_cluster ? 1 : 0
  global_cluster_identifier = "${var.global_cluster_name}-global"
  engine                    = var.global_cluster_engine
  engine_version            = var.global_cluster_engine_version
  database_name             = var.db_database_name
  storage_encrypted         = var.db_storage_encrypted
}

module "aurora_primary" {
  source = "s3::https://s3.amazonaws.com/aws-hid-terraform-modules/hidmodules_v5.0.zip//hidmodules/rds/cluster"
  create_cluster               = var.create_global_cluster
  db_identifier                = format("%s-%s",var.global_cluster_name,"primary")
  db_name                      = aws_rds_global_cluster.global_cluster.0.database_name
  db_engine                    = aws_rds_global_cluster.global_cluster.0.engine
  db_engine_version            = aws_rds_global_cluster.global_cluster.0.engine_version
  global_cluster_identifier    = aws_rds_global_cluster.global_cluster.0.id
  db_instance_class            = var.db_instance_class
  db_kms_key_id                = aws_kms_key.primary.0.arn
  vpc_id                       = var.primary_db_vpc_id
  db_subnet_group_name         = var.db_primary_subnet_group_name
  db_username                  = var.db_username
  db_password                  = var.db_password
  create_security_group        = var.create_security_group
  allowed_cidr_blocks          = var.allowed_cidr_blocks_primarydb
  allowed_security_groups      = var.allowed_security_groups_primarydb
  db_skip_final_snapshot       = var.db_skip_final_snapshot
  db_tags                      = merge(var.db_tags,var.primary_db_tags)
}

module "aurora_secondary" {
  source = "s3::https://s3.amazonaws.com/aws-hid-terraform-modules/hidmodules_v5.0.zip//hidmodules/rds/cluster"

  providers = { aws = aws.secondary }

  is_primary_cluster = false
  create_cluster                     = var.create_global_cluster
  db_identifier                      = format("%s-%s",var.global_cluster_name,"secondary")
  db_engine                          = aws_rds_global_cluster.global_cluster.0.engine
  db_engine_version                  = aws_rds_global_cluster.global_cluster.0.engine_version
  global_cluster_identifier          = aws_rds_global_cluster.global_cluster.0.id
  replica_source_region              = local.primary.region
  db_instance_class                  = var.db_instance_class
  db_kms_key_id                      = aws_kms_key.secondary.0.arn
  vpc_id                             = var.secondary_db_vpc_id
  db_subnet_group_name               = var.db_secondary_subnet_group_name
  create_security_group              = var.create_security_group
  allowed_cidr_blocks                = var.allowed_cidr_blocks_secondarydb
  allowed_security_groups            = var.allowed_security_groups_secondarydb
  db_skip_final_snapshot             = var.db_skip_final_snapshot

  depends_on = [
    module.aurora_primary
  ]

  db_tags = merge(var.db_tags,var.secondary_db_tags)
}

################################################################################
# Supporting Resources
################################################################################

data "aws_iam_policy_document" "rds" {
  statement {
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        data.aws_caller_identity.current.arn,
      ]
    }
  }

  statement {
    sid = "Allow use of the key"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type = "Service"
      identifiers = [
        "monitoring.rds.amazonaws.com",
        "rds.amazonaws.com",
      ]
    }
  }
}

resource "aws_kms_key" "primary" {
  count = var.create_global_cluster ? 1 : 0
  policy = data.aws_iam_policy_document.rds.json
  tags   = merge(var.db_tags,var.primary_db_tags)
}

resource "aws_kms_key" "secondary" {
  count = var.create_global_cluster ? 1 : 0
  provider = aws.secondary

  policy = data.aws_iam_policy_document.rds.json
  tags   = merge(var.db_tags,var.secondary_db_tags)
}