output "public_subnet_id" {
    description = "The ID of the public subnet"
    value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
    description = "The ID of the private subnet"
    value = aws_subnet.private_subnet.id
}

output "vpc_id" {
    description = "The ID of the VPC"
    value = aws_vpc.vpc.id
}