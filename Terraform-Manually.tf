/*
📌 Terraform Import: Importing Manually Created Resources
Terraform import allows you to bring existing AWS resources under Terraform management without recreating them.
*/
#✅ Steps to Import an Existing EC2 Instance

#1️⃣ Ensure main.tf has an Empty Resource Block

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  # The instance will be imported, so no need to define properties yet.
}


2️⃣ Find the EC2 Instance ID
✅ Running Terraform Commands
# Run this command to get the instance ID of the existing EC2:
aws ec2 describe-instances --query "Reservations[*].Instances[*].InstanceId" --output table

/*
➡️ Example output:
-------------------------------------------------
|               DescribeInstances               |
+-----------------------------------------------+
|  i-0f4c0d5d3bb6dc758                          |
+-----------------------------------------------+
➡️ Instance ID: i-0f4c0d5d3bb6dc758
*/


3️⃣ Import the EC2 Instance

terraform import aws_instance.one i-0f4c0d5d3bb6dc758

✅ This command tells Terraform to track the manually created instance.


4️⃣ View Imported Resource Configuration
#After importing, run:
terraform show
✅ Copy and paste the output into main.tf, so Terraform can manage it properly.

#5️⃣ Update main.tf with Imported Instance Detail
resource "aws_instance" "one" {
  ami           = "ami-0b41f7055516b991a"  # Replace with actual AMI
  instance_type = "t2.micro"  # Replace with actual instance type
  tags = {
    Name = "ImportedInstance"
  }
}
#✅ Now, Terraform can manage this EC2 instance!
