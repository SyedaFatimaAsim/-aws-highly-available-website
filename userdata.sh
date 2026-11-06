#!/bin/bash
dnf install -y httpd
systemctl enable --now httpd
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 300")
AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" "http://169.254.169.254/latest/meta-data/placement/availability-zone")
cat > /var/www/html/index.html <<EOF
<html><head><title>Fatima Asim - Cloud Engineer</title></head>
<body style="font-family:Arial;text-align:center;padding:40px">
  <h1>Fatima Asim</h1>
  <h2>Cloud Engineer in training</h2>
  <p>Skills: AWS EC2, VPC, Load Balancing, Auto Scaling, Linux</p>
  <p>GitHub: github.com/SyedaFatimaAsim</p>
  <hr><p>Served by <b>$(hostname -f)</b> in zone <b>$AZ</b></p>
</body></html>
EOF