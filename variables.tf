# mkdir terraform
# cd terraform

# 1️⃣ main.tf (Terraform Configuration)

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  count         = var.instance_count
  ami           = "ami-03eb6185d756497f8"
  instance_type = var.instance_type

  tags = {
    Name = "yaswanth-${count.index + 1}"  # Unique instance names
  }
}

# 2️⃣ variables.tf (Declaring Variables)

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

/*
✅ Running Terraform Commands
terraform init       # Initialize Terraform
terraform plan       # Preview changes
terraform apply -auto-approve  # Deploy EC2 instances
terraform state list
terraform destroy -auto-approve
terraform destroy -auto-approve -target="aws_instance.one[1]"
*/

