# 📦 WSL Installation & Setup

[← Back to Main Index](README.md)

## Overview
This section covers installing WSL, updating to the latest version, and initial setup procedures.

---

## 🚀 Fresh WSL Installation

### Install WSL (Recommended Method)
Install WSL with the default Ubuntu distribution:

```bash
wsl --install
```

**Requirements:**
- Windows 10 version 2004+ or Windows 11
- Administrator privileges (Run as Administrator)
- Virtual Machine Platform feature enabled

### Install WSL with Specific Distribution
Install WSL with a specific Linux distribution:

```bash
wsl --install -d <DistroName>
```

**Example:**
```bash
wsl --install -d Ubuntu-22.04
```

---

## 🔄 Updating WSL

### Update WSL to Latest Version
Keep your WSL installation up to date:

```bash
wsl --update
```

### Check WSL Version
Verify your current WSL version:

```bash
wsl --version
```

**Output example:**
```
WSL version: 1.2.5.0
Kernel version: 5.15.90.1
WSLg version: 1.0.51
MSRDC version: 1.2.3770
Direct3D version: 1.608.2-61064218
DXCore version: 10.0.25131.1002-220531-1700.rs-onecore-base2-hyp
Windows version: 10.0.22621.1928
```

---

## ⚙️ WSL Configuration

### Set WSL Default Version
Set the default WSL version for new distributions:

```bash
# Set to WSL 2 (recommended)
wsl --set-default-version 2

# Set to WSL 1 (if needed for compatibility)
wsl --set-default-version 1
```

### Check Available Features
List WSL features and status:

```bash
wsl --status
```

---

## 🛠️ Prerequisites Setup

### Enable Required Windows Features
Before installing WSL, ensure these Windows features are enabled:

**Via PowerShell (Administrator):**
```powershell
# Enable WSL feature
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable Virtual Machine Platform
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

**Via Windows Features GUI:**
1. Open "Turn Windows features on or off"
2. Check "Windows Subsystem for Linux"
3. Check "Virtual Machine Platform"
4. Restart when prompted

---

## 🔧 Post-Installation Setup

### First-Time Setup
After installation, complete these initial steps:

1. **Launch your distribution** from Start Menu or run:
   ```bash
   wsl
   ```

2. **Create user account** when prompted:
   - Choose a username (lowercase, no spaces)
   - Set a password (you won't see characters as you type)

3. **Update package manager:**
   ```bash
   # For Ubuntu/Debian
   sudo apt update && sudo apt upgrade -y
   
   # For openSUSE
   sudo zypper refresh && sudo zypper update -y
   
   # For Alpine
   sudo apk update && sudo apk upgrade
   ```

---

## 🚨 Troubleshooting Installation

### Common Installation Issues

**Error: "WSL 2 requires an update to its kernel component"**
```bash
# Download and install the WSL2 kernel update
# Visit: https://aka.ms/wsl2kernel
```

**Error: "The requested operation requires elevation"**
- Run Command Prompt or PowerShell as Administrator

**Error: "Feature not found"**
- Ensure you're running Windows 10 version 2004+ or Windows 11
- Check Windows Update for latest updates

### Verify Installation
Check if WSL is properly installed:

```bash
wsl --list --verbose
```

---

## 📋 Next Steps

After successful installation:
1. [Manage Distributions](distributions.md) - Install additional Linux distributions
2. [Usage & Launch](usage.md) - Learn how to use your WSL environment
3. [Advanced Commands](advanced.md) - Configure advanced WSL settings

---

## 🔗 Related Links

| Topic | Link |
|-------|------|
| Distribution Management | [distributions.md](distributions.md) |
| Usage & Launch | [usage.md](usage.md) |
| Troubleshooting | [troubleshooting.md](troubleshooting.md) |
| Advanced Commands | [advanced.md](advanced.md) |

[← Back to Main Index](README.md)