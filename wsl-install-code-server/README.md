# � WSL Code-Server Installation Guide

> 🌐 **Browser-based VS Code** | 🚀 **Modular Installation** | ⚡ **Production Ready**

Transform your WSL environment into a powerful, browser-accessible development workspace. Choose what you need, install only what you want.

## 🎯 Quick Install Paths

### 🚀 **One-Click Setups** (Recommended)

| **Development Path** | **Time** | **What's Included** | **Perfect For** |
|---------------------|----------|-------------------|-----------------|
| **[💻 Web Developer](quick-install/web-developer.md)** | 30 min | Code-Server + Node.js + React + TypeScript | Frontend developers, React apps, modern web development |
| **[� Full Stack](quick-install/fullstack-developer.md)** | 45 min | Frontend + Backend + Database + Docker | Complete web applications, startup MVPs, full-stack projects |
| **[⚡ DevOps Engineer](quick-install/devops-engineer.md)** | 40 min | Docker + K8s + AWS + Infrastructure tools | Cloud deployment, container orchestration, CI/CD |
| **[🧪 Data Scientist](quick-install/data-scientist.md)** | 35 min | Python + ML/AI + Jupyter + Big Data tools | Machine learning, data analysis, research projects |

### � **Custom Modular Installation**

Build your environment step-by-step:

| **Category** | **Time** | **Components** | **Dependencies** |
|--------------|----------|----------------|------------------|
| **[01-System Setup](01-system-setup/)** | 5 min | Essential tools, build dependencies | None (start here) |
| **[02-Code Server](02-code-server/)** | 10 min | VS Code in browser, port 3000 setup | System Setup |
| **[03-Containers](03-containers/)** | 10 min | Docker, Docker Compose, user permissions | System Setup |
| **[04-Programming Languages](04-programming-languages/)** | 15 min | Python, Node.js, version managers | System Setup |
| **[05-Frontend Frameworks](05-frontend-frameworks/)** | 10 min | React, Angular, Vue, Next.js | Node.js |
| **[06-Cloud Tools](06-cloud-tools/)** | 15 min | AWS CLI, Kubernetes, Terraform | System Setup |
| **[07-Development Tools](07-development-tools/)** | 10 min | Database clients, API testing, utilities | Various |
| **[08-Troubleshooting](08-troubleshooting/)** | N/A | Common issues, debugging, verification | N/A |

## ⚡ Quick Start Commands

### Option 1: One-Command Install (Popular Paths)

```bash
# Web Developer (React + TypeScript + Code-Server)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/quick-install/web-developer.sh | bash

# Full Stack Developer (Complete environment)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/quick-install/fullstack-developer.sh | bash

# DevOps Engineer (Cloud + Container tools)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/quick-install/devops-engineer.sh | bash

# Data Scientist (Python + ML + Jupyter)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/quick-install/data-scientist.sh | bash
```

### 💻 **Programming Languages** (Choose What You Need)

#### [04 - Programming Languages](./04-programming-languages/)
Individual programming language environments.

| Language | Description | Includes | Time |
|----------|-------------|----------|------|
| [Python](./04-programming-languages/python.md) | Python 3, pip, pipenv, common packages | Flask, Django, FastAPI, Jupyter | 15 min |
| [Node.js](./04-programming-languages/nodejs.md) | Node.js via NVM, npm, common tools | TypeScript, ESLint, Prettier | 10 min |
| [Java](./04-programming-languages/java.md) | Java via SDKMAN!, Maven, Gradle | Spring Boot, development tools | 15 min |

### 🎨 **Frontend Frameworks** (Choose What You Need)

#### [05 - Frontend Frameworks](./05-frontend-frameworks/)
Modern web development frameworks.

| Framework | Description | Prerequisites | Time |
|-----------|-------------|---------------|------|
| [Angular](./05-frontend-frameworks/angular.md) | Angular CLI and tools | Node.js | 5 min |
| [React](./05-frontend-frameworks/react.md) | Create React App and tools | Node.js | 5 min |
| [Next.js](./05-frontend-frameworks/nextjs.md) | Next.js framework | Node.js | 5 min |

### ☁️ **Cloud & DevOps Tools** (Optional)

#### [06 - Cloud Tools](./06-cloud-tools/)
Cloud development and deployment tools.

| Tool | Description | Use Case | Time |
|------|-------------|----------|------|
| [AWS CLI](./06-cloud-tools/aws-cli.md) | AWS command line interface | AWS development | 5 min |
| [AWS CDK](./06-cloud-tools/aws-cdk.md) | AWS Cloud Development Kit | Infrastructure as Code | 5 min |
| [EKS Tools](./06-cloud-tools/eks-tools.md) | Amazon EKS utilities | Kubernetes on AWS | 10 min |

