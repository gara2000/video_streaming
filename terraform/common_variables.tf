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