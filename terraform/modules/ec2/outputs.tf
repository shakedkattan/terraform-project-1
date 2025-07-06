output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.main.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance (if applicable)"
  value       = aws_instance.main.public_ip
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.main.private_ip
}

output "availability_zone" {
  description = "The availability zone of the EC2 instance"
  value       = aws_instance.main.availability_zone
}

output "instance_state" {
  description = "Current state of the instance"
  value       = aws_instance.main.instance_state
}

output "arn" {
  description = "The ARN of the EC2 instance"
  value       = aws_instance.main.arn
}

output "ami_id" {
  description = "AMI ID used for the EC2 instance"
  value       = var.ami_id
}

output "instance_type" {
  description = "Instance type used for the EC2 instance"
  value       = var.instance_type
}

output "subnet_id" {
  description = "Subnet ID where the EC2 instance is launched"
  value       = var.subnet_id
}

output "security_group_ids" {
  description = "Security groups attached to the EC2 instance"
  value       = var.security_group_ids
}

output "tags" {
  description = "All tags applied to the EC2 instance"
  value       = var.tags
}
