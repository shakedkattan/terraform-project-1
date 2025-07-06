locals {
  backend_config = {
    bucket = "shakedkattan-tfstate-bucket"
    region = "us-east-1"
  }

  state_modules = toset(["networking", "ec2",])  # Add other modules as needed
}

# Generate one data block per module dynamically
data "terraform_remote_state" "modules" {
  for_each = local.state_modules

  backend = "s3"
  config = {
    bucket = local.backend_config.bucket
    region = local.backend_config.region
    key = "prod/${each.key}.tfstate"
  }
}

# Access like this:
locals {
  vpc_id            = data.terraform_remote_state.modules["networking"].outputs.vpc_id
  public_subnet_id  = data.terraform_remote_state.modules["networking"].outputs.public_subnet_id
  private_subnet_id = data.terraform_remote_state.modules["networking"].outputs.private_subnet_id

  ec2_instance_id   = try(data.terraform_remote_state.modules["ec2"].outputs.instance_id, null)
  iam_role_arn      = try(data.terraform_remote_state.modules["iam"].outputs.role_arn, null)
}
