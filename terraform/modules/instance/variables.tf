variable "key_pair_name" {
    type = string
    default = "myKeyPair"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "instance_id" {
    type = string
    default = "ami-04b70fa74e45c3917"
}

variable "ingress_rules" {
    description = "Allowed inbound rules"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = []
}

variable "egress_rules" {
    description = "Allow outbound rules"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = []
}

variable "common_tags" {
    description = "Common tags for the module components"
    type = map(string)
    default = {
        Name = "cassa"
        Owner = "cassa"
        Lab = "project"
    }
}
variable "subnet_id" {
    description = "The subnet id to which the instance should belong"
    type = string
}
variable "associate_public_ip" {
    description = "Boolean value to determine whether to associate a public ip"
    type = bool
    default = false
}
variable "hosted_zone" {
    description = "The public domain name"
    type = string
}
variable "vpc_id" {
    description = "The ID of the VPC"
    type = string
}
variable "sg_name" {
    description = "The name of the security group"
    type = string
}