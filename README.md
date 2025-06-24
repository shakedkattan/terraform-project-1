Things to know:
- User is in ~/.aws/credentials, it's a KodeKloud automatic user, that's why no other credentials are needed.
- there are dependencies between folders, for example: networking.tf is responsible of creating the vpc, so it has to be launched first, because in microservices.tf they rely on hard-coded subnet ids. (terragrunt will solve it though)
