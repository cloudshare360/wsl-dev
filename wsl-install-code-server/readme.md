# 🖥️ WSL Code-Server Complete Development Environment

> 🌐 **Access VS Code in Browser** | 🔧 **Full Development Stack** | 🐳 **Containerized Development**

## 📋 Overview

This guide provides step-by-step instructions to install and configure **code-server** (VS Code in the browser) on WSL with a complete development environment. Access your development environment from any device via web browser or local area network.

## 🎯 What You'll Get

### 🚀 **Code-Server Features**
- **Browser-based VS Code** accessible via web interface
- **Network access** from any device on your LAN
- **Port 3000** configuration for easy access
- **Password-free authentication** for streamlined workflow

### 🛠️ **Complete Development Stack**
- **Programming Languages:** Python3, Node.js, Java
- **Package Managers:** pip3, pipenv, npm, nvm, SDKMAN!
- **Frontend Frameworks:** Angular, React, Next.js
- **Build Tools:** Maven, curl, common network utilities
- **API Testing:** Postman

### 🐳 **Container & Cloud Tools**
- **Containerization:** Docker, Docker Compose
- **Container Management:** Portainer
- **Orchestration:** Kubernetes tools
- **AWS Services:** AWS CLI, AWS CDK, EKS tools

---

## 📋 Prerequisites

### System Requirements
- **WSL2** installed and configured
- **Ubuntu 20.04+** or compatible Linux distribution
- **4GB+ RAM** recommended for full development stack
- **10GB+ free disk space** for all tools and dependencies

### Network Access Requirements
- **Local network access** for browser-based development
- **Internet connection** for package installations
- **Firewall configuration** may be needed for LAN access

---

## 🚀 Installation Process

### Step 1: Essential System Tools and Dependencies

```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Install essential system tools and network utilities
sudo apt install -y \
    curl \
    wget \
    zip \
    unzip \
    git \
    net-tools \
    iputils-ping \
    traceroute \
    nmap \
    telnet \
    netcat-openbsd \
    dnsutils \
    htop \
    tree \
    vim \
    nano

# Install build tools and development dependencies
sudo apt install -y \
    build-essential \
    make \
    gcc \
    g++ \
    libc6-dev \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# Install Docker dependencies
sudo apt install -y \
    iptables \
    supervisor \
    systemctl
```

### Step 2: Install Docker and Docker Compose

```bash
# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index
sudo apt update

# Install Docker Engine
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add user to docker group
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker installation
docker --version
docker-compose --version
```

### Step 3: Install Code-Server

```bash
# Download and install code-server
curl -fsSL https://code-server.dev/install.sh | sh

# Enable and start code-server service
sudo systemctl enable --now code-server@$USER

# Check service status
sudo systemctl status code-server@$USER
```

### Step 4: Configure Code-Server

```bash
# Stop code-server to modify configuration
sudo systemctl stop code-server@$USER

# Create/edit configuration file
mkdir -p ~/.config/code-server
cat > ~/.config/code-server/config.yaml << EOF
bind-addr: 0.0.0.0:3000
auth: none
password: 
cert: false
EOF

# Start code-server with new configuration
sudo systemctl start code-server@$USER
```

---

## 🐍 Step 5: Python Development Environment

### Install Python and Package Managers

```bash
# Install Python 3 and pip
sudo apt install -y python3 python3-pip python3-venv python3-dev

# Install pipenv for virtual environment management
pip3 install --user pipenv

# Add pip user binaries to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Verify installations
python3 --version
pip3 --version
pipenv --version
```

### Essential Python Packages

```bash
# Install common development packages
pip3 install --user \
    jupyter \
    flask \
    django \
    fastapi \
    uvicorn \
    requests \
    pandas \
    numpy \
    matplotlib \
    seaborn \
    pytest \
    black \
    flake8
```

---

## 🟨 Step 6: Node.js Development Environment

### Install Node.js via NVM

```bash
# Install NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Reload shell configuration
source ~/.bashrc

# Install latest LTS Node.js
nvm install --lts
nvm use --lts
nvm alias default lts/*

# Verify installations
node --version
npm --version
```

