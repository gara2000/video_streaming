terraform {
  required_version = ">= 1.8.2"
}

# Create a Security Group
resource "aws_security_group" "sg" {
    vpc_id = var.vpc_id
    name = var.sg_name

    dynamic "ingress" {
        for_each = var.ingress_rules
        content {
            from_port = ingress.value.from_port
            to_port = ingress.value.to_port
            protocol = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }

    dynamic "egress" {
        for_each = var.egress_rules
        content {
            from_port = egress.value.from_port
            to_port = egress.value.to_port
            protocol = egress.value.protocol
            cidr_blocks = egress.value.cidr_blocks
        }
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = var.common_tags
}

# Generate key pair
resource "tls_private_key" "generated_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# Create a key pair
resource "aws_key_pair" "key" {
    key_name = var.key_pair_name
    public_key = tls_private_key.generated_key.public_key_openssh
}

# Create an EC2 instance
resource "aws_instance" "app" {
    ami = var.instance_id
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.sg.id ]
    subnet_id = var.subnet_id
    associate_public_ip_address = var.associate_public_ip
    key_name = aws_key_pair.key.key_name

    iam_instance_profile = "r53-devops"

    tags = var.common_tags
}

# Get private key locally
resource "local_sensitive_file" "private_key_file" {
    content = tls_private_key.generated_key.private_key_openssh
    filename = "${var.key_folder}/${aws_key_pair.key.key_name}.pem"
}

data "aws_route53_zone" "hosted_zone" {
    name = var.hosted_zone
}

resource "aws_route53_record" "my_zone" {
    count = var.associate_public_ip ? 1:0
    zone_id = data.aws_route53_zone.hosted_zone.zone_id
    name    = "${var.domain_prefix}${var.name}.${data.aws_route53_zone.hosted_zone.name}"
    type    = "A"
    ttl     = "300"
    records = [aws_instance.app.public_ip]
}