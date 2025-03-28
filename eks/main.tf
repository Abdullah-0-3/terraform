# EKS (Elastic Kubernetes Service) Configuration

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name                   = local.cluster_name
  cluster_version                = "1.31"
  cluster_endpoint_public_access = true

  vpc_id                   = module.vpc.default_vpc_id
  subnet_ids               = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_group_defaults = {
    instance_types                = ["${local.instance_1}", "${local.instance_2}"]
    attach_primary_security_group = true
  }

  eks_managed_node_groups = {
    eks_cluster_terraform = {
      instance_types   = [local.env == "prd" ? local.instance_1 : local.instance_2]
      desired_capacity = local.desired_capacity
      max_capacity     = local.max_capacity
      min_capacity     = local.min_capacity
      capacity_type    = "SPOT"
    }
  }

  cluster_addons = {
    vpc_cni = {
      enabled = true
    }
    kube_proxy = {
      enabled = true
    }
    kube_dns = {
      enabled = true
    }
    coredns = {
      enabled = true
    }
  }

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}