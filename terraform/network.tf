module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"

  name = "VPC-1"
  cidr = "10.0.0.0/16"

  azs              = data.aws_availability_zones.azs.names
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets   = ["10.0.11.0/24", "10.0.12.0/24"]
  database_subnets = ["10.0.21.0/24", "10.0.22.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames   = true
}