### Frontend Framework Installation

```bash
# Install Angular CLI
npm install -g @angular/cli

# Install Create React App
npm install -g create-react-app

# Install Next.js CLI
npm install -g create-next-app

# Install common development tools
npm install -g \
    typescript \
    eslint \
    prettier \
    nodemon \
    pm2 \
    serve \
    http-server
```

---

## ☕ Step 7: Java Development Environment

### Install Java via SDKMAN!

```bash
# Install SDKMAN!
curl -s "https://get.sdkman.io" | bash

# Reload shell configuration
source ~/.bashrc

# Install Java (latest LTS)
sdk install java

# Install Maven
sdk install maven

# Verify installations
java --version
mvn --version
```

### Additional Java Tools

```bash
# Install Gradle
sdk install gradle

# Install Spring Boot CLI
sdk install springboot

# List available Java versions
sdk list java
```

---

## 🐳 Step 8: Container Management Tools

### Install Portainer

```bash
# Create Portainer volume
docker volume create portainer_data

# Run Portainer container
docker run -d \
    -p 9000:9000 \
    -p 9443:9443 \
    --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
```

---

## ⚙️ Step 9: Kubernetes Tools

### Install kubectl

```bash
# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify installation
kubectl version --client
```

### Install Helm

```bash
# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Verify installation
helm version
```

### Install k9s (Kubernetes CLI UI)

```bash
# Install k9s
curl -sS https://webinstall.dev/k9s | bash

# Add to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

---

## ☁️ Step 10: AWS Development Tools

### Install AWS CLI

```bash
# Download AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip

# Install AWS CLI
sudo ./aws/install

# Verify installation
aws --version

# Clean up
rm -rf aws awscliv2.zip
```

### Install AWS CDK

```bash
# Install AWS CDK
npm install -g aws-cdk

# Verify installation
cdk --version
```

### Install EKS Tools

```bash
# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Install AWS IAM Authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
sudo mv ./aws-iam-authenticator /usr/local/bin

# Verify installations
eksctl version
aws-iam-authenticator version
```

---

## 🛠️ Step 11: Additional Development Tools

### Install Postman

```bash
# Download and install Postman
wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz
tar -xzf postman-linux-x64.tar.gz
sudo mv Postman /opt/postman
sudo ln -s /opt/postman/Postman /usr/local/bin/postman

# Clean up
rm postman-linux-x64.tar.gz
```

### Install Database Tools

```bash
# Install PostgreSQL client
sudo apt install -y postgresql-client

# Install MySQL client
sudo apt install -y mysql-client

# Install Redis CLI
sudo apt install -y redis-tools

# Install MongoDB tools
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update
sudo apt install -y mongodb-mongosh
```

### Install Text Editors and IDEs

```bash
# Install nano and vim
sudo apt install -y nano vim

# Install emacs
sudo apt install -y emacs

# Install VS Code extensions via CLI (optional)
# code-server --install-extension ms-python.python
# code-server --install-extension ms-vscode.vscode-typescript-next
```

---

## 🌐 Network Access Configuration

### Configure Code-Server for LAN Access

```bash
# Get WSL IP address
ip addr show eth0 | grep inet

# Configure Windows Firewall (run in Windows PowerShell as Administrator)
# New-NetFirewallRule -DisplayName "WSL Code-Server" -Direction Inbound -Protocol TCP -LocalPort 3000 -Action Allow
```

### Access URLs

```bash
# Local access
echo "Local access: http://localhost:3000"

