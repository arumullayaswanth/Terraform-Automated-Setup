# 📌 Terraform Import: Importing Manually Created Resources

Terraform **import** allows you to bring existing AWS resources under Terraform management **without recreating them**.

---

## ✅ Steps to Import an Existing EC2 Instance

### **1️⃣ Ensure `main.tf` has an Empty Resource Block**

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  # The instance will be imported, so no need to define properties yet.
}
```

---

### **2️⃣ Find the EC2 Instance ID**

Run this command to get the **instance ID** of the existing EC2:

```bash
aws ec2 describe-instances --region us-east-1 --query "Reservations[*].Instances[*].InstanceId" --output table

```

➡️ **Example output:**
```
-------------------------------------------------
|               DescribeInstances               |
+-----------------------------------------------+
|  i-0f4c0d5d3bb6dc758                          |
+-----------------------------------------------+
```
➡️ **Instance ID: `i-0f4c0d5d3bb6dc758`**

---

### **3️⃣ Import the EC2 Instance**

```bash
terraform import aws_instance.one i-0f4c0d5d3bb6dc758
```
✅ **This command tells Terraform to track the manually created instance.**

---

### **4️⃣ View Imported Resource Configuration**

After importing, run:

```bash
terraform show
```
✅ **Copy and paste the output into `main.tf`**, so Terraform can manage it properly.

---

### **5️⃣ Update `main.tf` with Imported Instance Details**

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  ami                    = "ami-02f624c08a83ca16f"
  instance_type          = "t2.micro"
  key_name               = "my-Linux-keypair"
  subnet_id              = "subnet-0d3f6eae9f19fc8b4"
  vpc_security_group_ids = ["sg-00027bab2ce18a7e3"]

  tags = {
    Name = "Manually"
  }
}
```

✅ **Now, Terraform can manage this EC2 instance!**

