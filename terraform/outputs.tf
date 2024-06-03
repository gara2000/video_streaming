output "frontend_public_dns" {
    description = "The public DNS name of the frontend server"
    value = module.frontend.public_dns
}
output "frontend_private_ip" {
    value = module.frontend.private_ip
}
output "streamer_public_dns" {
    description = "The public DNS name of the streamer server"
    value = module.streamer.public_dns
}
output "streamer_private_ip" {
    value = module.streamer.private_ip
}