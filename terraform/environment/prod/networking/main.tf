module "prod_vpc" {
  source = "git::https://github.com/shakedkattan/projects.git//terraform/modules/vpc?ref=main"

  name                 = "prod"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
  public_subnet_az     = "us-east-1a"
  private_subnet_az    = "us-east-1b"
}

