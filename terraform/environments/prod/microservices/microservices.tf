locals {
  # Microservice list
  microservice_names = ["shaked", "kattan", "the", "boss"]

  # Default settings
  default_settings = {
    tags = {
      Environment = "prod"
      Owner       = "devops"
    }
   # insert more things like iam here
  }

  # Customs for specific services
  microservice_customs = {
    auth = {
      instance_type = "t3.medium"
      subnet_id = local.public_subnet_id
    }
    orders = {
      subnet_id = local.private_subnet_id
    }
  }

  # Final merged settings
  microservice_definitions = {
    for name in local.microservice_names :
    name => merge(
      local.default_settings,
      lookup(local.microservice_customs, name, {}),
      { name = name }
    )
  }

# Final inputs for module
module "microservices" {
  source   = "git::https://github.com/shakedkattan/projects.git//terraform/modules/ec2?ref=main"
  for_each = local.microservices_resolved

  name                         = each.value.name
  instance_type                = each.value.instance_type
  ami_id                       = each.value.ami_id
  subnet_id                    = each.value.subnet_id
  tags                         = each.value.tags
  security_group_ids           = each.value.security_group_ids
  key_name                     = each.value.key_name
  iam_instance_profile         = each.value.iam_instance_profile
  associate_public_ip_address  = each.value.associate_public_ip
  user_data                    = each.value.user_data
    }
  }
}
