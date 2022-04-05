# Terraform CLI tricks

## Setup tab auto-completion, requires logging back in
$ terraform -install-autocomplete 


# Format and Validate Terraform code

## format code per HCL canonical standard
$ terraform fmt 

## validate code for syntax
$ terraform validate 

## validate code skip backend validation
$ terraform validate -backend=false 

# Initialize your Terraform working directory

## initialize directory, pull down providers
$ terraform init 

## initialize directory, do not download plugins
$ terraform init -get-plugins=false 

## initialize directory, do not verify plugins for Hashicorp signature
$ terraform init -verify-plugins=false 

## Plan, Deploy and Cleanup Infrastructure

## apply changes without being prompted to enter “yes”
terraform apply --auto-approve 

## destroy/cleanup deployment without being prompted for “yes”
terraform destroy --auto-approve

## output the deployment plan to plan.out
terraform plan -out plan.out

## use the plan.out plan file to deploy infrastructure
terraform apply plan.out

## outputs a destroy plan
terraform plan -destroy

## only apply/deploy changes to the targeted resource
terraform apply -target=aws_instance.my_ec2

## pass a variable via command-line while applying a configuration
terraform apply -var my_region_variable=us-east-1

## lock the state file so it can’t be modified by any other Terraform apply or modification action(possible only where backend allows locking)
terraform apply -lock=true

## do not reconcile state file with real-world resources(helpful with large complex deployments for saving deployment time)
terraform apply refresh=false

## number of simultaneous resource operations
terraform apply --parallelism=5 

## reconcile the state in Terraform state file with real-world resources
terraform refresh

## get information about providers used in current configuration
terraform providers 



