resource "aws_security_group" "example_sg" {
  name        = var.sg_name
  description = "Custom security group"

  dynamic "ingress" {
    for_each = var.ingress_blocks
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_blocks
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "example_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(aws_subnet.private_subnets.*.id, 0)
  iam_instance_profile = aws_iam_role.example_iam_role.name
  security_groups = [aws_security_group.example_sg.id]
}

