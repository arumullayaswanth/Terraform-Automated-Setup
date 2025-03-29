# 📌 Terraform Outputs: Displaying Resource Details

## 1️⃣ What is Terraform Output?
Terraform **outputs** help display important resource properties after deployment. These are useful for fetching dynamically assigned values like:
- Public & private IP addresses
- DNS names
- Instance type, VPC ID, and more

### 📂 Project Structure
```
├── main.tf         # Main Terraform configuration
├── variables.tf    # Variables declaration
├── outputs.tf      # Terraform outputs
├── dev.tfvars      # Dev environment variables
├── test.tfvars     # Test environment variables
```

---

## 2️⃣ Terraform Configuration

### **`main.tf` (Terraform Configuration)**
```hcl
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
```

### **`outputs.tf` (Terraform Outputs)**
```hcl
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
```

---

## 🚀 Running Terraform to Get Outputs

### **Initialize Terraform**
```bash
terraform init
```

### **Apply Changes & Get Outputs**
```bash
terraform apply -auto-approve
terraform output
```

### ✅ **Want to Save Output to a File?**
```bash
terraform output > output.txt
```

### **Destroy Resources**
```bash
terraform destroy -auto-approve
```

✅ Now, Terraform will automatically display the important information after deployment! 🎯

