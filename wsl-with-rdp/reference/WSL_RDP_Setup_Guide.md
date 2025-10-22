# WSL2 RDP Setup and Configuration Guide

## Prerequisites and System Requirements

### Windows System Requirements
- **Windows 11** (build 22000 or above) or **Windows 10 version 21H2+**
- **Virtualization enabled** in BIOS/UEFI
- **GPU with WSL compatible drivers** (NVIDIA, AMD, or Intel)

### Enable WSL2 and Virtual Machine Platform

Open PowerShell **as Administrator** and run:

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

Restart your computer, then install WSL and set version 2 as default:

```powershell
wsl --install
wsl --set-default-version 2
```

## Linux Distribution Installation

### List and Install Distributions

```powershell
# List available distributions
wsl --list --online

# Install Ubuntu 24.04 LTS (Recommended)
wsl --install -d Ubuntu-24.04

# Alternative distributions
wsl --install -d Ubuntu-22.04
wsl --install -d Debian
```

### Install Desktop Environment and RDP Server

```bash
# Update package lists
sudo apt update && sudo apt upgrade -y

# Install XFCE4 Desktop Environment
sudo apt install xfce4 xfce4-goodies -y

# Install xRDP Server
sudo apt install xrdp -y

# Optional: Install useful applications
sudo apt install firefox thunar-archive-plugin file-roller git curl wget vim nano -y
```

## Critical Configuration Steps

### 1. Create .xsession File

```bash
# Create session configuration for XFCE
echo xfce4-session > ~/.xsession

# Verify the file
cat ~/.xsession  # Should output: xfce4-session
ls -l ~/.xsession  # Should show proper permissions
```

### 2. Configure startwm.sh (MOST CRITICAL STEP)

This is the **most important configuration** that fixes blank screen and logout issues:

```bash
sudo nano /etc/xrdp/startwm.sh
```

**CRITICAL:** Place these lines at the very top, right after `#!/bin/sh`:

```bash
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR

# xrdp X session start script (c) 2015, 2017, 2021 mirabilos
# published under The MirOS Licence
# ... rest of existing content
```

#### Why This Configuration is Critical
- **XFCE was launching with wrong display** (wayland-0) instead of X11 display
- WSLg creates display assignments (`wayland-0`) for native GUI apps
- xRDP expects its own Xorg server on separate display (like `:11.0`)
- DBUS/X authority variables leak from previous WSLg sessions, confusing desktop environment

### 3. Configure and Start xRDP Service

```bash
# Enable xRDP service for auto-start
sudo systemctl enable xrdp

# Start xRDP service
sudo systemctl start xrdp

# Check service status
sudo systemctl status xrdp

# Restart if needed
sudo systemctl restart xrdp
```

### 4. Network Configuration

```bash
# Get WSL IP address (use this for RDP connection)
hostname -I

# Alternative methods
ip addr show eth0
ifconfig eth0  # if net-tools installed
```

### 5. User Account Setup

```bash
# Set/change current user password
passwd

# Change password for specific user
sudo passwd username

# Change root password (if needed)
sudo passwd root
```

## Connection Testing

### RDP Connection from Windows

1. Open **Remote Desktop Connection** (`mstsc.exe`) on Windows
2. Enter the WSL IP address (from `hostname -I`)
3. Login with your Linux username and password
4. You should see the XFCE desktop

### Alternative GUI Launch Methods

#### WSLg Integration (Windows 11/10 22H2+)
```bash
# Launch full XFCE with WSLg
dbus-launch startxfce4

# Launch individual apps
firefox &
thunar &
```

#### Direct XFCE Launch
```bash
startxfce4
```

## Windows Firewall Configuration

If experiencing connection issues, run in Windows PowerShell as Administrator:

```powershell
# Allow RDP through Windows Firewall
New-NetFirewallRule -DisplayName "WSL2 RDP" -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow
```

## Verification Steps

### Check Installation Status
```bash
# Verify xRDP is listening
sudo netstat -tlnp | grep :3389
# or
sudo ss -tlnp | grep :3389

# Check running services
sudo systemctl is-active xrdp
who  # Check logged in users
```

### Environment Cleanup (If Needed)
```bash
# Remove conflicting .Xauthority file
rm -f ~/.Xauthority

# Check for running XFCE processes
ps aux | grep xfce

# Kill conflicting processes if needed
pkill -f xfce
```

---

**Next Guide:** [Troubleshooting and Debugging](./WSL_RDP_Troubleshooting.md)