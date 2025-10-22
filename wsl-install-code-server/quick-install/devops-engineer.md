# DevOps Engineer Quick Install

> ⚡ **Cloud-Native** | ⏱️ **40 minutes** | 🔧 **Docker + K8s + AWS + IaC**

## 📋 What Gets Installed

Complete DevOps toolkit:

- ✅ **Essential System Tools** (curl, wget, git, build tools)
- ✅ **Code-Server** (VS Code in browser, port 3000)
- ✅ **Docker + Compose** (Container platform)
- ✅ **Kubernetes Tools** (kubectl, helm, k9s)
- ✅ **AWS CLI + CDK** (Cloud development)
- ✅ **Terraform** (Infrastructure as Code)
- ✅ **CI/CD Tools** (GitHub Actions, Jenkins)

## 🚀 Quick Installation

### Option 1: Complete DevOps Setup

```bash
# Everything for DevOps and cloud development
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/quick-install/devops.sh | bash
```

### Option 2: Modular Installation

```bash
# 1. Foundation (5 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/01-system-setup/essential-tools.md | bash

# 2. Code-Server (10 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/02-code-server/installation.md | bash

# 3. Container Platform (10 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/03-containers/docker.md | bash

# 4. Cloud Tools (15 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/06-cloud-tools/aws-cli.md | bash
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/06-cloud-tools/kubernetes.md | bash
```

## 🛠️ DevOps Stack

### Container & Orchestration
- **Docker 24+** - Container runtime
- **Docker Compose** - Multi-container apps
- **Kubernetes** - Container orchestration
- **Helm 3** - K8s package manager
- **k9s** - Terminal K8s dashboard

### Cloud Platforms
- **AWS CLI v2** - Amazon Web Services
- **AWS CDK** - Infrastructure as Code
- **Terraform** - Multi-cloud IaC
- **kubectl** - Kubernetes CLI

### CI/CD & Monitoring
- **GitHub CLI** - Repository management
- **Jenkins** - Automation server
- **Prometheus** - Monitoring
- **Grafana** - Visualization

## ✅ Quick Start Examples

### 1. Access Development Environment

```bash
# Get WSL IP
ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
```

Open: `http://YOUR_WSL_IP:3000`

### 2. Container Development

```bash
# Multi-tier application stack
mkdir devops-project && cd devops-project

cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  # Application
  app:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
    depends_on:
      - redis
      - postgres

  # Cache Layer
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  # Database
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: appdb
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD: apppass
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  # Monitoring
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3001:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    volumes:
      - grafana_data:/var/lib/grafana

volumes:
  redis_data:
  postgres_data:
  grafana_data:
EOF

# Launch the stack
docker-compose up -d
```

### 3. Kubernetes Deployment

```bash
# Create K8s namespace
kubectl create namespace devops-demo

# Deploy sample application
cat > k8s-deployment.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  namespace: devops-demo
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: web
        image: nginx:alpine
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "64Mi"
            cpu: "50m"
          limits:
            memory: "128Mi"
            cpu: "100m"
---
apiVersion: v1
kind: Service
metadata:
  name: web-app-service
  namespace: devops-demo
spec:
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
  type: LoadBalancer
EOF

kubectl apply -f k8s-deployment.yaml
```

### 4. Infrastructure as Code (Terraform)

```bash
mkdir terraform-demo && cd terraform-demo

cat > main.tf << 'EOF'
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "devops-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "devops-igw"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "devops-public-subnet"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "devops-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
EOF

# Initialize and plan
terraform init
terraform plan
```

### 5. AWS CDK Project

```bash
# Create CDK app
mkdir cdk-demo && cd cdk-demo
npx aws-cdk init app --language typescript

# Install dependencies
npm install @aws-cdk/aws-ec2 @aws-cdk/aws-ecs @aws-cdk/aws-ecs-patterns

# Deploy infrastructure
npm run build
npx cdk deploy
```

## 🔍 Monitoring & Debugging

### Container Debugging
```bash
# Container logs
docker logs <container_name>

# Container shell access
docker exec -it <container_name> /bin/bash

# Resource usage
docker stats

# System events
docker events
```

### Kubernetes Debugging
```bash
# Pod inspection
kubectl describe pod <pod_name> -n devops-demo

# Logs
kubectl logs <pod_name> -n devops-demo

# Interactive debugging
kubectl exec -it <pod_name> -n devops-demo -- /bin/bash

# Port forwarding
kubectl port-forward service/web-app-service 8080:80 -n devops-demo
```

## 📊 Resource Requirements

| Tool | RAM | CPU | Disk | Purpose |
|------|-----|-----|------|---------|
| Docker | 500MB | Med | 2GB | Containers |
| K8s Tools | 100MB | Low | 500MB | Orchestration |
| AWS CLI | 50MB | Low | 200MB | Cloud API |
| Terraform | 100MB | Low | 300MB | IaC |
| **Total** | **~750MB** | **Medium** | **~3GB** | |

## 🧪 Verification

```bash
# Run complete DevOps verification
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/08-troubleshooting/devops-verification.md | bash
```

## 🎯 DevOps Workflows

1. **Local Development**: Docker Compose stacks
2. **CI/CD Pipelines**: GitHub Actions + Jenkins
3. **Infrastructure**: Terraform + AWS CDK
4. **Deployment**: Kubernetes + Helm
5. **Monitoring**: Prometheus + Grafana

## 🔗 Additional Tools

Extend your DevOps toolkit:

- **[Database Tools](../07-development-tools/database-tools.md)** - Database management
- **[API Testing](../07-development-tools/api-testing.md)** - Service testing
- **[Security Tools](../07-development-tools/security-tools.md)** - Security scanning
- **[Backup Tools](../07-development-tools/backup-tools.md)** - Data protection

---

**🎉 DevOps development environment ready in 40 minutes!**

> Perfect for: Infrastructure automation, CI/CD pipelines, cloud deployments, microservices