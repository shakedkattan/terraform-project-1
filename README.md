Desired file structure:
terraform/
  modules/
    ec2/,s3/,iam/,vpc/...
      main.tf,outputs.tf,vars.tf (Flexible aws resource modules)
  environments/
    prod/,dev/
      
