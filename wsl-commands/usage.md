# 🚀 WSL Usage & Launch

[← Back to Main Index](README.md)

## Overview
This section covers day-to-day WSL usage: launching distributions, working with files, running commands, and managing your WSL environment.

---

## 🏃 Launching WSL

### Launch Default Distribution
Start your default WSL distribution:

```bash
wsl
```

### Launch Specific Distribution
Start a specific Linux distribution:

```bash
wsl -d <DistroName>
# or
wsl --distribution <DistroName>
```

**Examples:**
```bash
# Launch Ubuntu
wsl -d Ubuntu

# Launch Debian
wsl -d Debian

# Launch Kali Linux
wsl -d kali-linux
```

### Launch with Specific User
Start WSL as a specific user:

```bash
wsl -d <DistroName> -u <username>
# or
wsl --distribution <DistroName> --user <username>
```

**Examples:**
```bash
# Launch as root user
wsl -d Ubuntu -u root

# Launch as specific user
wsl -d Ubuntu -u john
```

### Launch in Specific Directory
Start WSL in a particular Windows directory:

```bash
wsl -d <DistroName> --cd <WindowsPath>
```

**Example:**
```bash
# Start in Windows Desktop
wsl -d Ubuntu --cd C:\Users\Username\Desktop
```

---

## 🖥️ Running Commands

### Execute Single Command
Run a single Linux command without entering WSL shell:

```bash
wsl <command>
# or for specific distribution
wsl -d <DistroName> <command>
```

**Examples:**
```bash
# Check Linux kernel version
wsl uname -a

# List files in home directory
wsl ls -la ~

# Run command in specific distro
wsl -d Ubuntu ls /etc
```

### Execute Command as Specific User
Run commands as a different user:

```bash
wsl -u <username> <command>
```

**Examples:**
```bash
# Run as root
wsl -u root apt update

# Run as specific user
wsl -u john whoami
```

### Run Windows Commands from WSL
Execute Windows commands from within WSL:

```bash
# Inside WSL shell
cmd.exe /c <windows-command>
powershell.exe <powershell-command>

# Examples
cmd.exe /c dir C:\
powershell.exe Get-Process
notepad.exe myfile.txt
```

---

## 📁 File System Access

### Access Windows Files from WSL
Windows drives are mounted under `/mnt/`:

```bash
# Navigate to C: drive
cd /mnt/c/

# Navigate to D: drive
cd /mnt/d/

# Access user profile
cd /mnt/c/Users/$USER/

# Common paths
ls /mnt/c/Users/Username/Desktop
ls /mnt/c/Users/Username/Documents
```

### Access WSL Files from Windows
Use Windows File Explorer to access WSL files:

**File Explorer Address:**
```
\\wsl$\<DistroName>\
```

**Examples:**
- `\\wsl$\Ubuntu\home\username\`
- `\\wsl$\Debian\etc\`
- `\\wsl$\Ubuntu\tmp\`

### File Operations Between Systems
Copy files between Windows and WSL:

```bash
# Copy from Windows to WSL
cp /mnt/c/Users/Username/file.txt ~/

# Copy from WSL to Windows
cp ~/file.txt /mnt/c/Users/Username/Desktop/

# Work with Windows paths (use quotes for spaces)
cp "/mnt/c/Users/User Name/My File.txt" ~/
```

---

## 🔄 Process Management

### Terminate WSL Distribution
Stop a running distribution:

```bash
wsl --terminate <DistroName>
# or shorthand
wsl -t <DistroName>
```

**Examples:**
```bash
# Stop Ubuntu
wsl -t Ubuntu

# Stop all distributions
wsl --shutdown
```

### Shutdown All WSL
Stop all running WSL distributions and the WSL 2 VM:

```bash
wsl --shutdown
```

**Use cases:**
- Free up system resources
- Reset WSL environment
- Troubleshoot issues

### Check Running Processes
See what's running in WSL:

```bash
# From Windows
wsl --list --running

