# AWS Configuration and Credential Management

## 📌 Listing and Managing AWS Configuration Files

### 🔍 List All Files (Including Hidden Ones)
```bash
ls -la  
```

### 📂 List AWS Configuration Files
```bash
ls -la .aws/ 
```

### ✏️ Edit AWS Credentials File
```bash
vim .aws/credentials
```

### ✏️ Edit AWS Config File
```bash
vim .aws/config  
```

---

## 🗂 AWS Credentials File Example (`~/.aws/credentials`)

```ini
[default]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
```

---

## 🗂 AWS Config File Example (`~/.aws/config`)

```ini
[default]
region = us-east-1
output = table
```

---

## 🚀 Quick AWS Configuration Commands

```bash
aws configure  # Set up AWS credentials interactively
aws configure list  # Display stored AWS credentials
aws sts get-caller-identity  # Verify AWS identity
```

✅ **Now your AWS CLI is set up and ready to use!**  
