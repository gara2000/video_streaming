terraform {
  required_version = ">= 1.8.2"
}

resource "local_file" "hosts_cfg" {
  content = templatefile(var.template_path,
    {
        groups = var.groups
    }
  )
  filename = var.inventory_path
}