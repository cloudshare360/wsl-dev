# 🖥️ WSL with RDP - Complete Master Guide

> 🌐 **Best Viewing Experience:** [GitHub Pages Site](https://cloudshare360.github.io/wsl-dev/) | 📂 **Source:** [GitHub Repository](https://github.com/cloudshare360/wsl-dev) | [← Back to WSL Commands](../wsl-commands/README.md)

## 📑 Table of Contents

1. [📋 Overview](#-overview)
2. [🎯 What You'll Achieve](#-what-youll-achieve)
3. [📋 Prerequisites](#-prerequisites)
4. [🚀 Installation Process](#-installation-process)
   - [Step 1: Install and Configure WSL2](#-step-1-install-and-configure-wsl2)
   - [Step 2: Configure Ubuntu Environment](#-step-2-configure-ubuntu-environment)
   - [Step 3: Install Desktop Environment](#-step-3-install-desktop-environment)
   - [Step 4: Install and Configure xRDP](#-step-4-install-and-configure-xrdp)
   - [Step 5: Configure Network and Firewall](#-step-5-configure-network-and-firewall)
   - [Step 6: Connect via RDP](#-step-6-connect-via-rdp)
   - [Step 7: Optimization and Performance](#-step-7-optimization-and-performance)
5. [🩺 Troubleshooting](#-troubleshooting)
6. [🔧 Advanced Configurations](#-advanced-configurations)
7. [� User Management](#-user-management)
8. [🔍 Distribution Management](#-distribution-management)
9. [🐛 Debugging and Diagnostics](#-debugging-and-diagnostics)
10. [�📝 Best Practices](#-best-practices)
11. [🚀 Automation Scripts](#-automation-scripts)
12. [📚 Additional Resources](#-additional-resources)
13. [🔄 Maintenance](#-maintenance)

---

## 📋 Overview

This comprehensive guide will help you set up a stable, lightweight WSL2 instance with full GUI support using RDP. Based on extensive testing and troubleshooting, this guide includes the correct configurations that ensure seamless desktop experience.

**Key Benefits:**
- Complete Ubuntu desktop environment via RDP
- Stable, lightweight XFCE4 configuration
- GPU acceleration support
- Optimized for cloud development
- Comprehensive troubleshooting solutions
- Battle-tested configuration from real-world usage

## 🎯 Quick Start Paths

**Choose your path based on your needs:**

### 🚀 Fast Track (Automated)
- **Go to:** [Quick Setup Script](#-quick-setup-script)
- **Time:** 15-30 minutes
- **Best for:** First-time setup, want everything automated

### 🔧 Manual Setup (Step-by-Step)
- **Go to:** [Installation Process](#-installation-process)
- **Time:** 45-60 minutes  
- **Best for:** Learning the process, custom configurations

### 🆘 Having Issues?
- **Go to:** [Troubleshooting](#-troubleshooting-common-issues)
- **Quick fix:** [Emergency Recovery](#emergency-recovery)
- **Best for:** Fixing existing broken setup

### 🎓 Advanced Users
- **Go to:** [Advanced Configurations](#-advanced-configurations)
- **Also see:** [Debugging and Diagnostics](#-debugging-and-diagnostics)
- **Best for:** Performance tuning, multiple users, custom setups

### 👤 User & Distribution Management
- **Go to:** [User Management](#-user-management)
- **Also see:** [Distribution Management](#-distribution-management)
- **Best for:** Managing multiple users, backing up distributions

## 🎯 What You'll Achieve

- Full Ubuntu desktop environment (XFCE4) running in WSL2
- RDP access for complete GUI experience
- Stable, lightweight configuration optimized for development
- Seamless switching between Windows and Linux environments
- GPU acceleration support
- Proper session management without conflicts

---

## 📋 Prerequisites

### System Requirements
- **Windows 10** (version 21H2+) or **Windows 11** (build 22000+)
- **Virtualization enabled** in BIOS/UEFI
- **At least 8GB RAM** (16GB recommended for development)
- **GPU with WSL compatible drivers** (NVIDIA, AMD, or Intel)

### Check Your System
```powershell
# Check Windows version
winver

# Check WSL status
wsl --status
```

---

## 🚀 Step 1: Install and Configure WSL2

### Enable WSL Features
Open **PowerShell as Administrator** and run:

```powershell
# Enable WSL and Virtual Machine Platform
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

**Restart your computer** after enabling features.

### Install WSL2 and Ubuntu
```powershell
# Install WSL with default Ubuntu
wsl --install

# Set WSL2 as default version
wsl --set-default-version 2

# Install specific Ubuntu version (recommended)
wsl --install -d Ubuntu-24.04
```

### Update WSL Kernel
```powershell
# Update to latest WSL version
wsl --update

# Verify installation
wsl --version
wsl --list --verbose
```

---

## 🐧 Step 2: Configure Ubuntu Environment

### Initial Setup
Launch Ubuntu and complete initial setup:
1. Create username (lowercase, no spaces)
2. Set strong password
3. Update system packages

```bash
# Update package manager
sudo apt update && sudo apt upgrade -y

# Install essential tools
sudo apt install -y curl wget git vim build-essential
```

### Enable SystemD (Critical for GUI)
```bash
# Create/edit WSL configuration
sudo nano /etc/wsl.conf
```

Add the following content:
```ini
[boot]
systemd=true

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
```

**Restart WSL** after configuration:
```powershell
wsl --shutdown
```

---

## 🎨 Step 3: Install Desktop Environment

### Install XFCE4 (Recommended)
XFCE4 provides the best balance of features, stability, and resource usage:

```bash
# Install XFCE4 desktop environment
sudo apt install -y xfce4 xfce4-goodies xorg dbus-x11

# Install additional useful packages
sudo apt install -y firefox thunar-archive-plugin file-roller
```

### Alternative: LXQt (Ultra-Lightweight)
For minimal resource usage:

```bash
# Install LXQt desktop environment
sudo apt install -y lxqt xorg dbus-x11 openbox
```

---

## 🔗 Step 4: Install and Configure xRDP

### Install xRDP Server
```bash
# Install xRDP and dependencies
sudo apt install -y xrdp

# Enable and start xRDP service
sudo systemctl enable xrdp
sudo systemctl start xrdp

# Check service status
sudo systemctl status xrdp
```

### 🔑 Critical Configuration - startwm.sh

This is the **most important step** that resolves most RDP session issues:

```bash
# Backup original startwm.sh
sudo cp /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.backup

# Edit startwm.sh with correct configuration
sudo nano /etc/xrdp/startwm.sh
```

**Replace the entire contents** with this **exact configuration**:

```bash
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR

# xrdp X session start script (c) 2015, 2017, 2021 mirabilos
# published under The MirOS Licence

# Rely on /etc/pam.d/xrdp-sesman using pam_env to load both
# /etc/environment and /etc/default/locale to initialise the
# locale and the user environment properly.

if test -r /etc/profile; then
        . /etc/profile
fi

if test -r ~/.profile; then
        . ~/.profile
fi

test -x /etc/X11/Xsession && exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsession
```

**Critical Points:**
- ⚠️ **The `unset` lines MUST be at the very top** (after shebang)
- ⚠️ **Never place them at the bottom** - this is a common mistake
- ⚠️ **Do NOT manually set DISPLAY variable anywhere**

### Configure User Session
```bash
# Create .xsession file for your user
echo "xfce4-session" > ~/.xsession

# Set proper permissions
chmod +x ~/.xsession

# Remove any conflicting X authority files
rm -f ~/.Xauthority
```

### Restart Services
```bash
# Restart xRDP services to apply configuration
sudo systemctl restart xrdp
sudo systemctl restart xrdp-sesman

# Verify services are running
sudo systemctl status xrdp
sudo systemctl status xrdp-sesman
```

---

## 🔌 Step 5: Configure Network and Firewall

### Configure xRDP Port
```bash
# Check xRDP port (default: 3389)
sudo netstat -tlnp | grep 3389

# Configure firewall (if needed)
sudo ufw allow 3389/tcp
```

### Test Local Connection
```bash
# Get WSL IP address
ip addr show eth0

# Test RDP port
telnet localhost 3389
```

---

## 🖥️ Step 6: Connect via RDP

### From Windows (Same Machine)
1. Open **Remote Desktop Connection** (`mstsc`)
2. Enter: `localhost:3389` or `127.0.0.1:3389`
3. Use your Ubuntu username and password
4. Select **Xorg** session when prompted

### From Network
1. Find WSL IP: `ip addr show eth0`
2. Connect to: `<WSL_IP>:3389`
3. Use Ubuntu credentials

### Expected Result
You should see:
- Full XFCE4 desktop environment
- Working panels, menus, and applications
- Seamless mouse and keyboard input
- File manager and terminal access

---

## ⚙️ Step 7: Optimization and Performance

### Memory Configuration
Create `.wslconfig` in Windows user profile (`%USERPROFILE%\.wslconfig`):

```ini
[wsl2]
# Memory allocation (adjust based on your system)
memory=8GB

# CPU cores
processors=4

# Swap file size
swap=2GB

# Networking mode
localhostForwarding=true

# GUI acceleration
nestedVirtualization=true
```

### Disable Unnecessary Services
```bash
# Disable services to improve performance
sudo systemctl disable bluetooth
sudo systemctl disable avahi-daemon
sudo systemctl disable cups

# Clean up packages
sudo apt autoremove -y
sudo apt autoclean
```

### GPU Acceleration Setup
```bash
# Verify GPU access
ls /dev/dxg

# Install GPU drivers if needed (NVIDIA example)
# Follow NVIDIA WSL driver installation guide
```

---

## 🩺 Troubleshooting Common Issues

### Issue 1: "Logging Out Immediately" / Session Terminates

**Symptoms:** RDP connects but immediately logs out or shows blank screen

**Root Cause:** Incorrect startwm.sh configuration or environment conflicts

**Diagnostic Steps:**
```bash
# Check xRDP logs for errors
sudo tail -f /var/log/xrdp.log
sudo tail -f /var/log/xrdp-sesman.log

# Check user session errors
tail -f ~/.xsession-errors

# Verify startwm.sh configuration
sudo head -10 /etc/xrdp/startwm.sh
```

**Solutions:**
1. **Fix startwm.sh (Most Common Issue):**
   ```bash
   sudo nano /etc/xrdp/startwm.sh
   ```
   Ensure it starts with:
   ```bash
   #!/bin/sh
   unset DBUS_SESSION_BUS_ADDRESS
   unset XDG_RUNTIME_DIR
   ```

2. **Clean environment variables:**
   ```bash
   # Remove DISPLAY exports from shell files
   grep -r "DISPLAY" ~/.bashrc ~/.profile /etc/environment
   # Remove any lines that set DISPLAY manually
   ```

3. **Clean restart:**
   ```bash
   sudo systemctl restart xrdp
   wsl --shutdown
   ```

### Issue 2: "Cannot Open Display: wayland-0"

**Symptoms:** Session fails with Wayland display error in logs

**Root Cause:** XFCE trying to connect to Wayland instead of X11 display

**Diagnostic Steps:**
```bash
# Check current display during RDP session
echo $DISPLAY  # Should show :10.0 or :11.0, NOT wayland-0

# Check for conflicting environment settings
env | grep -E "(DISPLAY|WAYLAND|XDG)"
```

**Solutions:**
1. **Ensure correct startwm.sh:**
   - `unset` lines MUST be at the top
   - Never manually set DISPLAY in startwm.sh

2. **Clean session artifacts:**
   ```bash
   rm -f ~/.Xauthority
   sudo rm -rf /tmp/.ICE-unix
   sudo rm -rf /tmp/.X11-unix
   ```

3. **Verify .xsession file:**
   ```bash
   echo "xfce4-session" > ~/.xsession
   chmod +x ~/.xsession
   ```

### Issue 3: "Permission Denied" Errors

**Symptoms:** Various permission errors in xRDP logs

**Common Causes:**
- Incorrect file ownership
- Missing execute permissions
- xRDP service permissions

**Solutions:**
```bash
# Fix user permissions
sudo chown -R $USER:$USER ~/
chmod 755 ~
chmod +x ~/.xsession

# Fix xRDP permissions
sudo chown -R xrdp:xrdp /var/run/xrdp/
sudo chmod 755 /etc/xrdp/startwm.sh

# Fix SSL certificate permissions
sudo chown xrdp:xrdp /etc/xrdp/key.pem
sudo chown xrdp:xrdp /etc/xrdp/cert.pem
```

### Issue 4: Performance Issues / High Memory Usage

**Symptoms:** Slow GUI response, high Vmmem process in Windows

**Diagnostic Steps:**
```bash
# Check resource usage in WSL
htop
free -h
df -h

# Check from Windows
Get-Process | Where-Object {$_.ProcessName -eq "Vmmem"}
```

**Solutions:**
1. **Configure WSL memory limits** (`%USERPROFILE%\.wslconfig`):
   ```ini
   [wsl2]
   memory=4GB
   processors=2
   swap=1GB
   ```

2. **Optimize desktop environment:**
   ```bash
   # Disable unnecessary services
   sudo systemctl disable bluetooth avahi-daemon cups
   
   # Use lightweight applications
   sudo apt remove --purge libreoffice-*
   sudo apt autoremove -y
   ```

3. **Clean restart:**
   ```bash
   wsl --shutdown
   # Wait 10 seconds, then restart
   ```

### Issue 5: Network Connectivity Problems

**Symptoms:** Can't connect to RDP port or services not accessible

**Diagnostic Steps:**
```bash
# Check if xRDP is listening
sudo netstat -tlnp | grep 3389
sudo systemctl status xrdp

# Check WSL network
ip addr show eth0
ping google.com
```

**Solutions:**
1. **Restart networking services:**
   ```bash
   sudo systemctl restart xrdp
   sudo systemctl restart networking
   ```

2. **Check Windows firewall:**
   ```powershell
   # Allow RDP through Windows Firewall if needed
   netsh advfirewall firewall add rule name="WSL RDP" dir=in action=allow protocol=TCP localport=3389
   ```

3. **Reset WSL network:**
   ```bash
   wsl --shutdown
   # Restart WSL to reset network stack
   ```

### Issue 6: Multiple Session Conflicts

**Symptoms:** "Another session is active" or conflicting GUI sessions

**Root Cause:** Trying to run WSLg and xRDP simultaneously

**Solutions:**
1. **Use only one GUI method at a time:**
   ```bash
   # Kill all GUI processes before switching
   pkill -f xfce4
   pkill -f Xorg
   ```

2. **Clean session switch:**
   ```bash
   # When switching from WSLg to xRDP
   wsl --shutdown
   # Wait, then connect via RDP
   ```

3. **Check for running sessions:**
   ```bash
   who
   ps aux | grep -E "(xfce|Xorg)"
   ```

### Issue 7: XFCE Desktop Not Loading Properly

**Symptoms:** RDP connects but desktop is incomplete or applications don't start

**Diagnostic Steps:**
```bash
# Check XFCE processes
ps aux | grep xfce4

# Check .xsession-errors
tail -f ~/.xsession-errors

# Verify XFCE installation
dpkg -l | grep xfce4
```

**Solutions:**
1. **Reinstall XFCE components:**
   ```bash
   sudo apt install --reinstall xfce4-session xfce4-panel
   sudo apt install --reinstall xfwm4 xfdesktop4
   ```

2. **Reset XFCE configuration:**
   ```bash
   # Backup existing config
   mv ~/.config/xfce4 ~/.config/xfce4.backup
   
   # Let XFCE recreate default config
   ```

3. **Check for missing dependencies:**
   ```bash
   sudo apt install -f
   sudo apt install --reinstall dbus-x11
   ```

### Issue 8: Keyboard/Mouse Input Problems

**Symptoms:** Keyboard shortcuts don't work, mouse behavior is erratic

**Solutions:**
1. **Check RDP client settings:**
   - Use "Xorg" session type
   - Enable "Use all monitors" if needed
   - Check keyboard mapping settings

2. **Configure XFCE input:**
   ```bash
   # Reset input settings
   xfconf-query -c keyboards -p /Default/KeyRepeat/Delay -s 500
   xfconf-query -c keyboards -p /Default/KeyRepeat/Rate -s 30
   ```

### Issue 9: Display Resolution Problems

**Symptoms:** Incorrect screen resolution, scaling issues

**Solutions:**
1. **Set resolution from RDP client:**
   - Configure resolution before connecting
   - Use standard resolutions (1920x1080, 1366x768)

2. **Configure within session:**
   ```bash
   # Use XFCE display settings
   xfce4-display-settings
   
   # Or use xrandr
   xrandr --output default --mode 1920x1080
   ```

### Quick Fix Checklist

When experiencing issues, try these steps in order:

1. ✅ **Verify startwm.sh has unset lines at top**
2. ✅ **Clean session artifacts:** `rm -f ~/.Xauthority`
3. ✅ **Restart services:** `sudo systemctl restart xrdp`
4. ✅ **Clean WSL restart:** `wsl --shutdown`
5. ✅ **Check logs:** `sudo tail /var/log/xrdp.log`
6. ✅ **Verify network:** `netstat -tlnp | grep 3389`
7. ✅ **Test with different user account**
8. ✅ **Check Windows firewall/antivirus**

### Emergency Recovery

If the system becomes completely unusable:

```bash
# Reset to minimal working state
sudo systemctl stop xrdp
sudo apt install --reinstall xrdp xfce4-session
sudo cp /etc/xrdp/startwm.sh.backup /etc/xrdp/startwm.sh

# Restore critical configuration
sudo tee /etc/xrdp/startwm.sh > /dev/null << 'EOF'
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR

if test -r /etc/profile; then
    . /etc/profile
fi

if test -r ~/.profile; then
    . ~/.profile
fi

test -x /etc/X11/Xsession && exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsession
EOF

echo "xfce4-session" > ~/.xsession
chmod +x ~/.xsession

sudo systemctl start xrdp
```

---

## 🔧 Advanced Configurations

### Multi-User Setup
```bash
# Add additional users
sudo adduser newuser

# Configure xRDP for multiple sessions
sudo nano /etc/xrdp/xrdp.ini

# Allow multiple connections
# max_bpp=24
# xserverbpp=24
```

### Custom Desktop Themes
```bash
# Install additional themes
sudo apt install -y numix-gtk-theme papirus-icon-theme

# Configure via Settings Manager
xfce4-settings-manager
```

### Development Environment Setup
```bash
# Install development tools
sudo apt install -y nodejs npm python3-pip docker.io

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Install VS Code (optional)
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code
```

---

## 📝 Best Practices

### Session Management
1. **Use only one GUI method at a time** (either WSLg OR xRDP, not both simultaneously)
2. **Always clean shutdown**: `wsl --shutdown` before switching methods
3. **Regular backups**: Export your WSL distribution regularly

### Security Considerations
1. **Change default passwords** for all users
2. **Configure firewall** appropriately for network access
3. **Keep system updated** with security patches

### Development Workflow
1. **Keep projects in WSL filesystem** (`/home/user/`) for best performance
2. **Use Windows Terminal** for command-line access
3. **Consider VS Code Remote-WSL** for integrated development

---

## 🚀 Quick Setup Script

### Automated Installation Script

For rapid deployment, save this comprehensive script as `setup-wsl-rdp.sh`:

```bash
#!/bin/bash
# WSL RDP Desktop Setup Script
# Comprehensive automated installation with error handling

set -e  # Exit on any error

echo "========================================"
echo "WSL RDP Desktop Setup"
echo "========================================"
echo "This script will install:"
echo "- XFCE4 Desktop Environment"
echo "- xRDP Server with correct configuration"
echo "- Optimized settings for WSL2"
echo "========================================"

# Check if running in WSL
if ! grep -q Microsoft /proc/version; then
    echo "Error: This script must be run inside WSL2"
    exit 1
fi

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install desktop environment
echo "🖥️  Installing XFCE4 desktop environment..."
sudo apt install -y xfce4 xfce4-goodies xorg dbus-x11

# Install additional useful packages
echo "🔧 Installing additional packages..."
sudo apt install -y firefox thunar-archive-plugin file-roller

# Install xRDP
echo "🌐 Installing xRDP server..."
sudo apt install -y xrdp

# Configure systemd (if not already configured)
echo "⚙️  Configuring systemd..."
if [ ! -f /etc/wsl.conf ]; then
    sudo tee /etc/wsl.conf > /dev/null << 'EOF'
[boot]
systemd=true

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
EOF
    echo "⚠️  WSL configuration updated. You'll need to restart WSL after this script completes."
fi

# Configure CRITICAL startwm.sh
echo "🔑 Configuring xRDP startup script (CRITICAL)..."
sudo tee /etc/xrdp/startwm.sh > /dev/null << 'EOF'
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR

# xrdp X session start script (c) 2015, 2017, 2021 mirabilos
# published under The MirOS Licence

# Rely on /etc/pam.d/xrdp-sesman using pam_env to load both
# /etc/environment and /etc/default/locale to initialise the
# locale and the user environment properly.

if test -r /etc/profile; then
        . /etc/profile
fi

if test -r ~/.profile; then
        . ~/.profile
fi

test -x /etc/X11/Xsession && exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsession
EOF

# Make startwm.sh executable
sudo chmod +x /etc/xrdp/startwm.sh

# Configure user session
echo "👤 Configuring user session..."
echo "xfce4-session" > ~/.xsession
chmod +x ~/.xsession

# Clean old sessions
echo "🧹 Cleaning old session files..."
rm -f ~/.Xauthority
sudo rm -rf /tmp/.ICE-unix 2>/dev/null || true

# Optimize system (disable unnecessary services)
echo "⚡ Optimizing system performance..."
sudo systemctl disable bluetooth 2>/dev/null || true
sudo systemctl disable avahi-daemon 2>/dev/null || true
sudo systemctl disable cups 2>/dev/null || true

# Enable and start xRDP services
echo "🚀 Enabling xRDP services..."
sudo systemctl enable xrdp
sudo systemctl start xrdp
sudo systemctl enable xrdp-sesman
sudo systemctl start xrdp-sesman

# Verify services are running
echo "✅ Verifying services..."
if systemctl is-active --quiet xrdp; then
    echo "✅ xRDP service is running"
else
    echo "❌ xRDP service failed to start"
    sudo systemctl status xrdp --no-pager
fi

if systemctl is-active --quiet xrdp-sesman; then
    echo "✅ xRDP session manager is running"
else
    echo "❌ xRDP session manager failed to start"
    sudo systemctl status xrdp-sesman --no-pager
fi

# Show connection information
echo ""
echo "========================================"
echo "✅ Setup Complete!"
echo "========================================"
echo "Connection Information:"
echo "• Host: localhost:3389 (or 127.0.0.1:3389)"
echo "• Username: $(whoami)"
echo "• Password: [your Ubuntu password]"
echo "• Session Type: Xorg"
echo ""
echo "📋 Next Steps:"
echo "1. If WSL configuration was updated, restart WSL:"
echo "   wsl --shutdown (from Windows)"
echo "2. Open Remote Desktop Connection (mstsc)"
echo "3. Connect to: localhost:3389"
echo "4. Login with your Ubuntu credentials"
echo "5. Select 'Xorg' session when prompted"
echo ""
echo "🐛 Troubleshooting:"
echo "• Check logs: sudo tail -f /var/log/xrdp.log"
echo "• Verify display: echo \$DISPLAY (should show :10.0 or :11.0)"
echo "• Clean restart: wsl --shutdown (from Windows)"
echo "========================================"

# Create debug script
echo "📋 Creating debug information script..."
cat > ~/debug-rdp.sh << 'EODEBUG'
#!/bin/bash
echo "=== WSL RDP Debug Information ==="
echo "Date: $(date)"
echo "User: $(whoami)"
echo "Distribution: $(lsb_release -d 2>/dev/null || echo "Unknown")"
echo "Kernel: $(uname -a)"
echo ""
echo "=== Network ==="
echo "WSL IP: $(ip addr show eth0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)"
echo "RDP Port Status:"
sudo netstat -tlnp | grep 3389 || echo "Port 3389 not listening"
echo ""
echo "=== Services ==="
echo "xRDP Status:"
sudo systemctl status xrdp --no-pager -l
echo ""
echo "xRDP Session Manager Status:"
sudo systemctl status xrdp-sesman --no-pager -l
echo ""
echo "=== Configuration Files ==="
echo "~/.xsession:"
cat ~/.xsession 2>/dev/null || echo "File not found"
echo ""
echo "/etc/xrdp/startwm.sh (first 15 lines):"
sudo head -15 /etc/xrdp/startwm.sh
echo ""
echo "=== Recent Logs ==="
echo "Last 10 lines of xRDP log:"
sudo tail -10 /var/log/xrdp.log 2>/dev/null || echo "No xRDP log found"
echo ""
echo "Last 10 lines of session manager log:"
sudo tail -10 /var/log/xrdp-sesman.log 2>/dev/null || echo "No session manager log found"
echo "=== End Debug Info ==="
EODEBUG

chmod +x ~/debug-rdp.sh

echo ""
echo "💡 Pro Tip: Run ~/debug-rdp.sh to collect troubleshooting information"
echo ""
EODEBUG
```

Make it executable and run:
```bash
chmod +x setup-wsl-rdp.sh
./setup-wsl-rdp.sh
```

### Manual Installation Commands (Quick Reference)

For manual step-by-step installation:

```bash
# 1. Update system
sudo apt update && sudo apt upgrade -y

# 2. Install desktop environment
sudo apt install -y xfce4 xfce4-goodies xorg dbus-x11

# 3. Install xRDP
sudo apt install -y xrdp

# 4. Configure CRITICAL startwm.sh
sudo tee /etc/xrdp/startwm.sh > /dev/null << 'EOF'
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR

if test -r /etc/profile; then
        . /etc/profile
fi

if test -r ~/.profile; then
        . ~/.profile
fi

test -x /etc/X11/Xsession && exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsession
EOF

# 5. Configure user session
echo "xfce4-session" > ~/.xsession
chmod +x ~/.xsession

# 6. Clean session artifacts
rm -f ~/.Xauthority

# 7. Start services
sudo systemctl enable xrdp
sudo systemctl start xrdp

# 8. Connect via RDP to localhost:3389
```

### Connection Quick Reference

| Setting | Value |
|---------|-------|
| **Host** | `localhost:3389` or `127.0.0.1:3389` |
| **Session Type** | `Xorg` |
| **Username** | Your Ubuntu username |
| **Password** | Your Ubuntu password |

### Critical Configuration Summary

**File:** `/etc/xrdp/startwm.sh`
```bash
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS  # ← MUST be first
unset XDG_RUNTIME_DIR          # ← MUST be second
# ... rest of script
```

**File:** `~/.xsession`
```bash
xfce4-session
```

**WSL Config:** `/etc/wsl.conf`
```ini
[boot]
systemd=true
```

### Essential Troubleshooting Commands

```bash
# Check services
sudo systemctl status xrdp
sudo systemctl status xrdp-sesman

# Check logs
sudo tail -f /var/log/xrdp.log

# Verify display (during RDP session)
echo $DISPLAY  # Should show :10.0 or :11.0, NOT wayland-0

# Clean restart
sudo systemctl restart xrdp
wsl --shutdown  # From Windows
```

### Quick Fix for Most Issues

```bash
# Emergency fix script
sudo systemctl stop xrdp

# Restore critical configuration
sudo tee /etc/xrdp/startwm.sh > /dev/null << 'EOF'
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR

if test -r /etc/profile; then
    . /etc/profile
fi

if test -r ~/.profile; then
    . ~/.profile
fi

test -x /etc/X11/Xsession && exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsession
EOF

echo "xfce4-session" > ~/.xsession
chmod +x ~/.xsession
rm -f ~/.Xauthority

sudo systemctl start xrdp
```

---

---

## 👥 User Management

### Managing User Accounts

#### Change Root Password
To change or reset the root password in WSL2:

```powershell
# Launch WSL as root from PowerShell (as Administrator)
wsl -d Ubuntu -u root
```

```bash
# Inside WSL, change root password
passwd

# Change another user's password
passwd username
```

#### Create Additional Users
```bash
# Add new user
sudo adduser newuser

# Add user to sudo group
sudo usermod -aG sudo newuser

# Switch to new user
su - newuser
```

#### Manage User Sessions
```bash
# Check active users
who
w

# Check user login history
last

# Kill user sessions
sudo pkill -u username
```

### Multi-User RDP Setup
Configure xRDP for multiple simultaneous users:

```bash
# Edit xRDP configuration
sudo nano /etc/xrdp/xrdp.ini

# Add these settings for multiple sessions
max_bpp=24
xserverbpp=24
new_cursors=true

# Allow multiple connections
port=3389
use_vsock=false
```

---

## 🔍 Distribution Management

### List WSL Distributions

#### List Installed Distributions
```powershell
# Show installed distributions with details
wsl --list --verbose
# or shorthand
wsl -l -v

# Show only running distributions
wsl --list --running
```

#### List Available Distributions
```powershell
# Show available distributions for installation
wsl --list --online
# or shorthand
wsl -l -o
```

### Distribution Operations

#### Install Specific Distribution
```powershell
# Install Ubuntu 24.04 LTS
wsl --install -d Ubuntu-24.04

# Install without auto-launch
wsl --install -d Ubuntu-24.04 --no-launch
```

#### Export and Import Distributions
```powershell
# Export distribution (backup)
wsl --export Ubuntu-24.04 C:\Backups\ubuntu-rdp-backup.tar

# Import distribution (restore/clone)
wsl --import Ubuntu-RDP C:\WSL\Ubuntu-RDP C:\Backups\ubuntu-rdp-backup.tar

# Set default distribution
wsl --set-default Ubuntu-RDP
```

#### Clean Up Distributions
```powershell
# Unregister (delete) distribution
wsl --unregister Ubuntu-old

# Terminate running distribution
wsl --terminate Ubuntu-24.04

# Shutdown all WSL instances
wsl --shutdown
```

### Clean Uninstall Process
If you need to completely remove WSL2:

```powershell
# 1. List and remove all distributions
wsl --list --verbose
wsl --unregister Ubuntu
wsl --unregister <each-distribution>

# 2. Uninstall WSL components
Get-AppxPackage MicrosoftCorporationII.WindowsSubsystemForLinux | Remove-AppxPackage

# 3. Disable WSL features
dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux
dism.exe /online /disable-feature /featurename:VirtualMachinePlatform

# 4. Restart computer
# 5. Re-enable if needed
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

---

## 🐛 Debugging and Diagnostics

### Reading xRDP Logs

Understanding xRDP log messages helps diagnose connection issues:

#### Check Log Files
```bash
# Main xRDP service log
sudo tail -f /var/log/xrdp.log

# Session manager log
sudo tail -f /var/log/xrdp-sesman.log

# User session errors
tail -f ~/.xsession-errors

# System logs
sudo journalctl -u xrdp -f
sudo journalctl -u xrdp-sesman -f
```

#### Common Log Messages and Solutions

**Error: "Cannot read private key file /etc/xrdp/key.pem: Permission denied"**
- **Cause:** Security protocol for RDP TLS fallback
- **Solution:** Not fatal, session continues with basic RDP

**Error: "Window manager exited quickly (0 secs)"**
- **Cause:** XFCE session failing to start
- **Solution:** Check `.xsession` file and startwm.sh configuration

**Error: "cannot open display: wayland-0"**
- **Cause:** XFCE trying to connect to Wayland instead of X11
- **Solution:** Ensure correct startwm.sh configuration and clean environment

### Environment Diagnosis

#### Check Display Configuration
```bash
# Check current display (should show :10.0, :11.0, etc.)
echo $DISPLAY

# Check for conflicting display settings
grep -r "DISPLAY" ~/.bashrc ~/.profile /etc/environment

# Verify X11 is available
ls /tmp/.X11-unix/
```

#### Session Environment Verification
```bash
# Check running processes
ps aux | grep xfce
ps aux | grep Xorg
ps aux | grep xrdp

# Check desktop session
echo $XDG_CURRENT_DESKTOP
echo $XDG_SESSION_TYPE

# Verify XFCE processes
pgrep -fl xfce4-session
```

### Network Diagnostics

#### Check RDP Port and Services
```bash
# Verify xRDP is listening
sudo netstat -tlnp | grep 3389
sudo ss -tlnp | grep 3389

# Check service status
sudo systemctl status xrdp
sudo systemctl status xrdp-sesman

# Test local connection
telnet localhost 3389
```

#### Network Configuration
```bash
# Get WSL IP address
ip addr show eth0
hostname -I

# Check Windows accessibility
# From Windows Command Prompt:
# telnet <WSL_IP> 3389
```

### File System Verification

#### Check Configuration Files
```bash
# Verify .xsession exists and is executable
ls -l ~/.xsession
cat ~/.xsession

# Check startwm.sh configuration
sudo head -10 /etc/xrdp/startwm.sh

# Verify systemd configuration
cat /etc/wsl.conf
```

#### Clean Session Artifacts
```bash
# Remove conflicting files
rm -f ~/.Xauthority
sudo rm -rf /tmp/.ICE-unix
sudo rm -rf /tmp/.X11-unix

# Clear session cache
rm -rf ~/.cache/sessions
rm -rf ~/.config/xfce4/xfconf/xfce-perchannel-xml/
```

### Performance Diagnostics

#### Resource Monitoring
```bash
# System resource usage
htop
top
free -h
df -h

# Network usage
iotop
nethogs

# GPU usage (if available)
nvidia-smi  # for NVIDIA
```

#### Windows Resource Monitoring
```powershell
# Check WSL memory usage (Vmmem process)
Get-Process | Where-Object {$_.ProcessName -eq "Vmmem"}

# Task Manager: Performance tab
# Look for high memory/CPU usage
```

### Debug Mode Setup

#### Enable Detailed Logging
```bash
# Add debug options to startwm.sh
sudo nano /etc/xrdp/startwm.sh

# Add at the top (after unset lines):
# exec > /tmp/startwm.log 2>&1
# set -x
```

#### WSL Debug Configuration
Add to `%USERPROFILE%\.wslconfig`:

```ini
[wsl2]
debugConsole=true
```

#### Collect Debug Information
```bash
# System information script
cat > ~/debug-info.sh << 'EOF'
#!/bin/bash
echo "=== WSL RDP Debug Information ==="
echo "Date: $(date)"
echo "Distribution: $(lsb_release -d)"
echo "Kernel: $(uname -a)"
echo "WSL Version: $(cat /proc/version)"
echo
echo "=== Network ==="
ip addr show
echo
echo "=== Services ==="
sudo systemctl status xrdp --no-pager
sudo systemctl status xrdp-sesman --no-pager
echo
echo "=== Processes ==="
ps aux | grep -E "(xrdp|xfce|Xorg)"
echo
echo "=== Environment ==="
env | grep -E "(DISPLAY|XDG|DBUS)"
echo
echo "=== Files ==="
ls -la ~/.xsession
sudo ls -la /etc/xrdp/startwm.sh
echo
echo "=== Recent Logs ==="
sudo tail -20 /var/log/xrdp.log
echo "=== End Debug Info ==="
EOF

chmod +x ~/debug-info.sh
./debug-info.sh
```

---

## 📚 Additional Resources

### Official Documentation
- [Microsoft WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/)
- [WSL GUI Apps Guide](https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps)
- [xRDP Official Documentation](http://xrdp.org/)

### Community Resources
- [WSL GitHub Repository](https://github.com/microsoft/WSL)
- [WSL Discussions](https://github.com/microsoft/WSL/discussions)

### Troubleshooting Tools
- [WSL Troubleshooting Guide](troubleshooting.md)
- Event Viewer: `Applications and Services Logs > Microsoft > Windows > WSL`

---

## 🔄 Maintenance

### Regular Tasks
```bash
# Weekly system update
sudo apt update && sudo apt upgrade -y

# Clean up packages
sudo apt autoremove -y
sudo apt autoclean

# Check service status
sudo systemctl status xrdp
```

### Backup Your Configuration
```bash
# Export WSL distribution
wsl --export Ubuntu-24.04 C:\Backups\ubuntu-rdp-$(date +%Y%m%d).tar

# Backup configuration files
cp ~/.xsession ~/backup/
sudo cp /etc/xrdp/startwm.sh ~/backup/
```

---

## ⚠️ Important Notes

1. **The correct startwm.sh configuration is CRITICAL** - most issues stem from incorrect environment variable handling
2. **Never mix WSLg and xRDP sessions** for the same user simultaneously
3. **Always shutdown WSL cleanly** when switching between GUI methods
4. **Keep your WSL distribution updated** for security and stability
5. **Monitor resource usage** and adjust `.wslconfig` as needed

---

**Success Indicators:**
- RDP connects without immediate logout
- XFCE desktop loads completely
- Applications launch properly
- No "wayland-0" errors in logs
- Stable session that doesn't crash

[← Back to WSL Commands](../wsl-commands/README.md)