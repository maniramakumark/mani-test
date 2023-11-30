output "iam_role_arn" {
  value = aws_iam_role.example_iam_role.arn
}

output "ec2_instance_id" {
  value = aws_instance.example_ec2.id
}
