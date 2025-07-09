This project currently is able of creating an EC2s environment in a VPC, seperated by public/private subnets with routes, security configs, roles and more, using dynamic functions to easily manage.

Things to know:
- There are MANY things to add, such as Terragrunt, more modules, resources and configurations. working on it!
- Current Prerequisites:
  - Update in any needed file the S3 url to your S3.
  - Currently in order to launch, the order should be terraform apply to:
    1. VPC
    2. EC2
    3. Microservices
  - User is in ~/.aws/credentials, it's a KodeKloud playground user, no other credentials are needed, if you need one - add to yourself.
