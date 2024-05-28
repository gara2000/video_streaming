output "frontend_public_ip" {
    description = "The public IP of the frontend server"
    value = module.frontend.public_ip
}
output "frontend_public_dns" {
    description = "The public DNS name of the frontend server"
    value = module.frontend.public_dns
}
output "frontend_private_ip" {
    value = module.frontend.private_ip
}
output "streamer_public_ip" {
    description = "The public IP of the streamer server"
    value = module.streamer.public_ip
}
output "streamer_public_dns" {
    description = "The public DNS name of the streamer server"
    value = module.streamer.public_dns
}
output "path" {
    value = module.inventory.path
}
output "private_streamer_ip" {
    value = module.streamer.private_ip
}
output "bastion_private_ip" {
    value = module.bastion.private_ip
}