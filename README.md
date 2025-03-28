# Terraform Automated Setup

This project automates the deployment of AWS EC2 instances using Terraform.\
You can configure the **instance type** and **number of instances** using Terraform variables.

## 🚀 Features

- Deploys multiple EC2 instances on AWS
- Uses variables for flexibility
- Automatically tags instances
- Simple and reusable Terraform setup

---

## 📌 Prerequisites

Before running this Terraform script, ensure you have:

1. **AWS CLI installed & configured**
   ```bash
   aws configure
   ```
2. **Terraform installed**
   ```bash
   terraform -version
   ```

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/your-username/Terraform-Automated-Setup.git
cd Terraform-Automated-Setup
```

### 2️⃣ Initialize Terraform

```bash
terraform init
```

This command downloads required providers and sets up Terraform.

### 3️⃣ Preview Deployment (Optional)

```bash
terraform plan
```

Shows what Terraform will create.

### 4️⃣ Deploy EC2 Instances

```bash
terraform apply -auto-approve
```

Creates the specified number of EC2 instances.

### 5️⃣ Verify the Deployment

- Go to **AWS Console → EC2 Dashboard**
- You should see the newly created instances.

### 6️⃣ Destroy the Resources (If Needed)

```bash
terraform destroy -auto-approve
```

Removes all created resources.

---

### 🛠️ Next Steps

✅ Add **security groups** for SSH access\
✅ Attach an **SSH key pair** for remote login\
✅ Output **public IPs** of created instances

---

## 🐜 License



---

## 💡 Author

- **Arumulla Yaswanth Reddy**
- GitHub: [https://github.com/arumullayaswanth](https://github.com/arumullayaswanth)

