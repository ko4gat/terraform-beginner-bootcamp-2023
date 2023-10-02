# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
|-- main.tf           - everything else
|-- variables.tf      - stores the structure of input variable
|-- providers.tf      - defines required providers and their configuration
|-- outputs.tf        - stores our outputs
|-- terraform.tfvars  - the data of variables we want to load into our Terraform project
|-- README.md         - required for root modules
```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variable
### Terraform Cloud Variables

In Terraform we can set two kinds of variables:

Enviroment Variables - those you would set in your bash terminal eg. AWS Credentials

Terraform Variables - those that you would normally set in your tfvars file.

We can set Terraform Cloud variables to be sensitive so that they are not shown visibly in the UI. 

### Loading Terraform Input Variables
[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### Var Flag

We can use the `-var` flag to set an input variable, or override a variable in the tfvars file eg.`terraform -var user_uuid="my_user_id"`

### Var File Flag

Document this functionality for terraform cloud
[Variable Documentation](https://developer.hashicorp.com/terraform/enterprise/workspaces/variables)

### Terraform.tfvars

This is the default file to load in terraform variables in bulk.

### auto.tfvars

Document this functionality for terraform cloud

### Order of Terraform Variables

Document which Terraform variable settings take precedence.


