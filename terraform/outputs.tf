output "frontend_public_ip" {
    description = "The public IP of the frontend server"
    value = module.frontend.public_ip
}
output "frontend_public_dns" {
    description = "The public DNS name of the frontend server"
    value = module.frontend.public_dns
}