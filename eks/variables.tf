locals {
  region   = "us-west-2"
  vpc_name = "eks-vpc"

  vpc_cidr        = "12.0.0.0/16"
  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["12.0.1.0/24", "12.0.2.0/24"]
  public_subnets  = ["12.0.100.0/24", "12.0.101.0/24"]
  intra_subnets   = ["12.0.51.0/24", "12.0.52.0/23"]

  cluster_name     = "eks-cluster"
  desired_capacity = 2
  max_capacity     = 3
  min_capacity     = 1
  instance_1       = "t2.large"
  instance_2       = "t2.medium"

  env = "dev"
}