### 🛠️ **Development Tools** (Optional)

#### [07 - Development Tools](./07-development-tools/)
Additional development and testing tools.

| Tool | Description | Use Case | Time |
|------|-------------|----------|------|
| [API Testing](./07-development-tools/api-testing.md) | Postman installation | API development/testing | 5 min |
| [Database Tools](./07-development-tools/database-tools.md) | Database clients (PostgreSQL, MySQL, MongoDB) | Database development | 10 min |
| [Text Editors](./07-development-tools/text-editors.md) | Additional editors (vim, emacs) | Terminal-based editing | 5 min |

### 🚨 **Support** (When Needed)

#### [08 - Troubleshooting](./08-troubleshooting/)
Problem resolution and verification tools.

| Component | Description | When to Use |
|-----------|-------------|-------------|
| [Common Issues](./08-troubleshooting/common-issues.md) | Frequent problems and solutions | When things don't work |
| [Environment Verification](./08-troubleshooting/verification.md) | Check installation status | Verify setup completion |
| [Network Access](./08-troubleshooting/network-access.md) | LAN connectivity issues | Remote access problems |

## 🎯 **Recommended Installation Paths**

### 🏃 **Minimal Path** (15 minutes)
Perfect for basic web development:
```bash
# 1. Essential system tools
./01-system-setup/essential-tools.md

# 2. Code-server setup  
./02-code-server/installation.md
./02-code-server/configuration.md
```

### 💻 **Web Developer Path** (30 minutes)
For frontend web development:
```bash
# Core components
./01-system-setup/essential-tools.md
./02-code-server/installation.md

# Choose one programming language
./04-programming-languages/nodejs.md

# Choose your frontend framework
./05-frontend-frameworks/react.md  # or angular.md or nextjs.md
```

### 🚀 **Full Stack Developer Path** (60 minutes)
For complete web application development:
```bash
# Core components
./01-system-setup/essential-tools.md
./02-code-server/installation.md

# Containers
./03-containers/docker.md
./03-containers/portainer.md

# Programming languages
./04-programming-languages/nodejs.md
./04-programming-languages/python.md

# Frontend framework
./05-frontend-frameworks/react.md

# Development tools
./07-development-tools/api-testing.md
./07-development-tools/database-tools.md
```

### ☁️ **Cloud Developer Path** (90 minutes)
For cloud-native development:
```bash
# Core components
./01-system-setup/essential-tools.md
./02-code-server/installation.md

# Full container stack
./03-containers/docker.md
./03-containers/portainer.md
./03-containers/kubernetes.md

# Programming languages
./04-programming-languages/nodejs.md
./04-programming-languages/python.md

# Cloud tools
./06-cloud-tools/aws-cli.md
./06-cloud-tools/aws-cdk.md
./06-cloud-tools/eks-tools.md

# Development tools
./07-development-tools/api-testing.md
```

## 🔗 **Quick Access Links**

### 📦 **Most Popular Combinations**
- **[Web Developer Essentials](./quick-install/web-developer.md)** - Node.js + React + Essential tools
- **[Python Developer](./quick-install/python-developer.md)** - Python + Data science tools
- **[DevOps Engineer](./quick-install/devops-engineer.md)** - Docker + Kubernetes + AWS tools
- **[Full Stack](./quick-install/full-stack.md)** - Everything for complete development

### 🆘 **Need Help?**
- **[FAQ](./08-troubleshooting/faq.md)** - Frequently asked questions
- **[Common Issues](./08-troubleshooting/common-issues.md)** - Problem resolution
- **[System Requirements](./01-system-setup/prerequisites.md)** - Check compatibility

---

## 🚀 **Getting Started**

1. **📋 Check Prerequisites** - Start with [System Requirements](./01-system-setup/prerequisites.md)
2. **🛠️ Install Essential Tools** - Continue with [Essential Tools](./01-system-setup/essential-tools.md)  
3. **🖥️ Setup Code-Server** - Install [Code-Server](./02-code-server/installation.md)
4. **🎯 Choose Your Path** - Select components based on your development needs
5. **✅ Verify Installation** - Run [Environment Verification](./08-troubleshooting/verification.md)

---

**💡 Pro Tip:** Start with the minimal path and add components as needed. Each component is independent and can be installed later.

> 🌐 **Access your development environment at:** `http://YOUR_WSL_IP:3000`