# 🩺 WSL Troubleshooting

[← Back to Main Index](README.md)

## Overview
This section covers common WSL issues, diagnostic commands, and solutions to get your WSL environment running smoothly.

---

## 🔍 Diagnostic Commands

### Check WSL Status
Get overall WSL system information:

```bash
# Check WSL version and status
wsl --status

# List all distributions with details
wsl --list --verbose

# Check for updates
wsl --update --check
```

### System Information
Gather system information for troubleshooting:

```bash
# Windows version
winver

# WSL version details
wsl --version

# Check Windows features
dism.exe /online /get-featureinfo /featurename:Microsoft-Windows-Subsystem-Linux
dism.exe /online /get-featureinfo /featurename:VirtualMachinePlatform
```

---

## 🚨 Common Installation Issues

### Error: "WSL 2 requires an update to its kernel component"

**Problem:** Outdated WSL 2 kernel

**Solution:**
```bash
# Update WSL kernel
wsl --update

# If that fails, manually download from:
# https://aka.ms/wsl2kernel
```

### Error: "The requested operation requires elevation"

**Problem:** Insufficient permissions

**Solution:**
- Run Command Prompt or PowerShell as Administrator
- Right-click → "Run as administrator"

### Error: "A specified logon session does not exist"

**Problem:** Windows services not running

**Solution:**
```bash
# Restart WSL service
wsl --shutdown
# Wait 10 seconds, then try again
wsl
```

### Error: "The system cannot find the file specified"

**Problem:** WSL not properly installed

**Solution:**
```bash
# Enable WSL feature
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable Virtual Machine Platform
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Restart computer
# Then reinstall WSL
wsl --install
```

---

## 🌐 Network Issues

### Can't Access Internet from WSL

**Diagnostic:**
```bash
# Test connectivity
ping google.com
curl https://www.google.com

# Check DNS
nslookup google.com
cat /etc/resolv.conf
```

**Solutions:**
```bash
# Solution 1: Reset network
wsl --shutdown
# Restart WSL

# Solution 2: Fix DNS (add to /etc/resolv.conf)
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf

# Solution 3: Windows network reset
netsh winsock reset
netsh int ip reset
# Restart computer
```

### Can't Access WSL Services from Windows

**Problem:** Port forwarding not working

**Diagnostic:**
```bash
# Find WSL IP address
ip addr show eth0

# Check if service is running
netstat -tlnp | grep :3000
```

**Solutions:**
```bash
# Use localhost (should work automatically)
http://localhost:3000

# Or use WSL IP directly
http://172.x.x.x:3000

# Manual port forwarding (if needed)
netsh interface portproxy add v4tov4 listenport=3000 listenaddress=0.0.0.0 connectport=3000 connectaddress=172.x.x.x
```

---

## 📁 File System Issues

### Permission Denied Errors

**Problem:** File permission issues

**Solutions:**
```bash
# Fix ownership
sudo chown -R $USER:$USER /path/to/directory

# Fix permissions
chmod 755 /path/to/directory
chmod 644 /path/to/file

# For Windows interop files
sudo chmod +x /mnt/c/path/to/script.sh
```

### Files Not Syncing Between Windows and WSL

**Problem:** File system mounting issues

**Diagnostic:**
```bash
# Check mounts
mount | grep /mnt

# Check WSL configuration
cat /etc/wsl.conf
```

**Solutions:**
```bash
# Restart WSL
wsl --shutdown
wsl

# Reset WSL configuration
sudo rm /etc/wsl.conf
wsl --shutdown
wsl
```

---

## 💾 Performance Issues

### WSL Running Slowly

**Diagnostic:**
```bash
# Check resource usage
top
htop
df -h
free -h

# Windows Task Manager
# Look for "Vmmem" process
```

**Solutions:**
```bash
# Limit WSL memory usage
# Create/edit: %USERPROFILE%\.wslconfig

[wsl2]
memory=4GB
processors=2
swap=1GB
```

### High Memory Usage (Vmmem)

**Problem:** WSL 2 using too much RAM

**Solution:**
Create `.wslconfig` in your user profile:

```ini
# File: %USERPROFILE%\.wslconfig
[wsl2]
memory=4GB          # Limit memory to 4GB
processors=2        # Limit to 2 processors
swap=1GB           # Set swap file size
localhostForwarding=true
```

**Apply changes:**
```bash
wsl --shutdown
# Wait 10 seconds
wsl
```

