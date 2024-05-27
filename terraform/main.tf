provider "aws" {
  region = var.region
  profile = var.profile
}

# Call the infra module to create the infrastructure
module "infra" {
    source = "./modules/infra"
    vpc_cidr_block = var.vpc_cidr_block
    public_cidr_block = var.public_cidr_block
    private_cidr_block = var.private_cidr_block
    common_tags = var.common_tags
}

# Create the Web Frontend server
module "frontend" {
    source = "./modules/instance"
    vpc_id = module.infra.vpc_id
    subnet_id = module.infra.public_subnet_id
    key_pair_name = var.frontend_key_name
    instance_id = var.instance_id
    instance_type = var.instance_type
    sg_name = "frontend_sg"
    egress_rules = var.frontend_egress_rules
    ingress_rules = var.frontend_ingress_rules
    associate_public_ip = var.associate_public_ip
    hosted_zone = "devops.intuitivesoft.cloud."
    common_tags = {
        Name = "cassa_frontend"
        Owner = "cassa"
        Lab = "project"
    }
}

# Create the Video Streamer server
module "streamer" {
    source = "./modules/instance"
    vpc_id = module.infra.vpc_id
    subnet_id = module.infra.private_subnet_id
    key_pair_name = var.streamer_key_name
    instance_id = var.instance_id
    instance_type = var.instance_type
    sg_name = "streamer_sg"
    egress_rules = var.streamer_egress_rules
    ingress_rules = var.streamer_ingress_rules
    hosted_zone = "devops.intuitivesoft.cloud."
    common_tags = {
        Name = "cassa_streamer"
        Owner = "cassa"
        Lab = "project"
    }
}