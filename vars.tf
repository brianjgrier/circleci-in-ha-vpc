variable "CIDR_Required" {}
variable "num_Public_Subnets" {}
variable "num_Private_Subnets" {}
variable "Name_Tag" {}
variable "Keypair" {}
variable "AWS_Profile" {}

variable "AMIs" {
  type = map
  default = {
    us-east-1      = "ami-0bda37e733757a5aa"
    us-east-2      = "ami-0c6665f65c5018138"
    us-west-1      = "ami-055f65bb0ae8b7a6c"
    us-west-2      = "ami-07c4f6ef17b9b7750"
  }
}

variable "NAT_GW_EIPs" {
  type = map
  default = {
    us-east-1 = [ "eipalloc-0cf6a847cf265f6df", "eipalloc-0cc291083496ad802"]
    us-east-2 = [ "eipalloc-06d51fcfca3171129", "eipalloc-0ab1258d9b7f6af3c"]
    us-west-2 = [ "eipalloc-", "eipalloc-"]
  }
}

variable "CircleCI_EIPs" {
  type = map
  default = {
    us-east-1 = "eipalloc-0d915f407b01a6c6d"
    us-east-2 = "eipalloc-0456648b3ee3db89d"
    us-west-2 = "eipalloc-02f12a41240aac5bb"
  }
}

variable "Corporate_IPs" {
  type = list
  default = [ "173.38.117.93/32" ] 
}

variable "GHE_CIDR" {
  type = string
}

