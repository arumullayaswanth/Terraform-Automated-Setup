# 🌍 Terraform & AWS Infrastructure Documentation Index

Welcome to your **Terraform AWS Setup Guide**! This is your centralized index to all configuration, deployment, and advanced Terraform concepts used in managing AWS infrastructure.

---

## 🔧 Setup & Installation

### 🟢 `install_terraform_aws.sh`
> Shell script to install Terraform and configure it for AWS usage.

### 🔐 `AWS Credentials File.md`
> Guide to securely storing and accessing your AWS credentials.

---

## 🌱 Core Terraform Configuration

### 📄 `ec2_instance.tf`
> Terraform configuration to provision EC2 instances on AWS.

### 🧩 `Terraform Configuration.md`
> Basic structure and syntax for writing Terraform files.

### 🗂️ `Terraform-variables.md`
> Declaring and using input variables for modularity and flexibility.

### 🛠️ `Terraform-CLI.md`
> Essential CLI commands for working with Terraform.

### 📤 `Terraform-outputs.md`
> How to use output values for inter-module communication.

---

## 🚀 Deployment & Lifecycle

### 🔄 `Terraform-Manually.md`
> Steps for manually initializing and applying Terraform configurations.

### ♻️ `Terraform Refresh Guide.md`
> Refreshing the state file to reflect real infrastructure.

### 🔥 `Terraform Taint.md`
> Forcing resource re-creation using `taint`.

### 🧬 `Terraform Lifecycle.md`
> Using the `lifecycle` block to manage resource behavior.

---

## 💡 Advanced Features

### 🧠 `Terraform Locals variables.md`
> Use local variables for cleaner and DRY configurations.

### 🧱 `Terraform Dynamic Block.md`
> Generate complex repeated nested blocks using `dynamic`.

### 🗃️ `Terraform Remote Backend.md`
> Storing state remotely using S3, Terraform Cloud, or other backends.

### 📁 `Terraform Local File.md`
> Working with the `local_file` resource to create files during provisioning.

### 🔐 `Terraform Version Constraints.md`
> Setting compatible Terraform versions for project consistency.

---

## 🧪 Environment & Isolation

### 🧭 `Terraform Workspaces.md`
> Creating isolated environments like dev, staging, and prod.

---

## 🖥️ AWS-Specific Implementations

### 📦 `Terraform Aws Instances.md`
> AWS-focused examples: EC2, VPCs, IAM roles, and more.

---

> 💡 _Tip: Always keep your state file secure and use version control for all Terraform code!_

---

🌐 Built with ❤️ for scalable infrastructure.
