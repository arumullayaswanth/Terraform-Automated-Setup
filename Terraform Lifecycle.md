# Terraform Life Cycle Management

Terraform's lifecycle management helps control how resources are created, updated, and deleted. Let's break down some key lifecycle policies using real-world analogies.

## 1. Prevent Destroy 🚫

### Think of it like: **A safety lock on important files**

The `prevent_destroy` argument ensures that Terraform does not accidentally delete a resource. If enabled, running `terraform destroy` will fail, preventing accidental data loss.

### Example:

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  ami                    = "ami-02f624c08a83ca16f"
  instance_type          = "t2.micro"
  key_name               = "my-Key pair"
  subnet_id              = "subnet-0907c9cc1cef5a98b"
  vpc_security_group_ids = ["sg-0b2a45ed3aad43c2a"]

  tags = {
    Name = "yaswanth-server"
  }

  lifecycle {
    prevent_destroy = true
  }
}
```

### Commands:

```sh
vim main.tf
terraform apply --auto-approve
terraform destroy --auto-approve  # This will fail due to prevent_destroy
```

To remove the restriction, set `prevent_destroy` to `false`:

```hcl
lifecycle {
  prevent_destroy = false
}
```

Then apply and destroy:

```sh
terraform destroy --auto-approve
```

---

## 2. Ignore Changes 🚦

### Think of it like: **A setting that prevents automatic updates**

The `ignore_changes` argument ensures that Terraform does not update a resource if certain attributes change outside of Terraform (e.g., manually modifying an instance's tags in AWS).

### Example:

```hcl
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "one" {
  ami           = "ami-02f624c08a83ca16f"
  instance_type = "t2.micro"

  tags = {
    Name = "yaswanth-server"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
```

💡 **What happens here?** If you change the tags directly in AWS, Terraform will not override them during `terraform apply`.

---

## 3. Depends On 🔄

### Think of it like: **Building a house—foundation first, then walls**

The `depends_on` argument ensures that one resource is created before another. This helps avoid dependency issues.

### Example:

```hcl
resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket"
}

resource "aws_instance" "one" {
  ami           = "ami-02f624c08a83ca16f"
  instance_type = "t2.micro"

  depends_on = [aws_s3_bucket.example]
}
```

💡 **What happens here?** The EC2 instance will only be created **after** the S3 bucket is successfully set up.

---

### 🌟 Summary

| Feature           | Purpose                                     | Real-World Analogy                      |
| ----------------- | ------------------------------------------- | --------------------------------------- |
| `prevent_destroy` | Prevents accidental deletion of resources   | Safety lock on important files          |
| `ignore_changes`  | Ignores changes made outside Terraform      | Prevents automatic updates on a setting |
| `depends_on`      | Ensures resource dependencies are respected | Building a house in the right order     |

Using these lifecycle policies helps manage infrastructure effectively and prevents unintended modifications or deletions. 🚀

