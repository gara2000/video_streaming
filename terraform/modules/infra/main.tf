terraform {
  required_version = ">= 1.8.2"
}

# Create a VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block

    tags = var.common_tags
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_cidr_block

    tags = var.common_tags
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_cidr_block

    tags = var.common_tags
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = var.common_tags
}

# Configure the VPC's default route table
resource "aws_default_route_table" "rtb" {
    default_route_table_id = aws_vpc.vpc.default_route_table_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = var.common_tags
}

# Associate default route table with public subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_default_route_table.rtb.id
}

# Create custom route table
resource "aws_route_table" "custom" {
  vpc_id = aws_vpc.vpc.id

  route = []

  tags = var.common_tags
}

# Associate custom route table with private subnet
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.custom.id
}
