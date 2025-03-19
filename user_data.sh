#!/bin/bash

# Install Java 17
apt update
apt install -y openjdk-17-jdk
update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java

# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

apt update
apt install -y jenkins

# Install Nginx and Certbot
apt install -y nginx python3-certbot-nginx

# Configure Nginx for Jenkins reverse proxy (HTTP only for Certbot setup)
cat <<EOF > /etc/nginx/sites-available/jenkins
server {
    listen 80;
    server_name jenkinsaws.1ms.my;

    location / {
        proxy_pass http://localhost:8080/;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_buffering off;
        proxy_request_buffering off;
    }
}
EOF

# Enable site and restart Nginx
ln -sf /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/default
nginx -t
systemctl restart nginx

# Obtain SSL certificate using Certbot
certbot --nginx -d jenkinsaws.1ms.my --non-interactive --agree-tos -m your-email@example.com

# Restart Nginx with SSL config
systemctl restart nginx

# Start Jenkins
systemctl enable jenkins
systemctl restart jenkins

# Confirm completion
echo "User data script completed at $(date)" >> /var/log/user_data.log