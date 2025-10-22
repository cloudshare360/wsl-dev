# Code-Server Installation

> 🖥️ **Browser-based VS Code** | ⏱️ **10 minutes** | 🌐 **Port 3000, No Password**

## 📋 Overview

Code-server allows you to run VS Code in your browser from any device. This installation configures it for optimal use on WSL2 with network access and password-free authentication.

## 🎯 What You'll Get

- **Browser-based VS Code** accessible via web interface
- **Network access** from any device on your LAN  
- **Port 3000** configuration for easy access
- **Password-free authentication** for streamlined workflow
- **All VS Code features** including extensions, terminal, and debugging

---

## 📋 Prerequisites

Before starting, ensure you have:
- ✅ [Essential Tools](../01-system-setup/essential-tools.md) installed
- ✅ Internet connectivity
- ✅ WSL2 running

---

## 🚀 Installation Steps

### Step 1: Download and Install Code-Server

```bash
# Download and install code-server using the official script
curl -fsSL https://code-server.dev/install.sh | sh

# Verify installation
code-server --version
```

### Step 2: Enable Code-Server Service

```bash
# Enable code-server to start automatically
sudo systemctl enable --now code-server@$USER

# Check service status
sudo systemctl status code-server@$USER
```

The service should show as "active (running)".

### Step 3: Stop Service for Configuration

```bash
# Stop code-server to modify configuration
sudo systemctl stop code-server@$USER
```

---

## 🔧 Configuration

### Create Configuration Directory

```bash
# Create configuration directory if it doesn't exist
mkdir -p ~/.config/code-server
```

### Configure Code-Server Settings

```bash
# Create configuration file with optimal settings
cat > ~/.config/code-server/config.yaml << EOF
bind-addr: 0.0.0.0:3000
auth: none
password: 
cert: false
EOF
```

**Configuration Explanation:**
- `bind-addr: 0.0.0.0:3000` - Listen on all network interfaces, port 3000
- `auth: none` - Disable password authentication  
- `cert: false` - Use HTTP instead of HTTPS (simpler for local development)

### Start Code-Server with New Configuration

```bash
# Start code-server with new configuration
sudo systemctl start code-server@$USER

# Verify it's running
sudo systemctl status code-server@$USER
```

---

## 🌐 Network Access Setup

### Get Your WSL IP Address

```bash
# Get WSL IP address for browser access
WSL_IP=$(ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
echo "Code-server access URL: http://$WSL_IP:3000"
```

### Test Local Access

```bash
# Test local access (should return HTML)
curl -s http://localhost:3000 | head -5
```

### Configure Windows Firewall (If Needed)

If you want to access code-server from other devices on your network, run this in **Windows PowerShell as Administrator**:

```powershell
# Allow code-server through Windows Firewall
New-NetFirewallRule -DisplayName "WSL Code-Server" -Direction Inbound -Protocol TCP -LocalPort 3000 -Action Allow
```

---

## ✅ Verification

### Check Service Status

```bash
# Verify code-server is running
sudo systemctl is-active code-server@$USER

# Check if port 3000 is listening
ss -tlnp | grep :3000
```

### Access Code-Server

1. **Get your WSL IP address:**
   ```bash
   ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
   ```

2. **Open in browser:**
   - Local access: `http://localhost:3000`
   - Network access: `http://YOUR_WSL_IP:3000`

3. **You should see VS Code interface in your browser**

---

## 🎨 Initial Setup (Optional)

### Install Popular Extensions

Once code-server is running, you can install extensions via the web interface or command line:

```bash
# Install popular extensions (optional)
code-server --install-extension ms-python.python
code-server --install-extension ms-vscode.vscode-typescript-next
code-server --install-extension esbenp.prettier-vscode
code-server --install-extension ms-vscode.vscode-json
```

### Set Default Workspace

```bash
# Create a default workspace directory
mkdir -p ~/workspace
cd ~/workspace

# Create a sample project
echo '# Welcome to Code-Server' > README.md
echo 'console.log("Hello from Code-Server!");' > hello.js
```

---

## 🔄 Service Management

### Common Service Commands

```bash
# Start code-server
sudo systemctl start code-server@$USER

# Stop code-server
sudo systemctl stop code-server@$USER

# Restart code-server
sudo systemctl restart code-server@$USER

# Check status
sudo systemctl status code-server@$USER

# View logs
sudo journalctl -u code-server@$USER -f
```

### Auto-start Configuration

Code-server is already configured to start automatically when WSL starts. To disable auto-start:

```bash
# Disable auto-start
sudo systemctl disable code-server@$USER

# Re-enable auto-start
sudo systemctl enable code-server@$USER
```

---

## 🚨 Troubleshooting

### Code-Server Won't Start

```bash
# Check service status and logs
sudo systemctl status code-server@$USER
sudo journalctl -u code-server@$USER -n 20

# Check configuration file
cat ~/.config/code-server/config.yaml

# Restart the service
sudo systemctl restart code-server@$USER
```

### Cannot Access from Browser

```bash
# Verify service is listening on correct port
ss -tlnp | grep :3000

# Test local access
curl -s http://localhost:3000

# Check WSL IP address
ip addr show eth0 | grep "inet "
```

### Permission Issues

```bash
# Check file permissions
ls -la ~/.config/code-server/

# Fix permissions if needed
chmod 600 ~/.config/code-server/config.yaml
```

---

## 🔗 Next Steps

Now that code-server is running, you can:

1. **[Install Programming Languages](../04-programming-languages/)** - Choose your development stack
2. **[Setup Containers](../03-containers/docker.md)** - For containerized development (optional)
3. **[Install Development Tools](../07-development-tools/)** - Add additional tools as needed

---

**🎉 Code-server is ready!**

> 🌐 **Access your development environment:** `http://YOUR_WSL_IP:3000`  
> 💡 **Bookmark this URL** for quick access from any device on your network