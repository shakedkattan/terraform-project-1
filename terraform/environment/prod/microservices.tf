locals {
  default_microservice_settings = {
    instance_type = "t3.micro"
    ami_id        = "ami-0123456789abcdef0"
    subnet_id     = "subnet-abc123"
    tags = {
      Environment = "prod"
      Owner       = "devops"
    }
  }

  microservices = {
    auth = {
      instance_type = "t3.medium"
    }
    payments = {}  # uses all defaults
    orders = {
      subnet_id = "subnet-def456"
    }
  }

  microservice_definitions = {
    for name, cfg in local.microservices :
    name => merge(local.default_microservice_settings, cfg, { name = name })
  }
}
