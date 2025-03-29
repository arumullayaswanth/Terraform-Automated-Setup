# TERRAFORM CLI

We can pass inputs for Terraform directly from the CLI.

## Terraform Configuration

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  ami           = "ami-02f624c08a83ca16f"
  instance_type = var.instance_type
  
  tags = {
    Name = "yaswanth-server"
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

