#!/bin/bash

# Install Java 17
apt update
apt install -y openjdk-17-jdk
update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java

# Install Jenkins (verified)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

apt update
apt install -y jenkins

# Install Nginx
apt install -y nginx

# Configure Nginx as reverse proxy for Jenkins
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
ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx

# Start Jenkins
systemctl enable jenkins
systemctl restart jenkins

# Install Certbot and get SSL certificate
apt install -y certbot python3-certbot-nginx

certbot --nginx --non-interactive --agree-tos --redirect \
  -m a.shemtov@itoutposts.com -d jenkinsaws.1ms.my

# Confirm completion
echo "User data script completed at $(date)" >> /var/log/user_data.log