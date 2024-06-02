# Common Variables
variable "region" {
    type = string
}
variable "profile" {
    type = string
}
variable "vpc_cidr_block" {
    type = string
}
variable "private_cidr_block" {
    type = string
}
variable "public_cidr_block" {
    type = string
}
variable "instance_type" {
    type = string
}
variable "instance_id" {
    type = string
}
variable "common_tags" {
    description = "Common tags for the module components"
    type = map(string)
}
variable "hosted_zone" {
    description = "The public domain name"
    type = string
}

# Frontend Variables
variable "frontend_key_name" {
    type = string
}
variable "frontend_ingress_rules" {
    description = "Allowed inbound rules"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = []
}
variable "frontend_egress_rules" {
    description = "Allow outbound rules"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = []
}

# Streamer Variables
variable "streamer_key_name" {
    type = string
}
variable "streamer_ingress_rules" {
    description = "Allowed inbound rules"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = []
}
variable "streamer_egress_rules" {
    description = "Allow outbound rules"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = []
}

# Bastion Variables
variable "bastion_key_name" {
    type = string
}
variable "bastion_ingress_rules" {
    description = "Allowed inbound rules"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = []
}
variable "bastion_egress_rules" {
    description = "Allow outbound rules"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = []
}
variable "ansible_vars" {
    default = {} 
}
variable "domain_prefix" {
    type = string
    default = "cassa"
}