output "frontend_public_ip" {
    description = "The public IP of the frontend server"
    value = module.frontend.public_ip
}
output "frontend_public_dns" {
    description = "The public DNS name of the frontend server"
    value = module.frontend.public_dns
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