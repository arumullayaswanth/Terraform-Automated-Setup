# Terraform Workspaces Guide

## TERRAFORM WORKSPACE:

WORKSPACE: Where we write the code and execute operations.
It is used to isolate the environment.
In real-time, all the work we do is on workspaces only.
If we perform an operation on one workspace, it won't affect another workspace.

### NOTE:

1. We can't delete our current workspace.
2. We can't delete our workspace without deleting resources.
3. We can't delete the default workspace.

### COMMANDS:

- `terraform workspace list` : to list workspaces
- `terraform workspace new dev` : to create a new workspace
- `terraform workspace show` : to show the current workspace
- `terraform workspace select prod` : to switch workspaces
- `terraform workspace delete prod` : to delete the workspaces

---

## Step 1: Setup Terraform & Initialize Workspace

Before proceeding, ensure you have Terraform installed.

### Create a Directory and Navigate Into It

```sh
mkdir terraform
cd terraform
```

### Verify the Directory Contents

```sh
ll   # or use ls -l if 'll' is not available
```

### Create and Edit the Terraform Configuration File

```sh
vim main.tf
```

Once inside Vim, press **`i`** to enter **Insert Mode**, then add your Terraform configuration.
When done, press **`ESC`**, type **`:wq`**, and press **Enter** to save and exit.

### Initialize Terraform

```sh
terraform init
```

---

## Step 2: Create Developer Infrastructure

### 1. Create a New Workspace for Development

```sh
terraform workspace new dev
```
```sh
terraform workspace select dev
```
```sh
terraform workspace list
```
```sh
terraform workspace show
```

### 2. Create a Terraform Configuration File (main.tf)

Create a `main.tf` file with the following content:

```hcl
provider "aws" {
  region = "us-east-1"
}

locals {
  env = "${terraform.workspace}"
}

resource "aws_vpc" "one" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${local.env}-vpc"
  }
}

resource "aws_subnet" "two" {
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  vpc_id           = aws_vpc.one.id

  tags = {
    Name = "${local.env}-subnet"
  }
}

resource "aws_instance" "three" {
  subnet_id      = aws_subnet.two.id
  ami           = "ami-02f624c08a83ca16f"
  instance_type = "t2.micro"

  tags = {
    Name = "${local.env}-server"
  }
}
```

### 3. Apply the Terraform Configuration

```sh
terraform apply -auto-approve
```
```sh
terraform workspace show
```
```sh
terraform state list
```

This deploys the infrastructure in the **Development** environment.

---

## Step 3: Create Testing Infrastructure

### 1. Create a New Workspace for Testing

```sh
terraform workspace new test
```
```sh
terraform workspace select test
```
```sh
terraform workspace list
```
```sh
terraform workspace show
```

### 2. Apply the Terraform Configuration

Since we are using workspaces, the same `main.tf` file will be used.

```sh
terraform apply -auto-approve
```
```sh
terraform workspace show
```
```sh
terraform state list
```

This deploys the infrastructure in the **Testing** environment.

---

## Step 4: Create Production Infrastructure

### 1. Create a New Workspace for Production

```sh
terraform workspace new prod
```
```sh
terraform workspace select prod
```
```sh
terraform workspace show
```

### 2. Apply the Terraform Configuration

```sh
terraform apply -auto-approve
```
```sh
terraform workspace show
```
```sh
terraform state list
```

This deploys the infrastructure in the **Production** environment.

---

## Step 5: Deleting Infrastructure Resources One by One

### 1. Delete the AWS Instance

```sh
terraform destroy -target=aws_instance.three -auto-approve
```

### 2. Delete the AWS Subnet

```sh
terraform destroy -target=aws_subnet.two -auto-approve
```

### 3. Delete the AWS VPC

```sh
terraform destroy -target=aws_vpc.one -auto-approve
```

### 4. Delete the Entire Workspace Infrastructure

If you want to destroy everything at once in a workspace, run:

```sh
terraform destroy -auto-approve
```

---

## Step 6: Delete a Workspace

### 1. Switch to Another Workspace

Terraform does not allow deleting the current workspace, so first switch to the **default** workspace.

```sh
terraform workspace select default
```

### 2. Delete the Workspace

```sh
terraform workspace delete dev
terraform workspace delete test
terraform workspace delete prod
```

Note: You cannot delete a workspace without destroying its resources first.

---

## Step 7: Generate a Terraform Graph

Terraform graph command shows the relationship between resources.
To list all resources managed by Terraform, run:
```sh
terraform state list
```
This will display a list of all resources tracked in the state file.

---

## Step 8: Terraform Graph
To visualize the infrastructure as a graph, run the following command:
```sh
terraform graph
```
This will generate a DOT format output which you can then visualize using Graphviz.

### Steps to Visualize:
1. Copy the output from the `terraform graph` command.
2. Go to [Graphviz Online Viewer](https://dreampuf.github.io/GraphvizOnline/) or any Graphviz tool.
3. Paste the content in the editor to visualize the infrastructure flow.
4. This will generate a flow chart of your resources and their dependencies.

---

