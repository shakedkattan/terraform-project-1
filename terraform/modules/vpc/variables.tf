variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default = ["10.0.1.0/24"]
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default = ["10.0.2.0/24"]
}

variable "public_subnet_az" {
  description = "Availability zone for public subnet"
  type        = string
}

variable "private_subnet_az" {
  description = "Availability zone for private subnet"
  type        = string
}

