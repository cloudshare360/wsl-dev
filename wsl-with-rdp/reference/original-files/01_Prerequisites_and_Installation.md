# 01 - Prerequisites and Installation

## Prerequisites

### System Requirements

- **Windows 11** (build 22000 or above) or **Windows 10 version 21H2+**
- **Virtualization enabled** in BIOS/UEFI
- A **GPU with WSL compatible drivers** (NVIDIA, AMD, or Intel)

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

## Install a Linux Distribution

### List Available Distributions

```powershell
wsl --list --online
```

### Install Ubuntu 24.04 LTS (Recommended)

```powershell
wsl --install -d Ubuntu-24.04
```

### Alternative: Install Other Distributions

```powershell
# For Ubuntu 22.04
wsl --install -d Ubuntu-22.04

# For Debian
wsl --install -d Debian
```

## Install Desktop Environment and RDP Server

### Update Package Lists

```bash
sudo apt update && sudo apt upgrade -y
```

### Install XFCE4 Desktop Environment

```bash
sudo apt install xfce4 xfce4-goodies -y
```

### Install xRDP Server

```bash
sudo apt install xrdp -y
```

### Optional: Install Additional Packages

```bash
# Install useful applications
sudo apt install firefox thunar-archive-plugin file-roller -y

# Install development tools (optional)
sudo apt install git curl wget vim nano -y
```

## Verify Installation

### Check WSL Distribution Status

```powershell
wsl --list --verbose
```

### Check xRDP Service Status

```bash
sudo systemctl status xrdp
```

### Get WSL IP Address

```bash
hostname -I
```

---

**Next:** [02 - Configuration and Setup](./02_Configuration_and_Setup.md)