# From inside WSL
ps aux
top
htop  # if installed
```

---

## 🌐 Networking

### Access WSL Services from Windows
WSL 2 uses a virtual network. Access services via:

```bash
# Find WSL IP address (from inside WSL)
ip addr show eth0

# Or use localhost (WSL 2 auto-forwards)
localhost:3000
127.0.0.1:8080
```

### Access Windows Services from WSL
Access Windows services from WSL:

```bash
# Windows localhost is accessible
curl http://host.docker.internal:80

# Or find Windows IP
cat /etc/resolv.conf
```

---

## 🛠️ Environment Variables

### Windows Environment Variables in WSL
Access Windows environment variables:

```bash
# View Windows PATH
echo $PATH

# Windows user profile
echo $USERPROFILE

# Access Windows env vars
echo $WINDIR
```

### Set WSL-specific Variables
Set environment variables for WSL:

```bash
# Temporary (current session)
export MY_VAR="value"

# Permanent (add to ~/.bashrc or ~/.profile)
echo 'export MY_VAR="value"' >> ~/.bashrc
source ~/.bashrc
```

---

## 📝 Working with Editors

### Text Editors in WSL
Use various text editors:

```bash
# Nano (simple)
nano filename.txt

# Vim (advanced)
vim filename.txt

# Emacs
emacs filename.txt

# VS Code (opens in Windows)
code filename.txt
code .  # open current directory
```

### Windows Editors from WSL
Open files in Windows applications:

```bash
# Notepad
notepad.exe filename.txt

# VS Code
code filename.txt

# Any Windows application
/mnt/c/Program\ Files/Application/app.exe filename
```

---

## 🔧 Common Workflows

### Development Workflow
Typical development setup:

```bash
# Navigate to project directory
cd /mnt/c/Users/Username/Projects/myproject

# Or work in WSL home
cd ~/projects

# Install dependencies
npm install
# or
pip install -r requirements.txt

# Start development server
npm start
# or
python app.py

# Open in VS Code
code .
```

### System Administration
Common admin tasks:

```bash
# Update system
sudo apt update && sudo apt upgrade

# Install software
sudo apt install package-name

# Check system resources
df -h        # disk usage
free -h      # memory usage
top          # running processes

# View logs
sudo journalctl
tail -f /var/log/syslog
```

---

## ⚡ Productivity Tips

### Useful Aliases
Add to `~/.bashrc` for quick access:

```bash
# Quick navigation
alias ll='ls -la'
alias la='ls -A'
alias c='clear'

# Quick Windows access
alias desktop='cd /mnt/c/Users/$USER/Desktop'
alias docs='cd /mnt/c/Users/$USER/Documents'
alias downloads='cd /mnt/c/Users/$USER/Downloads'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
```

### Tab Completion
Enable better tab completion:

```bash
# Install bash-completion (Ubuntu/Debian)
sudo apt install bash-completion

# Add to ~/.bashrc
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
```

---

## 📋 Quick Reference

| Action | Command | Notes |
|--------|---------|-------|
| Launch default | `wsl` | Starts default distribution |
| Launch specific | `wsl -d <name>` | Starts named distribution |
| Run command | `wsl <command>` | Execute without entering shell |
| Access Windows files | `cd /mnt/c/` | Windows C: drive |
| Access WSL from Windows | `\\wsl$\<name>\` | In File Explorer |
| Stop distribution | `wsl -t <name>` | Terminate specific distro |
| Stop all WSL | `wsl --shutdown` | Shutdown everything |
| Open VS Code | `code .` | Opens current directory |

---

## 🔗 Related Links

| Topic | Link |
|-------|------|
| Installation & Setup | [installation.md](installation.md) |
| Distribution Management | [distributions.md](distributions.md) |
| Troubleshooting | [troubleshooting.md](troubleshooting.md) |
| Advanced Commands | [advanced.md](advanced.md) |

[← Back to Main Index](README.md)