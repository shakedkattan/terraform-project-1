locals {
  microservice_list = ["shaked", "kattan", "devops", "engineer"]

  default_settings = {
    ami_id            = "ami-0c02fb55956c7d316"  # Amazon Linux 2
    instance_type     = "t3.micro"
    subnet_id         = local.public_subnet_id
    tags = {
      Environment = "prod"
      Owner       = "devops"
    }
    security_group_ids = []
  }

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

  microservice_definitions = {
    for name in local.microservice_list :
    name => merge(
      local.default_settings,
      {
        ami_id             = contains(keys(lookup(local.microservice_customs, name, {})), "ami_id") ? local.microservice_customs[name].ami_id : local.default_settings.ami_id,
        instance_type      = contains(keys(lookup(local.microservice_customs, name, {})), "instance_type") ? local.microservice_customs[name].instance_type : local.default_settings.instance_type,
        subnet_id          = contains(keys(lookup(local.microservice_customs, name, {})), "subnet_id") ? local.microservice_customs[name].subnet_id : local.default_settings.subnet_id,
        tags               = contains(keys(lookup(local.microservice_customs, name, {})), "tags") ? local.microservice_customs[name].tags : local.default_settings.tags,
        security_group_ids = contains(keys(lookup(local.microservice_customs, name, {})), "security_group_ids") ? local.microservice_customs[name].security_group_ids : local.default_settings.security_group_ids
      },
      { name = name }
    )
  }
}

module "microservices" {
  for_each = local.microservice_definitions

  source = "git::https://github.com/shakedkattan/terraform-project-1.git//terraform/modules/ec2?ref=main"

  name                = each.value.name
  ami_id              = each.value.ami_id
  instance_type       = each.value.instance_type
  subnet_id           = each.value.subnet_id
  tags                = each.value.tags
  security_group_ids  = each.value.security_group_ids
}