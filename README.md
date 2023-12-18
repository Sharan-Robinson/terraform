### Terraform AWS Infrastructure Setup Documentation

## Step 1: Ensure Prerequisites
- Terraform is installed.
- AWS account credentials are available. 
*Following best practices, it is useful to create a IAM user and use its security credentials instead of the root user's in order to enhance security.

## Step 2: Terraform Instructions
- Run Terraform init
- Make a .tfvars file that contains defenitions for the AWS access key, security key and IP address you want to access the resource from.
- Run Terraform plan with the tfvars file as an argument to see the changes that will be made. Eg: Terraform plan -var-file="secret.tfvars"
- If satifised with the changes run Terraform apply with the same tfvars file as before. Eg: Terraform apply -var-file="secret.tfvars"

## Step 3: Github Actions
- Create new action yml file and create a job with the previous steps.
- Make github secrets for AWS access and secret keys in order secure them from the public.
- Now whenever a commit is pushed to main, the action will run on its own. 
 
