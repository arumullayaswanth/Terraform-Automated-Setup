# Step-by-Step Guide to Deploying AWS Instances Using Terraform

## Prerequisites

Before proceeding, ensure you have:

- An AWS account
- Terraform installed on your system
- AWS CLI configured with credentials

## Step 1: Initialize a Terraform Project

1. Create a new directory for your Terraform project:
   ```sh
   mkdir terraform
   cd terraform
   ```
2. Create a new Terraform file:
   ```sh
   vim main.tf
   ```

## Step 2: Define the AWS Provider in `main.tf`

Open `main.tf` and add the following:

### Example 1: Using `count`

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  count = length(var.instance_type)
  ami = "ami-02f624c08a83ca16f"
  instance_type = var.instance_type[count.index]
  tags = {
    Name = var.instance_name[count.index]
  }
}

variable "instance_type" {
  default = ["t2.medium", "t2.micro", "t2.nano"]
}

variable "instance_name" {
  default = ["webserver", "appserver", "dbserver"]
}
```

### Example 2: Using `for_each`

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "two" {
  for_each = toset(["web-server", "app-server", "db-server"])
  ami = "ami-04beabd6a4fb6ab6f"
  instance_type = "t2.micro"
  key_name = "my-Key pair"
  tags = {
    Name = each.key
  }
}
```

## Step 3: Initialize and Apply Terraform Configuration

1. Initialize Terraform:
   ```sh
   terraform init
   ```
2. Validate the configuration:
   ```sh
   terraform validate
   ```
3. Preview the execution plan:
   ```sh
   terraform plan
   ```
4. Apply the configuration:
   ```sh
   terraform apply -auto-approve
   ```

## Step 4: Verify Resources

After deployment, check the AWS Management Console under EC2 instances to verify the created instances.

## Step 5: Destroy Resources (Optional)

If you want to delete the created resources, run:

```sh
terraform destroy -auto-approve
```

