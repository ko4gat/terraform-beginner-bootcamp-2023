# Terraform Beginner Bootcamp 2023 week 0
  * [Semantic-Versioning](#semantic-versioning)
  * [INSTALL TERRAFORM CLI](#install-terraform-cli)
    + [Considerations with Terraform CLI changes](#considerations-with-terraform-cli-changes)
    + [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
      - [Shebang Considerations](#shebang-considerations)
      - [Execution Considerations](#execution-considerations)
      - [Linux Permissions Considerations](#linux-permissions-considerations)
    + [Considerations for Linux Distribution](#considerations-for-linux-distribution)
    + [Gitpod Lifecycle](#gitpod-lifecycle)
  * [Working with Env Vars](#working-with-env-vars)
    + [Env Var Commands](#env-var-commands)
    + [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
    + [Printing Vars](#printing-vars)
    + [Scoping of Env Vars](#scoping-of-env-vars)
    + [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
  * [AWS CLI INSTALLATION](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
    + [Terraform Registries](#terraform-registries)
  * [Terraform Console](#terraform-console)
      - [Terraform Init](#terraform-init)
      - [Terraform Plan](#terraform-plan)
      - [Terraform Apply](#terraform-apply)
      - [Terraform Destroy](#terraform-destroy)
      - [Terraform Lock Files](#terraform-lock-files)
      - [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
  * [Issues with Terraform Cloud and Gitpod Workspace Login](#issues-with-terraform-cloud-and-gitpod-workspace-login)


## Semantic-Versioning

This project is going to utilize semantic versioning for it tagging.

[semver.org](https://semver.org/)

Given a version number MAJOR.MINOR.PATCH, increment the:

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## INSTALL TERRAFORM CLI

### Considerations with Terraform CLI changes
The Terraform CLI instructions have changed due to GPG keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depracation issues we noticed that the bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

The bash script can be found here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This will make the manual installation of Terraform CLI easier to debug and install. 
- Provides better portability for other projects that may require Terraform CLI installation. 

https://linuxize.com/post/how-to-check-linux-version/

#### Shebang Considerations

A Shebang (pronounced Sha-Bang) tells the bash script what program will interpret the script. eg `#!/bin/bash` 

ChatGPT recomennded we use this format: `#!/usr/bin/env bash`

- For portability for different OS distributions.
- Will search the user's PATH for the executable 

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing bash scripts we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.
eg `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order our bash scripts executable we need to change Linux permissions for the file to be executable at the user mode. 

```sh
chmod u+x ./bin/install_terraform_cli
```
alternatively 
```sh
chmod 744 ./bin/install_terraform_cli
```
https://en.wikipedia.org/wiki/Chmod


### Considerations for Linux Distribution

This project is built against Ubunutu. 
Please consider checking your Linux distribution and change according to distribution needs.

[How to Check OS version in Linux](https://linuxize.com/post/how-to-check-linux-version/)

>Example of checking OS Version
```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Gitpod Lifecycle

We need to be careful when using Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

## Working with Env Vars

### Env Var Commands
We can list out all enviroment variables (Env Var) using the `env` command.

We can filter specific env vars using grep. eg. `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set using `export Hello=`World`

In the terminal we unset using `unset Hello`

We can set env var temporarily when just running a command. 

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export eg.
```
#!/usr/bin/env bash
HELLO='world'
echo $Hello
```
### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window. 

If you want env vars to persist across all future bash terminals that are open you need to set env vars in your bash profile eg. `.bash_profile` 

### Persisting Env Vars in Gitpod

We can persist env vars into Gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the new env vars for all bash terminals opened in those workspaces. 

You can also set env vars in the `.gitpod.yml` but this can only contain non sensitive env vars. 

## AWS CLI INSTALLATION
 
 AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

 [Getting Started Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

 [AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)


We can check if our AWS credentials are configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this:
```json
{
    "UserId": "AIDRZU4VMLCHK6R6I1KBZ",
    "Account": "123456789844",
    "Arn": "arn:aws:iam::663487254573:user/terraform-beginner-bootcamp"
}
```
We'll need to generate AWS CLI credentials from IAM user, in order to use the AWS CLI.

# Terraform Basics

### Terraform Registries

Terraform sources their providers and modules from the terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** are an interface to API's which will allow you to create resources in Terraform
- **Modules** are a way to make large amounts of Terraform code modular, portable, and shareable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

## Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`

#### Terraform Init

At the start of a new Terraform project, we wil run `terraform init` to download the binaries for the Terraform providers that we'll use in this project.

#### Terraform Plan

`terraform plan`
This will generate out a changeset, about the state of our infrastructure and what will be changed. We can output this changeset i.e. "plan" to be passed to an apply but often you can just ignore outputting. 

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by Terraform. Apply should prompt us "yes" or "no". If we want to automatically approve a reply, we can provide an auto-approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`

This will destroy resources.

You can also use the auto approve flag to skip the approve prompt. `terraform destroy --auto-approve`

#### Terraform Lock Files

`terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform locked file **should be commited** to your Version Control System (VCS) eg. "Github"


#### Terraform State Files

`terraform.tfstate` contain information about the current state of your infrastructure.

This file **should not be committed** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose knowing the state of your infrastructure.

`terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries for Terraform providers.

## Issues with Terraform Cloud and Gitpod Workspace Login

When attempting to run 'terraform login' it will launch in bash a wiswig view to generate a token. However it does not work as expected in Gitpod VSCode in browser. 
The workaround is to manually generate a token in Terraform cloud.

```https://app.terraform.io/app/settings/tokens
```

Then create and open the file manually here: 

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
```

```sh
open /home/gitpod/.terraform.d/credentials.tfrc.json
```
Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

We have automated this workaround with the following bash script:

[bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)


[bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

