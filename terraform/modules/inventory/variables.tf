variable "inventory_path" {
    description = "The relative path (relative to the main file (where the module is called)) to the inventory file"
    type = string
}
variable "groups" {
    description = "List of the hosts"
    type = list(object({
        name = string
        hosts = list(string) 
    }))
}