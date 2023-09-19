# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

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

### Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

