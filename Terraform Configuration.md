# Terraform Configuration with Best Practices

## Overview
This Terraform script provisions an AWS environment that includes:
- An S3 bucket
- An EBS volume
- An IAM user
- An EC2 instance

---

## Provider Configuration
```hcl
# Specifies the AWS provider and region
provider "aws" {
  region = "us-east-1"  # Set AWS region to US East (N. Virginia)
}
```

## AWS S3 Bucket
```hcl
# Create an S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "yaswanth523192"  # Must be globally unique
}

# Enable Versioning on the S3 Bucket
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Add Tags (Optional)
resource "aws_s3_bucket_tagging" "tags_example" {
  bucket = aws_s3_bucket.example.id

  tag_set = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}
```

## AWS EBS Volume
```hcl
# Creates an EBS volume
resource "aws_ebs_volume" "two" {
  size              = 20  # Volume size in GB
  availability_zone = "us-east-1b"  # Ensure this matches the EC2 instance's AZ

  tags = {
    Name = "raham-ebs"  # Tagging the EBS volume for identification
  }
}

```

## AWS IAM User
```hcl
# Creates an IAM user
resource "aws_iam_user" "three" {
  name = "raham-user"  # IAM username
}
```

## AWS EC2 Instance
```hcl
# Creates an EC2 instance
resource "aws_instance" "four" {
  ami           = "ami-03eb6185d756497f8"  # Amazon Linux 2 AMI ID (ensure it's available in your region)
  instance_type = "t2.micro"  # Instance type (Free-tier eligible)

  tags = {
    Name = "Raham-terraserver"  # Name tag for the EC2 instance
  }
}
```



## Terraform Configuration with Line-by-Line Comments

```hcl
# Specifies the AWS provider and region
provider "aws" {
  region = "us-east-1"  # Set AWS region to US East (N. Virginia)
}

# Creates an S3 bucket
resource "aws_s3_bucket" "one" {
  bucket = "rahamshaik9988-terraform-bucket"  # Ensure the name is globally unique
}

# Creates an EBS volume
resource "aws_ebs_volume" "two" {
  size              = 20  # Volume size in GB
  availability_zone = "us-east-1b"  # Ensure this matches the EC2 instance's AZ

  tags = {
    Name = "raham-ebs"  # Tagging the EBS volume for identification
  }
}

# Creates an IAM user
resource "aws_iam_user" "three" {
  name = "raham-user"  # IAM username
}

# Creates an EC2 instance
resource "aws_instance" "four" {
  ami           = "ami-03eb6185d756497f8"  # Amazon Linux 2 AMI ID (ensure it's available in your region)
  instance_type = "t2.micro"  # Instance type (Free-tier eligible)

  tags = {
    Name = "Raham-terraserver"  # Name tag for the EC2 instance
  }
}
```

---

## Raw `.hcl` File

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "one" {
  bucket = "rahamshaik9988-terraform-bucket"
}

resource "aws_ebs_volume" "two" {
  size              = 20
  availability_zone = "us-east-1b"
  tags = {
    Name = "raham-ebs"
  }
}

resource "aws_iam_user" "three" {
  name = "raham-user"
}

resource "aws_instance" "four" {
  ami           = "ami-03eb6185d756497f8"
  instance_type = "t2.micro"
  tags = {
    Name = "Raham-terraserver"
  }
}
```

---

## Suggested Fixes & Best Practices
1. **S3 Bucket Naming**:
   - AWS enforces globally unique bucket names.
   - Make sure `rahamshaik9988-terraform-bucket` is unique across AWS.

2. **EBS Volume Availability Zone**:
   - Ensure the instance and volume are in the same availability zone if attaching the volume to the instance.
   - Example: If your EC2 instance is in `us-east-1a`, then set `availability_zone = "us-east-1a"`.

3. **IAM User Name**:
   - AWS IAM usernames should be unique within your account.

4. **Security Groups & Key Pair for EC2**:
   - You might need to add a security group and key pair for SSH access.

## ✅ Best Practices & Recommendations
- **S3 Bucket Naming**: Ensure the bucket name is unique across AWS.
- **EBS Volume Availability Zone**: Match the availability zone with the EC2 instance.
- **IAM User Naming**: Ensure unique IAM user names in your AWS account.
- **Security Groups & Key Pair for EC2**: Add a security group and key pair for SSH access.
- **Check AMI Availability**: Make sure the AMI ID is available in your AWS region.

Would you like additional enhancements like attaching the EBS volume to the EC2 instance? 🚀

## Running Terraform Commands
```sh
# Initialize Terraform
terraform init
```
```sh
# Apply configuration
terraform apply --auto-approve

```
```sh
# Destroy resources
terraform destroy --auto-approve
```



