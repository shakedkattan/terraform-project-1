locals {
  # 1. List of microservice names (source of truth)
  microservice_names = ["auth", "payments", "orders"]

  # 2. Default config applied to all
  default_settings = {
    instance_type = "t3.micro"
    ami_id        = "ami-0123456789abcdef0"
    subnet_id     = "subnet-abc123"
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
      subnet_id = "subnet-def456"
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
  source   = "git::https://github.com/shakedkattan/terraform.git//modules/ec2?ref=main"
  for_each = local.microservice_definitions

  name                         = each.value.name
  instance_type               = each.value.instance_type
  ami_id                      = each.value.ami_id
  subnet_id                   = each.value.subnet_id
  tags                        = each.value.tags
  security_group_ids          = lookup(each.value, "security_group_ids", [])
  key_name                    = lookup(each.value, "key_name", null)
  iam_instance_profile        = lookup(each.value, "iam_instance_profile", null)
  associate_public_ip_address = lookup(each.value, "associate_public_ip_address", false)
  user_data                   = lookup(each.value, "user_data", null)
}
