resource "aws_vpc" "three_tier_app_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "VPC for three tier architecture"
  }
}