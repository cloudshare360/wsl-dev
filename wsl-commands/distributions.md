# 🐧 WSL Distribution Management

[← Back to Main Index](README.md)

## Overview
This section covers managing Linux distributions in WSL: listing available distributions, installing new ones, and removing distributions you no longer need.

---

## 📋 Listing Distributions

### List Available Distributions Online
View all Linux distributions available for download from Microsoft Store:

```bash
wsl --list --online
# Shorthand:
wsl -l -o
```

**Sample Output:**
```
The following is a list of valid distributions that can be installed.
Install using 'wsl.exe --install <Distro>'.

NAME                                   FRIENDLY NAME
Ubuntu                                 Ubuntu
Debian                                 Debian GNU/Linux
kali-linux                             Kali Linux Rolling
Ubuntu-18.04                           Ubuntu 18.04 LTS
Ubuntu-20.04                           Ubuntu 20.04 LTS
Ubuntu-22.04                           Ubuntu 22.04 LTS
OracleLinux_8_5                        Oracle Linux 8.5
OracleLinux_7_9                        Oracle Linux 7.9
SUSE-Linux-Enterprise-Server-15-SP4    SUSE Linux Enterprise Server 15 SP4
openSUSE-Leap-15.4                     openSUSE Leap 15.4
openSUSE-Tumbleweed                    openSUSE Tumbleweed
```

### List Installed Distributions
See which Linux distributions are currently installed on your system:

```bash
wsl --list --verbose
# Shorthand:
wsl -l -v
```

**Sample Output:**
```
  NAME            STATE           VERSION
* Ubuntu          Running         2
  Debian          Stopped         2
  kali-linux      Stopped         1
```

**Status Indicators:**
- `*` = Default distribution
- `STATE`: Running, Stopped
- `VERSION`: 1 (WSL 1) or 2 (WSL 2)

### List Only Running Distributions
Show only distributions that are currently running:

```bash
wsl --list --running
```

---

## 📥 Installing Distributions

### Install Default Distribution (Ubuntu)
Install WSL with the default Ubuntu distribution:

```bash
wsl --install
```

### Install Specific Distribution
Install a specific Linux distribution:

```bash
wsl --install -d <DistroName>
```

**Examples:**
```bash
# Install Ubuntu 22.04 LTS
wsl --install -d Ubuntu-22.04

# Install Debian
wsl --install -d Debian

# Install Kali Linux
wsl --install -d kali-linux

# Install openSUSE
wsl --install -d openSUSE-Leap-15.4
```

### Install Without Auto-Launch
Install a distribution without automatically launching it:

```bash
wsl --install --no-launch <DistroName>
```

**Use case:** Useful for scripting or when you want to configure the distribution later.

---

## 🗑️ Removing Distributions

### Unregister (Remove) a Distribution
Completely remove a distribution and all its data:

```bash
wsl --unregister <DistroName>
```

**Examples:**
```bash
# Remove Ubuntu
wsl --unregister Ubuntu

# Remove Debian
wsl --unregister Debian

# Remove Kali Linux
wsl --unregister kali-linux
```

**⚠️ Warning:** This command:
- Permanently deletes ALL data in the distribution
- Removes user accounts and configurations
- Cannot be undone
- Frees up disk space used by the distribution

### Safely Remove Data Before Unregistering
Before unregistering, backup important data:

```bash
# Export user data (run inside WSL)
cp -r /home/username/ /mnt/c/backup/

# Or use Windows tools to backup WSL files
# Location: \\wsl$\<DistroName>\home\username\
```

---

## ⚙️ Distribution Configuration

### Set Default Distribution
Change which distribution launches when you run `wsl`:

```bash
wsl --set-default <DistroName>
```

**Example:**
```bash
wsl --set-default Debian
```

### Convert Distribution Version
Change a distribution between WSL 1 and WSL 2:

```bash
# Convert to WSL 2 (recommended)
wsl --set-version <DistroName> 2

# Convert to WSL 1 (for compatibility)
wsl --set-version <DistroName> 1
```

**Examples:**
```bash
# Convert Ubuntu to WSL 2
wsl --set-version Ubuntu 2

# Convert Debian to WSL 1
wsl --set-version Debian 1
```

---

## 📊 Distribution Information

### Get Distribution Details
View detailed information about distributions:

```bash
# List with full details
wsl --list --verbose

# Check specific distribution status
wsl --list --running
```

### Distribution Storage Location
Access distribution files from Windows:

**File Explorer Path:**
```
\\wsl$\<DistroName>\
```

**Examples:**
- `\\wsl$\Ubuntu\home\username\`
- `\\wsl$\Debian\etc\`
- `\\wsl$\kali-linux\root\`

---

## 🔄 Import/Export Distributions

### Export Distribution
Create a backup of an entire distribution:

```bash
wsl --export <DistroName> <FileName.tar>
```

**Example:**
```bash
wsl --export Ubuntu C:\backups\ubuntu-backup.tar
```

### Import Distribution
Restore or create a distribution from a backup:

```bash
wsl --import <DistroName> <InstallLocation> <FileName.tar>
```

**Example:**
```bash
wsl --import Ubuntu-Backup C:\WSL\Ubuntu-Backup C:\backups\ubuntu-backup.tar
```

---

## 🛠️ Popular Distribution Setup

### Ubuntu Setup Commands
```bash
# Update package manager
sudo apt update && sudo apt upgrade -y

# Install essential tools
sudo apt install -y curl wget git vim build-essential
```

### Debian Setup Commands
```bash
# Update package manager
sudo apt update && sudo apt upgrade -y

# Install essential tools
sudo apt install -y curl wget git vim build-essential
```

### Kali Linux Setup Commands
```bash
# Update package manager
sudo apt update && sudo apt upgrade -y

# Install Kali meta-packages
sudo apt install -y kali-tools-top10
```

### openSUSE Setup Commands
```bash
# Update package manager
sudo zypper refresh && sudo zypper update -y

# Install essential tools
sudo zypper install -y curl wget git vim gcc make
```

---

## 📋 Quick Reference

| Action | Command | Notes |
|--------|---------|-------|
| List online distros | `wsl -l -o` | Shows available downloads |
| List installed distros | `wsl -l -v` | Shows local installations |
| Install Ubuntu | `wsl --install -d Ubuntu` | Default distribution |
| Install Debian | `wsl --install -d Debian` | Stable alternative |
| Install Kali | `wsl --install -d kali-linux` | Security testing |
| Remove distro | `wsl --unregister <name>` | ⚠️ Deletes all data |
| Set default | `wsl --set-default <name>` | Changes default distro |
| Export backup | `wsl --export <name> <file>` | Creates full backup |

---

## 🔗 Related Links

| Topic | Link |
|-------|------|
| Installation & Setup | [installation.md](installation.md) |
| Usage & Launch | [usage.md](usage.md) |
| Troubleshooting | [troubleshooting.md](troubleshooting.md) |
| Advanced Commands | [advanced.md](advanced.md) |

[← Back to Main Index](README.md)