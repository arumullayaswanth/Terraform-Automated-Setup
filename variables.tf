# mkdir terraform
# cd terraform
# example -1
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
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# example -2
#1️⃣ vim main.tf (Terraform Configuration)

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  count         = var.instance_count
  ami           = "ami-03eb6185d756497f8"
  instance_type = var.instance_type

  tags = {
    Name = "raham-server-${count.index + 1}"  # Unique name for each instance
  }
}

#2️⃣ vim variable.tf (Declaring Variables) 

variable "instance_count" {
  description = "Number of EC2 instances to create" #  description and an optional default value.
  type        = number                  #type, and an optional default value.
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

#3️⃣ vim dev.tfvars (For Development Environment)

instance_count = 1
instance_type  = "t2.micro"

#4️⃣ vim test.tfvars (For Testing Environment)

instance_count = 2
instance_type  = "t2.medium"

/*

✅ Running Terraform with Different Environments
Run Terraform with the dev environment:
terraform apply -var-file="dev.tfvars" -auto-approve

Run Terraform with the test environment:
terraform apply -var-file="test.tfvars" -auto-approve

Destroy resources for a specific environment:
terraform destroy -var-file="dev.tfvars" -auto-approve

*/




