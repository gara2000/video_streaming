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
    name = "Frontend"
    vpc_id = module.infra.vpc_id
    subnet_id = module.infra.public_subnet_id
    key_pair_name = var.frontend_key_name
    key_folder = "${path.cwd}/../ansible/keys"
    instance_id = var.instance_id
    instance_type = var.instance_type
    sg_name = "frontend_sg"
    egress_rules = var.frontend_egress_rules
    ingress_rules = var.frontend_ingress_rules
    associate_public_ip = true
    hosted_zone = var.hosted_zone
    domain_prefix = var.domain_prefix
    common_tags = {
        Name = "cassa_frontend"
        Owner = "cassa"
        Lab = "project"
    }
}

# Create the Video Streamer server
module "streamer" {
    source = "./modules/instance"
    name = "Streamer"
    vpc_id = module.infra.vpc_id
    subnet_id = module.infra.private_subnet_id
    key_pair_name = var.streamer_key_name
    key_folder = "${path.cwd}/../ansible/keys"
    instance_id = var.instance_id
    instance_type = var.instance_type
    sg_name = "streamer_sg"
    egress_rules = var.streamer_egress_rules
    ingress_rules = var.streamer_ingress_rules
    associate_public_ip = false
    hosted_zone = var.hosted_zone
    domain_prefix = var.domain_prefix
    common_tags = {
        Name = "cassa_streamer"
        Owner = "cassa"
        Lab = "project"
    }
}

# Create Bastion server, to serve as proxy between ansible and the streamer
module "bastion" {
    source = "./modules/instance"
    name = "Bastion"
    vpc_id = module.infra.vpc_id
    subnet_id = module.infra.public_subnet_id
    key_pair_name = var.bastion_key_name
    key_folder = "${path.cwd}/../ansible/keys"
    instance_id = var.instance_id
    instance_type = var.instance_type
    sg_name = "bastion_sg"
    egress_rules = var.bastion_egress_rules
    ingress_rules = var.bastion_ingress_rules
    associate_public_ip = true
    is_nat_instance = true
    hosted_zone = var.hosted_zone
    domain_prefix = var.domain_prefix
    common_tags = {
        Name = "cassa_bastion"
        Owner = "cassa"
        Lab = "project"
    }
}

# Populate the Ansible inventory file
module "inventory" {
    source = "./modules/inventory"
    template_path = "${path.cwd}/templates/inventory.tpl"
    inventory_path = "${path.cwd}/../ansible/inventory/hosts"
    groups = [{
        name = "frontends",
        hosts = [module.frontend.public_dns]
        key_file = "${path.cwd}/../ansible/keys/${var.frontend_key_name}.pem"
        user = "ubuntu"
        private = false
    },
    {
        name = "streamers"
        hosts = [module.streamer.private_ip]
        key_file = "${path.cwd}/../ansible/keys/${var.streamer_key_name}.pem"
        user = "ubuntu"
        private = true
        bastion_user = "ubuntu"
        bastion_host = module.bastion.public_dns
        bastion_key = "${path.cwd}/../ansible/keys/${var.bastion_key_name}.pem"
    },
    {
        name = "bastions"
        hosts = [module.bastion.public_dns]
        key_file = "${path.cwd}/../ansible/keys/${var.bastion_key_name}.pem"
        user = "ubuntu"
        private = false
    }]
}

resource "local_file" "ansible_variables" {
  content = templatefile("templates/vars.yml.tpl",
    {
        ansible_vars = var.ansible_vars,
        additional_vars = {
            domain = module.frontend.public_dns
            nginx_host = module.frontend.private_ip
            private_cidr_block = var.private_cidr_block
        }
    }
  )
  filename = "${path.cwd}/../ansible/vars/vars_terraform.yml"
}

# Send traffic from private subnet to the nat instance (didn't do anything)
resource "aws_route" "r" {
    route_table_id = module.infra.private_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    network_interface_id = module.bastion.primary_net_if_id

    depends_on = [ module.infra, module.bastion ]
}