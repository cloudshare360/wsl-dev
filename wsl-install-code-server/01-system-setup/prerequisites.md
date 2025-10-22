# Prerequisites

> 📋 **System Requirements** | ⏱️ **2 minutes** | 🔍 **Check Before Installing**

## 📋 System Requirements

### 🖥️ **Hardware Requirements**
- **RAM:** 4GB minimum, 8GB recommended for full development stack
- **Storage:** 10GB free space for complete installation
- **CPU:** Any modern x64 processor
- **Network:** Internet connection for downloads

### 🐧 **Software Requirements**
- **WSL2** installed and configured
- **Ubuntu 20.04+** or compatible Linux distribution (Debian, Ubuntu derivatives)
- **Windows 10 version 2004+** or **Windows 11** (for WSL2)

### 🌐 **Network Requirements**
- **Internet access** for package downloads
- **Local network access** for browser-based development (optional)
- **Firewall permissions** for port 3000 (code-server) and other services

---

## ✅ Verification Commands

### Check WSL Version

```bash
# Check WSL version
wsl --version

# Check distribution version
lsb_release -a
```

Expected output should show WSL2 and Ubuntu 20.04 or newer.

### Check Available Resources

```bash
# Check available memory
free -h

# Check available disk space
df -h

# Check CPU information
lscpu
```

### Check Network Connectivity

```bash
# Test internet connectivity
ping -c 3 google.com

# Check current IP address
ip addr show eth0

# Test DNS resolution
nslookup github.com
```

---

## 🔧 Initial Setup (If Needed)

### Update System

```bash
# Update package lists and system
sudo apt update && sudo apt upgrade -y
```

### Set Timezone (Optional)

```bash
# Check current timezone
timedatectl

# Set timezone (example: US/Eastern)
sudo timedatectl set-timezone America/New_York

# Or use interactive selection
sudo dpkg-reconfigure tzdata
```

### Configure Git (Recommended)

```bash
# Set Git user information (replace with your details)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify Git configuration
git config --list
```

---

## 🎯 What You'll Need

### 📦 **For Code-Server Only** (Minimal Installation)
- **Time:** ~15 minutes
- **Space:** ~2GB
- **Components:** Essential tools + Code-server

### 💻 **For Single Language Development**
- **Time:** ~30 minutes  
- **Space:** ~4GB
- **Components:** Essential tools + Code-server + One programming language

### 🚀 **For Full Development Environment**
- **Time:** ~90 minutes
- **Space:** ~8GB
- **Components:** All tools and languages

### ☁️ **For Cloud Development**
- **Time:** ~120 minutes
- **Space:** ~10GB
- **Components:** Everything including containers and cloud tools

---

## 🚨 Common Issues

### WSL2 Not Available

If WSL2 is not available:

```powershell
# Run in Windows PowerShell as Administrator
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Restart Windows, then:
wsl --set-default-version 2
```

### Insufficient Space

```bash
# Clean up package cache
sudo apt autoclean
sudo apt autoremove

# Remove unnecessary packages
sudo apt autoremove --purge

# Check largest directories
du -sh /* 2>/dev/null | sort -hr
```

### Network Issues

```bash
# Check WSL network configuration
ip route show

# Reset WSL network (run in Windows PowerShell)
# wsl --shutdown
# Restart WSL
```

---

## 🔗 Next Steps

Once you've verified all prerequisites:

1. **✅ Prerequisites Met** → Continue to [Essential Tools](./essential-tools.md)
2. **❌ Missing Requirements** → Install WSL2 or upgrade your system
3. **🤔 Need Help** → Check [Troubleshooting Guide](../08-troubleshooting/common-issues.md)

---

**📋 Prerequisites checked!**

> 💡 **Ready to proceed?** Start with [Essential Tools Installation](./essential-tools.md)