# Terraform Locals

## Overview
Terraform **locals** are used to define values once and reuse them multiple times throughout the configuration.

## Example Configuration
```hcl
# Define the AWS provider and set the region
provider "aws" {
  region = "us-east-1"
}

# Define local variables for reuse
locals {
  env    = "test"  # Environment name
  region = "us-east-1"  # AWS region
}

# Create a VPC with a specified CIDR block
resource "aws_vpc" "one" {
  cidr_block = "10.0.0.0/16"  # Defines the VPC network range
  tags = {
    Name = "${local.env}-vpc"  # Naming convention using local variable
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "two" {
  cidr_block        = "10.0.1.0/24"  # Subnet CIDR block, should be within VPC range
  availability_zone = "us-east-1a"  # Availability Zone for the subnet
  vpc_id           = aws_vpc.one.id  # Associate subnet with the VPC
  tags = {
    Name = "${local.env}-subnet"  # Naming convention using local variable
  }
}

# Create an EC2 instance within the subnet
resource "aws_instance" "three" {
  subnet_id      = aws_subnet.two.id  # Attach instance to the subnet
  ami           = "ami-02f624c08a83ca16f"  # Amazon Machine Image ID
  instance_type = "t2.micro"  # Instance type
  key_name      = "your-key-pair-name"  # SSH key pair for access
  tags = {
    Name = "${local.env}-server"  # Naming convention using local variable
  }
}
```
## Example Configuration (HCL File)

### **terraform\_config.hcl**

```hcl
provider "aws" {
  region = "us-east-1"
}

locals {
  env    = "test"
  region = "us-east-1"
}

resource "aws_vpc" "one" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.env}-vpc"
  }
}

resource "aws_subnet" "two" {
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  vpc_id           = aws_vpc.one.id
  tags = {
    Name = "${local.env}-subnet"
  }
}

resource "aws_instance" "three" {
  subnet_id      = aws_subnet.two.id
  ami           = "ami-02f624c08a83ca16f"
  instance_type = "t2.micro"
  key_name      = "your-key-pair-name"
  tags = {
    Name = "${local.env}-server"
  }
}
```



## Key Takeaways
- **Avoid Overlapping CIDR Blocks**: Ensure subnets don't have the same CIDR block as the VPC.
- **Use Locals for Region**: Makes configuration more reusable.
- **Define a Key Pair**: Essential for SSH access to EC2 instances.

This configuration ensures a structured and efficient Terraform deployment. 🚀

## Step-by-Step Terraform Commands

### **1️⃣ Initialize Terraform**
```sh
terraform init
```
> Initializes the Terraform working directory and downloads the necessary provider plugins.

---

### **2️⃣ Validate the Configuration**
```sh
terraform validate
```
> Checks for syntax errors and misconfigurations.

---

### **3️⃣ Show the Execution Plan**
```sh
terraform plan
```
> Displays what Terraform will do before applying changes.

---

### **4️⃣ Apply the Configuration**
```sh
terraform apply -auto-approve
```
> Creates the AWS infrastructure as defined in your configuration.

---

### **5️⃣ Verify Resources in AWS**
```sh
terraform show
```
> Shows the current state of your deployed infrastructure.

---

### **6️⃣ List All Managed Resources**
```sh
terraform state list
```
> Lists all resources currently managed by Terraform in the state file.

---

### **7️⃣ Destroy the Infrastructure (if needed)**
```sh
terraform destroy -auto-approve
```
> Deletes all resources created by Terraform.

---

