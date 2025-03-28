provider "aws" {
  region = "ap-south-1"  # AWS Region (Mumbai)
}

resource "aws_instance" "one" {
  count         = var.instance_count  # Number of instances to create
  ami           = "ami-0b41f7055516b991a"  # Amazon Linux 2 AMI (ap-south-1)
  instance_type = var.instance_type  # Instance type (customizable)

  tags = {
    Name = "TerraformInstance-${count.index + 1}"  # Unique name for each instance
  }
}

variable "instance_type" {
  description = "Instance type to be used (e.g., t2.micro, t3.medium)"
  type        = string
  default     = "t2.micro"  # Default value
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
  default     = 5  # Default value
}


/*
terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve
*/

