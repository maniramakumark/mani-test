variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  default     = "10.1.0.0/16"
}

variable "public_subnets_cidr_blocks" {
  description = "public subnets CIDR Blocks"
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_subnets_cidr_blocks" {
  description = "private subnets CIDR Blocks"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  default     = "example-bucket-name"
}

variable "iam_role_name" {
  description = "Name for the IAM role"
  default     = "example_role"
}

variable "sg_name" {
  description = "Name for the Security Group"
  default     = "test_sg"
}

variable "ami_id" {
  description = "AMI ID to crate an EC2 instance"
  default     = "ami-xxxxxxxxxxxxxxxx"
}

variable "ingress_blocks" {
  description = "ingress rules for the security group"
  default     = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "egress_blocks" {
  description = "egress rules for the security group"
  default     = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
