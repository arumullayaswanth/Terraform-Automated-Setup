#Terraform Configuration for AWS EC2 Instance

provider "aws" {
  region = "us-east-1"  # Define the AWS region
}

resource "aws_instance" "one" {
  ami = "ami-03eb6185d756497f8"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"  # Free-tier eligible instance type

  tags = {
    Name = "MyTerraformInstance"  # Tag to name the instance
  }
}



#How to Apply This Configuration
#Initialize Terraform (downloads necessary provider plugins)
#terraform init

#Preview Changes Before Applying (dry run)
#terraform plan

#Apply the Configuration (creates the EC2 instance)
#terraform apply -auto-approve

#Destroy the Instance (if needed)/to delete resources
#terraform destroy -auto-approve
       

