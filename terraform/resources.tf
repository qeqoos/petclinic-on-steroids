resource "aws_ecr_repository" "registry" {
  name                 = var.APP_NAME
  image_tag_mutability = "MUTABLE"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.2.1"

  cluster_name                    = var.CLUSTER_NAME
  cluster_version                 = "1.21"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = false

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  eks_managed_node_groups = {
    worker = {
      min_size                       = 2
      max_size                       = 3
      desired_size                   = 2
      instance_types                 = ["t3.small"]
      create_security_group          = true
      security_group_name            = "eks-managed-node-group"
      security_group_use_name_prefix = false
      security_group_description     = "EKS managed node group security group"

      security_group_rules = {
        out = {
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          type        = "ingress"
          cidr_blocks = ["0.0.0.0/0"]
        }

        in = {
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          type        = "egress"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }
}

module "rds-aurora" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name           = "test-db"
  engine         = "aurora-mysql"
  engine_version = "5.7.12"
  instances = {
    1 = {
      instance_class      = "db.t3.small"
      publicly_accessible = true
    }
  }

  vpc_id                 = module.vpc.vpc_id
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  create_db_subnet_group = false
  create_security_group  = true
  allowed_cidr_blocks    = module.vpc.private_subnets_cidr_blocks

  master_username        = "petclinic"
  master_password        = var.DB_PASSWORD
  create_random_password = false

  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.db_param.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.rds_cluster.id
}

resource "aws_db_parameter_group" "db_param" {
  name        = "aurora-db-57-parameter-group"
  family      = "aurora-mysql5.7"
  description = "aurora-db-57-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "rds_cluster" {
  name        = "aurora-57-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "aurora-57-cluster-parameter-group"
}

