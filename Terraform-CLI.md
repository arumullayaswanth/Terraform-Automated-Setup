# TERRAFORM CLI

We can pass inputs for Terraform directly from the CLI.

## Terraform Configuration

```hcl
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "one" {
  ami           = "ami-0b41f7055516b991a"
  instance_type = var.instance_type
  
  tags = {
    Name = "raham-server"
  }
}

variable "instance_type" {
}
```

## Running Terraform Commands with CLI Variables

### Apply Configuration with Instance Type
```bash
terraform apply --auto-approve -var="instance_type=t2.medium"
```

### Destroy Resources with CLI Variable
```bash
terraform destroy --auto-approve -var="instance_type=t2.medium"
```



## Running Terraform Commands

### Apply and Destroy without Variables
```bash
terraform apply --auto-approve
terraform destroy --auto-approve
```

