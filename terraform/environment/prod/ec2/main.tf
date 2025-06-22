
locals {
  # List of service names
  service_names = ["a", "b", "c"]

  # Default config
  default_config = {
    port  = 8080
    image = "123456789.dkr.ecr.us-east-1.amazonaws.com/default:latest"
  }

  # Custom overrides (only what you want to override)
  custom_config = {
    b = {
      port = 9090
    },
    c = {
      image = "123456789.dkr.ecr.us-east-1.amazonaws.com/custom-c:latest"
    }
  }

  # Final merged config per service
  microservices = {
    for name in local.service_names :
    name => merge(
      local.default_config,
      lookup(local.custom_config, name, {})
    )
  }
}
