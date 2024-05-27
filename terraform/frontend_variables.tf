
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