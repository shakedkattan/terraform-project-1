locals {
  # List of all microservices you want to deploy
  microservice_names = ["shaked", "kattan", "devops", "engineer"]

  # Environment-wide default settings (can override module defaults if needed)
  default_settings = {
    subnet_id = local.public_subnet_id
    tags = {
      Environment = "prod"
      Owner       = "devops"
    }
  }

  # Per-service override map (optional per microservice)
  microservice_customs = {
    shaked = {
      instance_type = "t3.small"
    }
    kattan = {
      instance_type = "t3.medium"
      subnet_id     = local.public_subnet_id
    }
    devops = {
      instance_type = "t3.medium"
      subnet_id     = local.private_subnet_id
    }
  }

  # Final merged config per microservice
  microservice_definitions = {
    for name in local.microservice_names :
    name => merge(
      local.default_settings,
      lookup(local.microservice_customs, name, {}),
      { name = name }
    )
  }
}

module "microservices" {
  source   = "git::https://github.com/shakedkattan/projects.git//terraform/modules/ec2?ref=main"
  for_each = local.microservice_definitions

  name                         = each.value.name
  ami_id                       = lookup(each.value, "ami_id", null)
  instance_type                = lookup(each.value, "instance_type", null)
  subnet_id                    = lookup(each.value, "subnet_id", null)
  tags                         = lookup(each.value, "tags", null)
  security_group_ids           = lookup(each.value, "security_group_ids", null)
  key_name                     = lookup(each.value, "key_name", null)
  iam_instance_profile         = lookup(each.value, "iam_instance_profile", null)
  associate_public_ip_address  = lookup(each.value, "associate_public_ip", null)
  user_data                    = lookup(each.value, "user_data", null)
}
