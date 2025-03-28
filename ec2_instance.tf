#Terraform Configuration for AWS EC2 Instance

provider "aws" {
  region = "us-east-1"  # Define the AWS region
}

resource "aws_instance" "one" {
  ami = "ami-02f624c08a83ca16f"  # Amazon Linux 2 AMI
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


/*
#Terraform Configuration for AWS EC2 5 Instance
provider "aws" {
  region = "ap-south-1"  # AWS region (Mumbai)
}

resource "aws_instance" "one" {
  count         = 5  # Creates 5 EC2 instances
  ami           = "ami-0b41f7055516b991a"  # AMI ID (Amazon Linux 2 in ap-south-1)
  instance_type = "t2.micro"  # Free-tier eligible instance type

  tags = {
    Name = "TerraformInstance-${count.index + 1}"  # Unique name for each instance
  }
}
*/
       

