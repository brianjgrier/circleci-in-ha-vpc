
// This module will call other modules to acutally do the work
//

//
// The first thing to do is create the VPC, or ensure it is already created.
//
module "create_vpc" {
//  source          = "git::ssh://git@www-github3.cisco.com/cxe/ha_vpc.git"
  source          = "./modules/ha_vpc"
  AWS_Region      = var.AWS_Region
  CIDR            = var.CIDR_Required
  Public_Subnets  = var.num_Public_Subnets
  Private_Subnets = var.num_Private_Subnets
  GHE_CIDR_def    = var.GHE_CIDR
  Tags            = var.Tag_List
  VPC_Name        = var.Name_Tag
  AMI_List        = var.AMIs
  SSH_Keypair     = var.Keypair
  EIP_List        = var.NAT_GW_EIPs[var.AWS_Region]
  Company_IPs     = var.Corporate_IPs
}

data "aws_eip" "by_allocation_id" {
  count = length(var.NAT_GW_EIPs[var.AWS_Region])
  id = element(var.NAT_GW_EIPs[var.AWS_Region], count.index)
}

//
// Now create the CircleCI instance
//
module "create_circleci" {
//  source          = "git::ssh://git@www-github3.cisco.com/cxe/circleci-module.git"
  source = "./modules/circleci"
#####################################
# 1. Required Cloud Configuration
#####################################
  aws_region              = var.AWS_Region
  aws_vpc_id              = module.create_vpc.vpc_id
  aws_vpc_cidr            = var.CIDR_Required
  aws_public_subnet_id    = module.create_vpc.public_subnet_ids[0]
  aws_public_subnet_cidr  = module.create_vpc.public_subnet_cidr[0]
  aws_private_subnet_id   = module.create_vpc.private_subnet_ids[0]
  aws_private_subnet_cidr = module.create_vpc.private_subnet_cidr[0]
  aws_ssh_key_name        = var.Keypair
  aws_nat_eip_list        = formatlist("%s/32", data.aws_eip.by_allocation_id.*.public_ip)
#####################################
# 2. Required CircleCI Configuration
#####################################
  services_instance_type = "m5.2xlarge"
  builder_instance_type = "r5.2xlarge"
  nomad_client_instance_type = "m5.2xlarge"
# Passphrase used for encryping/decrypting secrets—must not be blank
# Need to get this from AWS secret storage in next iteration
  circle_secret_passphrase = "M4r3s34t04ts"
#####################################
# 3. Optional Cloud Configuration
#####################################
# Set this to `1` or higher to enable CircleCI 1.0 builders
  desired_builders_count = "0"
# Provide proxy address if your network configuration requires it
  http_proxy             = ""
  https_proxy            = ""
  no_proxy               = ""
# Use this var if you have multiple installation within one AWS region
  prefix                 = var.Usage
  Tags                   = var.Tag_List
  Company_IPs            = concat(var.Corporate_IPs, [var.GHE_CIDR ], [var.CIDR_Required])
  Static_IP              = var.CircleCI_EIPs[var.AWS_Region]
}

output "vpc_id" {
  value = module.create_vpc.vpc_id
}

output "vpc_tags" {
  value = var.Tag_List
}

output "CircleCI-Information" {
  value = module.create_circleci.success_message
}

