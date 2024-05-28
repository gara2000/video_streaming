output "public_ip" {
    description = "The public IP address of the instance"
    value = aws_instance.app.public_ip
}
output "public_dns" {
    description = "The DNS name of the instance"
    value = one(aws_route53_record.my_zone[*].name)
}