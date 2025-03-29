/*
1️⃣ What is Terraform Output?
Terraform outputs help display important resource properties after deployment.

Used to fetch values like public IP, DNS, instance type, VPC ID, etc.

├── main.tf         # Main Terraform configuration
├── variables.tf    # Variables declaration
├── outputs.tf      # Terraform outputs
├── dev.tfvars      # Dev environment variables
├── test.tfvars     # Test environment variables
*/

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  ami           = "ami-03eb6185d756497f8"
  instance_type = "t2.medium"

  tags = {
    Name = "yaswanth-server"
  }
}

output "public_ip" {
  value = aws_instance.one.public_ip
}

output "private_ip" {
  value = aws_instance.one.private_ip
}

output "public_dns" {
  value = aws_instance.one.public_dns
}

output "private_dns" {
  value = aws_instance.one.private_dns
}


/*
🚀 Running Terraform to Get Outputs
terraform init
terraform apply -auto-approve
terraform output
✅ Want to Save Output to a File?
terraform output > output.txt

terraform destroy -auto-approve
*/

