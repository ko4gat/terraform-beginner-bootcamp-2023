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

## Dealing with Configuration Drift

### What happens if we lose our state file?

If you lose your state file, you will most likely have to tear down all your cloud infrastructure manually. 
You can use terraform input, but it won't work for all cloud resource. You will need to check the terraform providers docmentation for which resources support import.

### Fix Missing Resources With Terraform Import

```terraform import aws_s3_bucket.bucket bucket-name```

[Terraform Import](https://developer.hashicorp.com/terraform/cli/commands/import)

### Fix Manual Configuration

If someone modifies cloud resources manually through click-ops. If we run `terraform plan` again it will attempt to put our infrastructure back into the expected state fixing Configuration Drift.

## Terraform Modules

### Terraform Module Structure

It is reccomended to place modules in a `modules`` directory when locally developing modules but you can name it whatever you like.
 
### Passing Input Variables

We can pass input variables to our module. 

The module has to declare these terraform variables in it's own variables.tf


```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```


### Module Resources

Using the source we can import the module from various places eg.
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

## Considerations when using ChatGPT to write Terraform

LLM's such as ChatGPT may not be trained on the latest documentation or information about Terraform. So it may likely produce older examples that are depracated, often affecting providers. 

## Working with Files in Terraform 

### Fileexists Function

This is a built in function within Terraform to check for the existance of a file eg.

```tf
  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified file path does not exist or is invalid."
  }
```
[Fileexists Documentation](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

```tf
etag = filemd5(var.error_html_filepath)
```

[Filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In Terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get path for the current module
- path.root = get the path for the root module


[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

  etag = filemd5(var.index_html_filepath)
}
```

## Terraform Locals
Locals allow us to define local variables.
It can be very useful when we need to transform data into another format and have referenced a variable. 

```tf
locals {
    s3_origin_id = "MyS3Origin"

}
```


[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources
This allows us to source data from cloud resources. This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We used  jsonencode to create the policy inline in the hcl. 

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)