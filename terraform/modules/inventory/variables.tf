variable "inventory_path" {
    description = "The relative path (relative to the main file (where the module is called)) to the inventory file"
    type = string
}
variable "template_path" {
    description = "The template file from which we construct the inventory"
    type = string
}
variable "groups" {
    description = "List of the hosts"
    type = list(object({
        name = string
        hosts = list(string) 
        key_file = string
        user = string
        private = bool
        bastion_user = optional(string)
        bastion_host = optional(string)
    }))
}