---

## 🔄 Distribution Issues

### Distribution Won't Start

**Diagnostic:**
```bash
# Check distribution status
wsl --list --verbose

# Try to start with verbose output
wsl -d <DistroName> --verbose
```

**Solutions:**
```bash
# Solution 1: Restart WSL
wsl --shutdown
wsl -d <DistroName>

# Solution 2: Reset distribution
wsl --unregister <DistroName>
wsl --install -d <DistroName>
# Note: This deletes all data!

# Solution 3: Check Windows Event Logs
eventvwr.msc
# Look in: Windows Logs > Application > WSL events
```

### "Access is denied" when starting distribution

**Problem:** Corrupted distribution or permissions

**Solutions:**
```bash
# Run as administrator
# Try starting distribution

# If that fails, reset:
wsl --unregister <DistroName>
wsl --install -d <DistroName>
```

---

## 🛠️ Advanced Troubleshooting

### WSL Registry Issues

**Problem:** Registry corruption

**Solution:**
```bash
# Backup registry first!
# Delete WSL registry keys (Advanced users only)
# HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss

# Then reinstall WSL
wsl --unregister <DistroName>
wsl --install -d <DistroName>
```

### Collect WSL Logs

**For support or detailed troubleshooting:**

```bash
# Enable WSL logging
# Add to %USERPROFILE%\.wslconfig:
[wsl2]
debugConsole=true

# Restart WSL
wsl --shutdown

# Check Windows Event Viewer
eventvwr.msc
# Navigate to: Applications and Services Logs > Microsoft > Windows > WSL
```

### Clean Reset WSL

**Nuclear option - complete WSL reset:**

```bash
# Export important data first!
wsl --export Ubuntu C:\backup\ubuntu.tar

# Uninstall all distributions
wsl --list
wsl --unregister <each-distribution>

# Disable WSL features
dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux
dism.exe /online /disable-feature /featurename:VirtualMachinePlatform

# Restart computer

# Re-enable features
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Restart computer

# Reinstall WSL
wsl --install
```

---

## 🔧 Configuration Files

### WSL Configuration (.wslconfig)
Global WSL settings in `%USERPROFILE%\.wslconfig`:

```ini
[wsl2]
# Memory limit
memory=4GB

# CPU limit
processors=2

# Swap size
swap=1GB

# Disable page reporting (may improve performance)
pageReporting=false

# Enable localhost forwarding
localhostForwarding=true

# Network mode
#networkingMode=mirrored

# Debug console
debugConsole=false
```

### Per-Distribution Configuration (/etc/wsl.conf)
Distribution-specific settings:

```ini
[automount]
enabled = true
root = /mnt/
options = "metadata,umask=22,fmask=11"

[network]
generateHosts = true
generateResolvConf = true

[interop]
enabled = true
appendWindowsPath = true

[user]
default = username
```

---

## 🆘 Getting Help

### Built-in Help
```bash
# WSL help
wsl --help

# Specific command help
wsl --install --help
wsl --list --help
```

### Online Resources
- [Microsoft WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/)
- [WSL GitHub Issues](https://github.com/microsoft/WSL/issues)
- [WSL Community Discussions](https://github.com/microsoft/WSL/discussions)

### System Information for Support
When asking for help, provide:

```bash
# System info
wsl --version
wsl --status
wsl --list --verbose

# Windows version
winver

# Error messages (exact text)
# Steps to reproduce the issue
```

---

## 📋 Quick Troubleshooting Checklist

| Issue | Quick Solution |
|-------|---------------|
| WSL won't start | `wsl --shutdown` then `wsl` |
| Network not working | Check `/etc/resolv.conf`, add `nameserver 8.8.8.8` |
| High memory usage | Create `.wslconfig` with memory limits |
| Permission denied | `sudo chown -R $USER:$USER <path>` |
| Distribution corrupted | `wsl --unregister <name>` then reinstall |
| Can't access from Windows | Use `\\wsl$\<distro>\` path |
| Service not accessible | Check firewall, use `localhost:<port>` |

---

## 🔗 Related Links

| Topic | Link |
|-------|------|
| Installation & Setup | [installation.md](installation.md) |
| Distribution Management | [distributions.md](distributions.md) |
| Usage & Launch | [usage.md](usage.md) |
| Advanced Commands | [advanced.md](advanced.md) |

[← Back to Main Index](README.md)