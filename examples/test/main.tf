provider "aws" {
  region  = "eu-central-1"
  profile = "gdn-lab"
}

module "base-network" {
  source                                      = "cn-terraform/networking/aws"
  version                                     = "2.0.7"
  name_preffix                                = "test-networking"
  vpc_cidr_block                              = "192.168.0.0/16"
  availability_zones                          = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  public_subnets_cidrs_per_availability_zone  = ["192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19"]
  private_subnets_cidrs_per_availability_zone = ["192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19"]
}

module "sonar" {
  source              = "../../"
  name_preffix        = "gdn"
  region              = "eu-central-1"
  vpc_id              = module.base-network.vpc_id
  availability_zones  = module.base-network.availability_zones
  public_subnets_ids  = module.base-network.public_subnets_ids
  private_subnets_ids = module.base-network.private_subnets_ids
}
