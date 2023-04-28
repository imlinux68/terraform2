# Terraform code below #

data "aws_availability_zones" "available" {}

provider "aws" {
  region = "us-west-2"
}

# Create VPC

resource "aws_vpc" "mtc_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name" = "mtc_vpc-${random_id.random.dec}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "mtc_internet_gateway" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    "Name" = "mtc_igw-${random_id.random.dec}"
  }
}

resource "aws_route_table" "mtc_public_rt" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    "Name" = "mtc_pub-${random_id.random.dec}"   
  }
  
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.mtc_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.mtc_internet_gateway.id
}


resource "aws_default_route_table" "mtc_private_rt1" {
  default_route_table_id = aws_vpc.mtc_vpc.default_route_table_id

  tags = {
    "Name" = "mtc_private"
  }
}

resource "random_id" "random" {
  byte_length = 5
}


resource "aws_subnet" "mtc_public_subnet" {
  vpc_id = aws_vpc.mtc_vpc.id
  cidr_block = var.public_cidrs
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    "Name" = "AWS_SUBNET1"
  }
}













