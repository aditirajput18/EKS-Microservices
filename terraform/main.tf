module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 3.0.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
}

data "aws_availability_zones" "available" {}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 18.0.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.27"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    on_demand_nodes = {
      desired_capacity = var.node_group_desired_capacity
      min_capacity     = var.node_group_min_size
      max_capacity     = var.node_group_max_size
      instance_types   = ["t3.medium"]
    }
  }

  tags = {
    Environment = "dev"
    Project     = var.cluster_name
  }
}

# Create ECR repos for each microservice
resource "aws_ecr_repository" "auth" {
  name = "auth-service"
}

resource "aws_ecr_repository" "orders" {
  name = "orders-service"
}

resource "aws_ecr_repository" "payments" {
  name = "payments-service"
}
