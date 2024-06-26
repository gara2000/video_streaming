output "public_ip" {
    description = "The public IP address of the instance"
    value = aws_instance.app.public_ip
}
output "public_dns" {
    description = "The DNS name of the instance"
    value = one(aws_route53_record.my_zone[*].name)
}
output "private_ip" {
    description = "The private IP address of the instance"
    value = aws_instance.app.private_ip
}
output "instance_id" {
    description = "The ID of the instance"
    value = aws_instance.app.id
}
output "primary_net_if_id" {
    value = aws_instance.app.primary_network_interface_id
}