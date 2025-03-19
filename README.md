# 🚀 Jenkins Infrastructure with Terraform (AWS)

## Overview

This Terraform project **automatically provisions Jenkins** on an **EC2 instance** in AWS, accessible securely via a domain name with **HTTPS**. It includes networking setup, instance provisioning, and Jenkins installation with **Nginx as a reverse proxy**.

## Key Features

- Creates:
  - **VPC** with public/private subnets, IGW, NAT Gateway, and route tables
  - **EC2 instance**
  - **Security Groups** for SSH and Jenkins access
- **Installs Jenkins automatically** using `user_data` (with Java 17 and Nginx)
- Sets up **SSL (HTTPS)** using **Let's Encrypt Certbot**
- Configures **Nginx** to reverse proxy Jenkins
- Deploys Jenkins at:  
  🔗 **https://jenkinsaws.1ms.my**

## ⚠️ Important Notes

This project **does not use AWS Route 53**.  
DNS management is handled **externally via Dynadot**.

## Usage

```bash
terraform init
terraform apply
```

After `terraform apply`, Jenkins will be available at Elastic IP and will be needed to connect in Route 53
🔗 **https://jenkinsaws.1ms.my**

## Cleanup

To destroy all created resources:
```bash
terraform destroy
```

