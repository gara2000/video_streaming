variable "vpc_cidr_block" {
    type = string
    default = "192.168.0.0/16"
}

variable "private_cidr_block" {
    type = string
    default = "192.168.1.0/24"
}

variable "public_cidr_block" {
    type = string
    default = "192.168.2.0/24"
}

variable "common_tags" {
    description = "Common tags for the module components"
    type = map(string)
}

# variable "key_pair_name" {
#     type = string
#     default = "myKeyPair"
# }

# variable "instance_type" {
#     type = string
#     default = "t2.micro"
# }

# variable "instance_id" {
#     type = string
#     default = "ami-04b70fa74e45c3917"
# }
