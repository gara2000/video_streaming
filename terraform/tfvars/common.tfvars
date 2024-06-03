region = "us-east-1"
profile = "telecom"
vpc_cidr_block = "192.168.0.0/16"
private_cidr_block = "192.168.1.0/24"
public_cidr_block = "192.168.2.0/24"
instance_type="t2.micro"
instance_id = "ami-04b70fa74e45c3917"
common_tags = {
    Name = "cassa"
    Owner = "cassa"
    Lab = "project"
}
hosted_zone = "devops.intuitivesoft.cloud."
domain_prefix = "cassaa"