# LAN access (replace with your WSL IP)
WSL_IP=$(ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
echo "LAN access: http://$WSL_IP:3000"

# Portainer access
echo "Portainer: http://$WSL_IP:9000"
```

---

## 🔧 Step 12: Environment Verification

### Create Verification Script

```bash
# Create verification script
cat > ~/verify-environment.sh << 'EOF'
#!/bin/bash

echo "🔍 Development Environment Verification"
echo "======================================"

# System info
echo "📊 System Information:"
echo "OS: $(lsb_release -d | cut -f2)"
echo "Kernel: $(uname -r)"
echo ""

# Code-server
echo "🖥️  Code-Server:"
if systemctl is-active --quiet code-server@$USER; then
    echo "✅ Code-server is running"
    WSL_IP=$(ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
    echo "🌐 Access URL: http://$WSL_IP:3000"
else
    echo "❌ Code-server is not running"
fi
echo ""

# Programming languages
echo "💻 Programming Languages:"
echo "Python: $(python3 --version 2>/dev/null || echo 'Not installed')"
echo "Node.js: $(node --version 2>/dev/null || echo 'Not installed')"
echo "Java: $(java --version 2>/dev/null | head -1 || echo 'Not installed')"
echo ""

# Package managers
echo "📦 Package Managers:"
echo "pip3: $(pip3 --version 2>/dev/null || echo 'Not installed')"
echo "npm: $(npm --version 2>/dev/null || echo 'Not installed')"
echo "Maven: $(mvn --version 2>/dev/null | head -1 || echo 'Not installed')"
echo ""

# Container tools
echo "🐳 Container Tools:"
echo "Docker: $(docker --version 2>/dev/null || echo 'Not installed')"
echo "Docker Compose: $(docker-compose --version 2>/dev/null || echo 'Not installed')"
echo "kubectl: $(kubectl version --client --short 2>/dev/null || echo 'Not installed')"
echo ""

# AWS tools
echo "☁️  AWS Tools:"
echo "AWS CLI: $(aws --version 2>/dev/null || echo 'Not installed')"
echo "CDK: $(cdk --version 2>/dev/null || echo 'Not installed')"
echo "eksctl: $(eksctl version 2>/dev/null || echo 'Not installed')"
echo ""

# Services status
echo "🔄 Services Status:"
echo "Code-server: $(systemctl is-active code-server@$USER 2>/dev/null || echo 'inactive')"
echo "Docker: $(systemctl is-active docker 2>/dev/null || echo 'inactive')"

EOF

# Make script executable
chmod +x ~/verify-environment.sh

# Run verification
~/verify-environment.sh
```

---

## 🚨 Troubleshooting

### Common Issues and Solutions

#### Code-Server Won't Start
```bash
# Check service status
sudo systemctl status code-server@$USER

# Check logs
sudo journalctl -u code-server@$USER -f

# Restart service
sudo systemctl restart code-server@$USER
```

#### Cannot Access from LAN
```bash
# Check if service is listening on all interfaces
ss -tlnp | grep :3000

# Configure Windows Firewall
# Run in Windows PowerShell as Administrator:
# New-NetFirewallRule -DisplayName "WSL Code-Server" -Direction Inbound -Protocol TCP -LocalPort 3000 -Action Allow
```

#### Docker Permission Issues
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Logout and login again, or run:
newgrp docker
```

---

## 📚 Quick Reference Commands

### Start/Stop Services
```bash
# Code-server
sudo systemctl start code-server@$USER
sudo systemctl stop code-server@$USER
sudo systemctl restart code-server@$USER

# Docker
sudo systemctl start docker
sudo systemctl stop docker
```

### Development Commands
```bash
# Python virtual environment
python3 -m venv myproject
source myproject/bin/activate

# Node.js project initialization
npm init -y
npm install express

# Docker commands
docker ps
docker images
docker-compose up -d
```

### Access URLs
```bash
# Get current WSL IP
ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1

# Common service URLs
# Code-server: http://YOUR_WSL_IP:3000
# Portainer: http://YOUR_WSL_IP:9000
```

---

## 🎯 Next Steps

1. **🖥️ Access Code-Server** - Open browser to `http://YOUR_WSL_IP:3000`
2. **🔧 Install Extensions** - Add your favorite VS Code extensions
3. **📁 Create Projects** - Start developing with your preferred frameworks
4. **🐳 Use Containers** - Leverage Docker for isolated development environments
5. **☁️ Deploy to Cloud** - Use AWS tools for cloud deployment

---

**🎉 Your complete WSL development environment is ready!**

> 💡 **Tip:** Bookmark the code-server URL and consider setting up SSH keys for seamless development workflow.