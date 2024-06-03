output "vpc_id" {
    description = "The ID of the VPC"
    value = aws_vpc.vpc.id
}
output "public_subnet_id" {
    description = "The ID of the public subnet"
    value = aws_subnet.public_subnet.id
}
output "private_subnet_id" {
    description = "The ID of the private subnet"
    value = aws_subnet.private_subnet.id
}
output "private_route_table_id" {
    description = "The ID of the private route table"
    value = aws_route_table.custom.id
}
output "public_route_table_id" {
    description = "The ID of the public route table"
    value = aws_default_route_table.rtb.id
}