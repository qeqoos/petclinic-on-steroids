data "aws_caller_identity" "name" {}

data "aws_region" "name" {}

data "aws_availability_zones" "azs" {
  state = "available"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}