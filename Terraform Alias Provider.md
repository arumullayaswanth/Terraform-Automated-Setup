# Terraform Configuration: Using Alias and Provider for Multiple Regions

## Step 1: Define the First AWS Provider (US-East-1)

```hcl
provider "aws" {
  region = "us-east-1"
}
```

- This block configures the AWS provider for the `us-east-1` region.

## Step 2: Create an AWS EC2 Instance in US-East-1

```hcl
resource "aws_instance" "one" {
  ami = "ami-02f624c08a83ca16f"
  instance_type = "t2.micro"
  tags = {
    Name = "usa-server"
  }
}
```

- This block creates an EC2 instance using the specified AMI and instance type in the `us-east-1` region.

## Step 3: Define the Second AWS Provider (Tokyo Region) with Alias

```hcl
provider "aws" {
  region = "ap-northeast-1"
  alias = "tokyo"
}
```

- This block configures another AWS provider for the `ap-northeast-1` (Tokyo) region and assigns it an alias `tokyo`.

## Step 4: Create an AWS EC2 Instance in Tokyo Region Using Alias

```hcl
resource "aws_instance" "two" {
  provider = aws.tokyo
  ami = "ami-0bcf3ca5a6483feba"
  instance_type = "t2.large"
  tags = {
    Name = "tokyo-server"
  }
}
```
## Full HCL Code

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  ami = "ami-02f624c08a83ca16f"
  instance_type = "t2.micro"
  tags = {
    Name = "usa-server"
  }
}

provider "aws" {
  region = "ap-northeast-1"
  alias = "tokyo"
}

resource "aws_instance" "two" {
  provider = aws.tokyo
  ami = "ami-0bcf3ca5a6483feba"
  instance_type = "t2.large"
  tags = {
    Name = "tokyo-server"
  }
}
```


- This block creates an EC2 instance in the `ap-northeast-1` region by explicitly using the `aws.tokyo` provider alias.

## Terraform Commands to Apply Configuration

### Step 1: Initialize Terraform
```sh
terraform init
```
- Initializes the Terraform working directory and downloads the necessary provider plugins.

### Step 2: Validate Configuration
```sh
terraform validate
```
- Checks the syntax and validity of the Terraform configuration.

### Step 3: Plan the Deployment
```sh
terraform plan
```
- Generates an execution plan to preview changes before applying them.

### Step 4: Apply the Configuration
```sh
terraform apply -auto-approve
```
- Deploys the resources to AWS.

### Step 5: Verify Resources
```sh
aws ec2 describe-instances --region us-east-1
aws ec2 describe-instances --region ap-northeast-1
```
- Checks the created EC2 instances in respective regions.

### Step 6: Destroy Resources (Optional)
```sh
terraform destroy -auto-approve
```
- Deletes all the created resources.
