# Docker Installation

> 🐳 **Container Platform** | ⏱️ **10 minutes** | 🔧 **Foundation for Container Development**

## 📋 Overview

Docker provides containerization capabilities for your development environment. This allows you to run applications in isolated environments, making development more consistent and deployment easier.

## 🎯 What You'll Get

- **Docker Engine** - Container runtime
- **Docker Compose** - Multi-container application management
- **User permissions** - Run Docker without sudo
- **Auto-start service** - Docker starts with WSL

---

## 📋 Prerequisites

Before starting, ensure you have:
- ✅ [Essential Tools](../01-system-setup/essential-tools.md) installed
- ✅ Internet connectivity
- ✅ WSL2 running with systemd enabled (recommended)

---

## 🚀 Installation Steps

### Step 1: Add Docker Repository

```bash
# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository to package sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index
sudo apt update
```

### Step 2: Install Docker Engine

```bash
# Install Docker Engine, CLI, and containerd
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Verify Docker installation
docker --version
```

### Step 3: Configure User Permissions

```bash
# Add current user to docker group (allows running Docker without sudo)
sudo usermod -aG docker $USER

# Apply group membership (logout/login alternative)
newgrp docker

# Verify you can run Docker without sudo
docker run hello-world
```

### Step 4: Install Docker Compose

```bash
# Download Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Make it executable
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker Compose installation
docker-compose --version
```

### Step 5: Enable Docker Service

```bash
# Enable Docker to start automatically
sudo systemctl enable docker

# Start Docker service
sudo systemctl start docker

# Verify service is running
sudo systemctl status docker
```

---

## ✅ Verification

### Test Docker Installation

```bash
# Test Docker with hello-world container
docker run hello-world

# Check Docker system information
docker system info

# List Docker images
docker images

# List running containers
docker ps
```

### Test Docker Compose

```bash
# Check Docker Compose version
docker-compose --version

# Test with a simple compose file
mkdir -p ~/docker-test
cd ~/docker-test

# Create a simple docker-compose.yml
cat > docker-compose.yml << EOF
version: '3.8'
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    command: echo "Docker Compose is working!"
EOF

# Test the compose file (this will just validate, not run)
docker-compose config
```

---

## 🔧 Configuration & Optimization

### Configure Docker Daemon (Optional)

Create Docker daemon configuration for better performance:

```bash
# Create Docker daemon configuration directory
sudo mkdir -p /etc/docker

# Create daemon configuration file
sudo tee /etc/docker/daemon.json > /dev/null << EOF
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "dns": ["8.8.8.8", "8.8.4.4"]
}
EOF

# Restart Docker to apply configuration
sudo systemctl restart docker
```

### Set Docker Resource Limits (Optional)

Create `.wslconfig` file in Windows to limit Docker resource usage:

```bash
# Display WSL configuration instructions
echo "To limit Docker resource usage, create C:\Users\$USER\.wslconfig with:"
echo ""
echo "[wsl2]"
echo "memory=4GB"
echo "processors=2"
echo "swap=2GB"
echo ""
echo "Then restart WSL with: wsl --shutdown"
```

---

## 🎯 Common Docker Commands

### Container Management

```bash
# List all containers (running and stopped)
docker ps -a

# Stop a container
docker stop <container_name_or_id>

# Remove a container
docker rm <container_name_or_id>

# Remove all stopped containers
docker container prune
```

### Image Management

```bash
# List all images
docker images

# Remove an image
docker rmi <image_name_or_id>

# Remove unused images
docker image prune

# Pull an image from Docker Hub
docker pull <image_name>
```

### System Cleanup

```bash
# Remove all unused containers, networks, images, and build cache
docker system prune -a

# Check Docker disk usage
docker system df
```

---

## 🚨 Troubleshooting

### Docker Service Won't Start

```bash
# Check Docker service status
sudo systemctl status docker

# Check Docker service logs
sudo journalctl -u docker -n 20

# Restart Docker service
sudo systemctl restart docker
```

### Permission Denied Errors

```bash
# Verify user is in docker group
groups $USER

# If not in docker group, add user
sudo usermod -aG docker $USER

# Log out and log back in, or run:
newgrp docker
```

### Docker Daemon Not Running

```bash
# Start Docker daemon manually
sudo dockerd

# Or start Docker service
sudo systemctl start docker

# Check if Docker socket exists
ls -la /var/run/docker.sock
```

### WSL2 Integration Issues

```bash
# Check WSL version
wsl --version

# Ensure WSL2 backend is being used
wsl --list --verbose

# Restart WSL if needed (run in Windows PowerShell)
# wsl --shutdown
```

---

## 🎨 Sample Projects

### Quick Test Container

```bash
# Run a simple web server
docker run -d -p 8080:80 --name test-nginx nginx:alpine

# Access it via browser: http://localhost:8080

# Stop and remove
docker stop test-nginx
docker rm test-nginx
```

### Development Database

```bash
# Run PostgreSQL for development
docker run -d \
  --name dev-postgres \
  -e POSTGRES_PASSWORD=devpassword \
  -e POSTGRES_DB=devdb \
  -p 5432:5432 \
  postgres:13-alpine

# Connect to database: localhost:5432
# Username: postgres, Password: devpassword, Database: devdb
```

---

## 🔗 Next Steps

Now that Docker is installed, you can:

1. **[Install Portainer](./portainer.md)** - Web UI for Docker management
2. **[Setup Kubernetes](./kubernetes.md)** - Container orchestration tools
3. **[Programming Languages](../04-programming-languages/)** - Add development environments
4. **[Development Tools](../07-development-tools/)** - Additional development utilities

---

**🐳 Docker is ready for containerized development!**

> 💡 **Next recommended:** Install [Portainer](./portainer.md) for a web-based Docker management interface