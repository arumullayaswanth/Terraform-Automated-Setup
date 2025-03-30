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
  bucket = aws_s3_bucket.example.id            # Corrected reference to match the bucket name
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
# Creates an EBS volume with encryption enabled
resource "aws_ebs_volume" "two" {
  size              = 20  # Volume size in GB
  availability_zone = "us-east-1b"  # Ensure this matches the EC2 instance's AZ
  encrypted         = true  # Enables encryption for security
  volume_type       = "gp3"  # Optimized performance volume type
  iops              = 3000  # Provisioned IOPS for better performance
  throughput        = 125  # Throughput in MB/s (gp3 only)

  tags = {
    Name = "yaswanth-ebs"  # Tagging the EBS volume for identification
  }
}

```

## AWS IAM User
```hcl
# Create an IAM user with additional configurations
resource "aws_iam_user" "three" {
  name = "yaswanth-user"  # IAM username

  tags = {
    Name        = "yaswanth User"
    Environment = "Production"
  }
}

# Attach the AdministratorAccess policy directly to the user
resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.three.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"  # AWS managed policy for full admin access
}
```

## AWS EC2 Instance
```hcl
# Creates an EC2 instance
resource "aws_instance" "four" {
  ami           = "ami-02f624c08a83ca16f"  # Amazon Linux 2 AMI ID (ensure it's available in your region)
  instance_type = "t2.micro"  # Instance type (Free-tier eligible)

  tags = {
    Name = "yaswanth-terraserver"  # Name tag for the EC2 instance
  }
}
```



## Terraform Configuration with Line-by-Line Comments

```hcl
# Specifies the AWS provider and region
provider "aws" {
  region = "us-east-1"  # Set AWS region to US East (N. Virginia)
}

# Create an S3 Bucket with Tags
resource "aws_s3_bucket" "example" {
  bucket = "yaswanth523192"  # Must be globally unique

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}

# Enable Versioning on the S3 Bucket
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Creates an EBS volume with encryption enabled
resource "aws_ebs_volume" "two" {
  size              = 20  # Volume size in GB
  availability_zone = "us-east-1b"  # Ensure this matches the EC2 instance's AZ
  encrypted         = true  # Enables encryption for security
  type              = "gp3"  # Specify the volume type
  iops              = 3000  # Provisioned IOPS for gp3
  throughput        = 125  # Throughput in MB/s (gp3 only)

  tags = {
    Name = "yaswanth-ebs"  # Tagging the EBS volume for identification
  }
}
# Create an IAM user with additional configurations
resource "aws_iam_user" "three" {
  name = "yaswanth-user"  # IAM username

  tags = {
    Name        = "yaswanth User"
    Environment = "Production"
  }
}

# Attach the AdministratorAccess policy directly to the user
resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.three.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"  # AWS managed policy for full admin access
}

# Creates an EC2 instance
resource "aws_instance" "four" {
  ami           = "ami-02f624c08a83ca16f"  # Amazon Linux 2 AMI ID (ensure it's available in your region)
  instance_type = "t2.micro"  # Instance type (Free-tier eligible)

  tags = {
    Name = "yaswanth-terraserver"  # Name tag for the EC2 instance
  }
}
```

---

## Raw `.hcl` File

```hcl
provider "aws" {
  region = "us-east-1"
}

# Create an S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "yaswanth523192" 
}

# Enable Versioning on the S3 Bucket
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id            
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_tagging" "tags_example" {
  bucket = aws_s3_bucket.example.id

  tag_set = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}

# Creates an EBS volume with encryption enabled
resource "aws_ebs_volume" "two" {
  size              = 20 
  availability_zone = "us-east-1b"  
  encrypted         = true  
  volume_type       = "gp3"  
  iops              = 3000  
  throughput        = 125 

  tags = {
    Name = "yaswanth-ebs" 
  }
}

# Create an IAM user with additional configurations
resource "aws_iam_user" "three" {
  name = "yaswanth-user" 

  tags = {
    Name        = "yaswanth User"
    Environment = "Production"
  }
}
resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.three.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"  
}

# Creates an EC2 instance
resource "aws_instance" "four" {
  ami           = "ami-02f624c08a83ca16f" 
  instance_type = "t2.micro" 

  tags = {
    Name = "yaswanth-terraserver"  
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



