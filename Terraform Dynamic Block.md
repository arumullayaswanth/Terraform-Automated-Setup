# Step-by-Step Guide for Terraform Dynamic Block in AWS

## Prerequisites

- Install [Terraform](https://developer.hashicorp.com/terraform/downloads)
- AWS CLI configured with appropriate access (`aws configure`)
- Key pair created in AWS (use the same key name in the Terraform script)

## Step 1: Create a Terraform Configuration File

### Create a new directory and navigate to it:
Create a new directory for the Terraform setup
```sh
mkdir terraform && cd terraform
```

### Create a new file `main.tf`:

```sh
vim main.tf
```

### Open the file and add the following content:

```hcl
provider "aws" {
}

locals {
  ingress_rules = [{
    port        = 443
    description = "Ingress rules for port 443"
    },
    {
      port        = 80
      description = "Ingress rules for port 80"
  },
  {
      port        = 8080
      description = "Ingress rules for port 8080"
  }]
}

resource "aws_instance" "ec2_example" {
  ami                    = "ami-02f624c08a83ca16f"
  instance_type          = "t2.micro"
  key_name               = "my-Key pair"
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    Name = "Terraform-EC2"
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "*"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
  }]

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = "*"
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "terraform-sg"
  }
}
```

## Step 2: Initialize Terraform

Run the following command to initialize Terraform:

```sh
terraform init
```

## Step 3: Validate Terraform Configuration

To check for syntax errors, run:

```sh
terraform validate
```

## Step 4: Plan the Terraform Deployment

To see what changes Terraform will make, run:

```sh
terraform plan
```

## Step 5: Apply the Configuration

Run the following command to create resources on AWS:

```sh
terraform apply --auto-approve
```

## Step 6: Verify the Deployment

Once the resources are created, go to the AWS Management Console and verify:

- EC2 instance is running
- Security group has the correct ingress rules


```sh
aws ec2 describe-instances --filters "Name=tag:Name,Values=Terraform-EC2"
```

```sh
aws ec2 describe-security-groups --filters "Name=tag:Name,Values=terraform-sg"
```

## Step 7: Destroy Resources (Optional)

If you want to delete the created resources, run:

```sh
terraform destroy --auto-approve
```

## Conclusion

This guide provides a step-by-step approach with individual commands to create and manage AWS resources using Terraform's dynamic block for security group rules. Happy Terraforming!




