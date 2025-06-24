locals {
  # 1. List of microservice names (source of truth)
  microservice_names = ["shaked", "kattan", "the", "boss"]

  # 2. Default config applied to all
  default_settings = {
    instance_type = "t3.micro"
    ami_id = "ami-0c02fb55956c7d316"
    subnet_id     = "subnet-02ce9bf40272e9144"
    tags = {
      Environment = "prod"
      Owner       = "devops"
    }
  }

  # 3. Optional overrides for specific services
  microservice_overrides = {
    auth = {
      instance_type = "t3.medium"
    }
    orders = {
     subnet_id = "subnet-02b48a541ffd79d3d"
    }
  }

  # 4. Merged final config
  microservice_definitions = {
    for name in local.microservice_names :
    name => merge(
      local.default_settings,
      lookup(local.microservice_overrides, name, {}),
      { name = name }
    )
  }
}

module "microservices" {
  source = "git::https://github.com/shakedkattan/projects.git//terraform/modules/ec2?ref=main"
  for_each = local.microservice_definitions

  name                         = each.value.name
  instance_type               = each.value.instance_type
  ami_id                      = each.value.ami_id
  subnet_id                   = each.value.subnet_id
  tags                        = each.value.tags
  security_group_ids          = lookup(each.value, "security_group_ids", [])
}