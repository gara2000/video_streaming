terraform {
  required_version = ">= 1.8.2"
}

resource "local_file" "hosts_cfg" {
  content = templatefile(var.inventory_path,
    {
        groups = var.groups
    #   kafka_processors = aws_instance.kafka_processor.*.public_ip
    #   test_clients = aws_instance.test_client.*.public_ip
    }
  )
  filename = "../ansible/inventory/hosts.cfg"
}