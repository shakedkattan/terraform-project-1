variable "name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to launch"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 / us-east-1
}

variable "instance_type" {
  description = "EC2 instance type (e.g. t3.micro)"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security groups to attach"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Map of additional tags to apply"
  type        = map(string)
  default     = {
    Owner       = "devops"
  }
}