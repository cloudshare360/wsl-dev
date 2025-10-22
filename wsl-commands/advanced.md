# 🔧 Advanced WSL Commands

[← Back to Main Index](README.md)

## Overview
This section covers advanced WSL configurations, power-user commands, and complex scenarios for experienced users.

---

## ⚙️ Advanced Configuration

### WSL Global Configuration (.wslconfig)
Configure WSL 2 globally in `%USERPROFILE%\.wslconfig`:

```ini
[wsl2]
# Memory allocation (default: 50% of total RAM)
memory=8GB

# CPU cores (default: all cores)
processors=4

# Swap file size (default: 25% of memory)
swap=2GB

# Swap file location
swapfile=C:\\temp\\wsl-swap.vhdx

# Disable page reporting for better performance
pageReporting=false

# Networking mode (bridged, mirrored, or nat)
networkingMode=mirrored

# Enable nested virtualization
nestedVirtualization=true

# Enable localhost forwarding
localhostForwarding=true

# Kernel command line
kernelCommandLine = sysctl.vm.max_map_count=262144

# Custom kernel
kernel=C:\\myKernels\\kernel

# Additional DLL path
dllHost=C:\\myDlls\\

# Debug console
debugConsole=true

# Default distribution
defaultDistribution=Ubuntu
```

### Per-Distribution Configuration (/etc/wsl.conf)
Configure individual distributions:

```ini
[boot]
# System boot command (runs as root)
command = /bin/bash -c 'mount --make-rshared /'

[automount]
# Enable auto-mounting of drives
enabled = true

# Mount point for drives
root = /mnt/

# Mount options
options = "metadata,uid=1000,gid=1000,umask=022,fmask=133,case=off"

# Process Windows PATH in WSL
mountFsTab = true

[network]
# Auto-generate /etc/hosts
generateHosts = true

# Auto-generate /etc/resolv.conf
generateResolvConf = true

# Set hostname
hostname = my-wsl-machine

[interop]
# Enable Windows interoperability
enabled = true

# Append Windows PATH to Linux PATH
appendWindowsPath = true

[user]
# Default user for distribution
default = myuser
```

---

## 📦 Import/Export and Backup

### Advanced Distribution Export
Create custom distribution backups:

```bash
# Export with compression
wsl --export Ubuntu - | gzip > ubuntu-backup.tar.gz

# Export specific filesystem
wsl --export Ubuntu C:\backups\ubuntu-$(date +%Y%m%d).tar

# Verify export
wsl --import Ubuntu-Test C:\temp\test C:\backups\ubuntu-backup.tar
wsl -d Ubuntu-Test ls /
wsl --unregister Ubuntu-Test
```

### Advanced Distribution Import
Import with custom configurations:

```bash
# Import to custom location
wsl --import MyUbuntu C:\WSL\MyUbuntu C:\backups\ubuntu.tar

# Import and set version
wsl --import MyUbuntu C:\WSL\MyUbuntu C:\backups\ubuntu.tar --version 2

# Import from compressed archive
gunzip -c ubuntu-backup.tar.gz | wsl --import MyUbuntu C:\WSL\MyUbuntu -
```

### Creating Base Images
Create reusable distribution templates:

```bash
# 1. Install and configure a distribution
wsl --install -d Ubuntu
wsl -d Ubuntu

# 2. Inside WSL, configure as desired
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential git curl vim
# ... more configuration

# 3. Clean up before export
sudo apt autoremove -y
sudo apt autoclean
history -c

# 4. Export as base image
wsl --export Ubuntu C:\BaseImages\ubuntu-dev-base.tar

# 5. Use base image for new environments
wsl --import DevEnv1 C:\WSL\DevEnv1 C:\BaseImages\ubuntu-dev-base.tar
wsl --import DevEnv2 C:\WSL\DevEnv2 C:\BaseImages\ubuntu-dev-base.tar
```

---

## 🌐 Advanced Networking

### Network Mirroring (Windows 11 22H2+)
Enable mirrored networking mode:

```ini
# In .wslconfig
[wsl2]
networkingMode=mirrored
dnsTunneling=true
firewall=true
autoProxy=true
```

### Manual Port Forwarding
Forward specific ports from WSL to Windows:

```bash
# Forward port 3000 from WSL to Windows
netsh interface portproxy add v4tov4 listenport=3000 listenaddress=0.0.0.0 connectport=3000 connectaddress=<WSL-IP>

# List active forwards
netsh interface portproxy show all

# Delete specific forward
netsh interface portproxy delete v4tov4 listenport=3000 listenaddress=0.0.0.0

# Delete all forwards
netsh interface portproxy reset
```

### Custom DNS Configuration
Configure custom DNS for WSL:

```bash
# Method 1: Edit /etc/resolv.conf (temporary)
sudo tee /etc/resolv.conf << EOF
nameserver 1.1.1.1
nameserver 8.8.8.8
search localdomain
EOF

# Method 2: Disable auto-generation (permanent)
# Add to /etc/wsl.conf
[network]
generateResolvConf = false

# Then manually create /etc/resolv.conf
```

### Bridge Network Setup
Create bridged network connection:

```bash
# 1. Create virtual switch in Hyper-V Manager
# 2. Configure WSL to use bridge
# In .wslconfig:
[wsl2]
networkingMode=bridged
vmSwitch=WSLBridge

# 3. Restart WSL
wsl --shutdown
```

---

## 🖥️ Custom Kernels and Modules

### Using Custom Linux Kernel
Compile and use custom kernel:

```bash
# 1. Download WSL 2 kernel source
git clone https://github.com/microsoft/WSL2-Linux-Kernel.git

# 2. Configure and compile
cd WSL2-Linux-Kernel
make KCONFIG_CONFIG=Microsoft/config-wsl -j$(nproc)

# 3. Copy kernel to Windows
cp arch/x86/boot/bzImage /mnt/c/mykernel

# 4. Update .wslconfig
[wsl2]
kernel=C:\\mykernel

# 5. Restart WSL
wsl --shutdown
```

### Loading Kernel Modules
Enable additional kernel modules:

```bash
# Check available modules
find /lib/modules/$(uname -r) -name "*.ko"

# Load module
sudo modprobe module_name

# Auto-load modules at boot
echo "module_name" | sudo tee -a /etc/modules

# Custom module parameters
echo "options module_name param=value" | sudo tee -a /etc/modprobe.d/custom.conf
```

---

## 🔒 Security and Isolation

### Running Rootless WSL
Set up rootless container environments:

```bash
# Install rootless Docker
curl -fsSL https://get.docker.com/rootless | sh

# Install Podman
sudo apt install -y podman

# Configure for rootless operation
echo "$(whoami):100000:65536" | sudo tee /etc/subuid
echo "$(whoami):100000:65536" | sudo tee /etc/subgid
```

### WSL with Windows Defender
Configure Windows Defender exclusions:

```powershell
# Exclude WSL directories from real-time scanning
Add-MpPreference -ExclusionPath "C:\Users\%USERNAME%\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu*"
Add-MpPreference -ExclusionPath "%LOCALAPPDATA%\Docker\wsl"

# Exclude WSL processes
Add-MpPreference -ExclusionProcess "wsl.exe"
Add-MpPreference -ExclusionProcess "wslhost.exe"
```

### File System Permissions
Advanced permission management:

```bash
# Enable metadata in WSL mount
# Add to /etc/wsl.conf:
[automount]
options = "metadata,uid=1000,gid=1000,umask=022,fmask=133"

# Set default ACLs
setfacl -d -m u::rwx,g::rx,o::rx /path/to/directory

# Windows-style permissions on WSL files
# Create: /etc/wsl.conf
[automount]
options = "metadata,case=off"
```

---

## 🐳 WSL with Container Technologies

### Docker Desktop Integration
Configure Docker Desktop with WSL 2:

```bash
# Enable WSL 2 backend in Docker Desktop settings
# Verify Docker in WSL
docker --version
docker run hello-world

# Use Docker Compose
docker-compose --version
```

### Podman Setup
Install and configure Podman:

```bash
# Install Podman
sudo apt update
sudo apt install -y podman

# Configure registries
sudo tee /etc/containers/registries.conf << EOF
[registries.search]
registries = ['docker.io', 'quay.io']
EOF

# Start Podman socket
systemctl --user enable --now podman.socket
```

### Kubernetes in WSL
Set up Kubernetes development:

```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install kind (Kubernetes in Docker)
go install sigs.k8s.io/kind@latest

# Create cluster
kind create cluster --name wsl-cluster
```

---

## 🔧 Performance Optimization

### Memory Management
Optimize memory usage:

```ini
# In .wslconfig
[wsl2]
# Limit memory
memory=4GB

# Reduce swap usage
swap=1GB

# Enable memory reclaim
vmIdleTimeout=60000

# Disable page reporting
pageReporting=false
```

### CPU Optimization
Optimize CPU performance:

```bash
# Set CPU governor (inside WSL)
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Disable CPU mitigations for performance
# Add to .wslconfig:
[wsl2]
kernelCommandLine = mitigations=off
```

### I/O Performance
Optimize file system performance:

```bash
# Use faster mount options
# In /etc/wsl.conf:
[automount]
options = "metadata,noatime,rsize=65536,wsize=65536,hard,intr,timeo=14"

# Disable Windows Defender real-time scanning for WSL directories
# Use SSD for WSL distributions
# Place frequently accessed files in Linux filesystem
```

---

## 🛠️ Development Environment Setup

### Multi-Distribution Development
Set up multiple development environments:

```bash
# Create project-specific distributions
wsl --import NodeJS-Dev C:\WSL\NodeJS ubuntu-base.tar
wsl --import Python-Dev C:\WSL\Python ubuntu-base.tar
wsl --import Go-Dev C:\WSL\Go ubuntu-base.tar

# Configure each environment
wsl -d NodeJS-Dev -- bash -c "curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs"
wsl -d Python-Dev -- bash -c "sudo apt update && sudo apt install -y python3-pip python3-venv"
wsl -d Go-Dev -- bash -c "wget -q -O - https://git.io/vQhTU | bash"
```

### Shared Development Tools
Set up shared tools across distributions:

```bash
# Create shared tools distribution
wsl --import DevTools C:\WSL\DevTools ubuntu-base.tar

# Install common tools
wsl -d DevTools -- bash -c "
sudo apt update
sudo apt install -y git vim neovim tmux htop tree jq curl wget
sudo snap install code --classic
sudo snap install docker
"

# Access from other distributions
# Add to each distribution's ~/.bashrc:
export PATH="/mnt/c/WSL/DevTools/usr/local/bin:$PATH"
```

---

## 📊 Monitoring and Diagnostics

### Resource Monitoring
Monitor WSL resource usage:

```bash
# Inside WSL
htop
iostat -x 1
vmstat 1
dstat -cdngy

# From Windows
# Task Manager -> Performance -> Memory
# Look for "Vmmem" process

# PowerShell monitoring
Get-Process | Where-Object {$_.ProcessName -eq "Vmmem"}
```

### Advanced Logging
Enable detailed WSL logging:

```ini
# In .wslconfig
[wsl2]
debugConsole=true

# Check Windows Event Viewer
# Applications and Services Logs > Microsoft > Windows > WSL
```

### Performance Profiling
Profile WSL performance:

```bash
# CPU profiling
perf record -g ./my-application
perf report

# Memory profiling
valgrind --tool=memcheck ./my-application

# I/O profiling
iotop
```

---

## 🚀 Automation and Scripting

### WSL Startup Scripts
Automate WSL startup:

```bash
# Windows startup script (batch file)
@echo off
wsl -d Ubuntu -- sudo service docker start
wsl -d Ubuntu -- sudo service postgresql start
wsl -d NodeJS-Dev -- npm run dev &
```

### PowerShell Integration
Advanced PowerShell WSL functions:

```powershell
# PowerShell profile function
function Start-WSLDev {
    param($Project)
    
    wsl -d "Dev-$Project" --cd "/home/user/projects/$Project"
}

function Backup-WSLDistro {
    param($DistroName)
    
    $Date = Get-Date -Format "yyyyMMdd"
    $BackupPath = "C:\WSL\Backups\$DistroName-$Date.tar"
    
    wsl --export $DistroName $BackupPath
    Write-Host "Backup created: $BackupPath"
}
```

### Automated Environment Setup
Script complete environment setup:

```bash
#!/bin/bash
# setup-wsl-dev.sh

# Function to setup development environment
setup_dev_env() {
    local env_name=$1
    local base_image=$2
    
    echo "Setting up $env_name environment..."
    
    # Import base image
    wsl --import "$env_name" "C:\\WSL\\$env_name" "$base_image"
    
    # Configure environment
    wsl -d "$env_name" -- bash -c "
        sudo apt update
        sudo apt upgrade -y
        sudo apt install -y git curl vim
        
        # Create user directories
        mkdir -p ~/projects ~/scripts ~/bin
        
        # Set up Git
        git config --global user.name 'Developer'
        git config --global user.email 'dev@example.com'
    "
    
    echo "$env_name environment ready!"
}

# Setup multiple environments
setup_dev_env "WebDev" "C:\\BaseImages\\ubuntu-base.tar"
setup_dev_env "DataScience" "C:\\BaseImages\\ubuntu-base.tar"
setup_dev_env "DevOps" "C:\\BaseImages\\ubuntu-base.tar"
```

---

## 📋 Quick Reference

| Advanced Feature | Command/Config | Use Case |
|------------------|----------------|----------|
| Memory limit | `.wslconfig: memory=4GB` | Resource management |
| Custom kernel | `.wslconfig: kernel=C:\\mykernel` | Special kernel features |
| Bridge network | `.wslconfig: networkingMode=bridged` | Network isolation |
| Export compressed | `wsl --export Ubuntu - \| gzip > backup.tar.gz` | Space-efficient backups |
| Multiple environments | `wsl --import Dev1 C:\\WSL\\Dev1 base.tar` | Project isolation |
| Performance monitoring | `htop`, `iostat`, Task Manager | Resource optimization |
| Custom DNS | `/etc/wsl.conf: generateResolvConf=false` | Network customization |

---

## 🔗 Related Links

| Topic | Link |
|-------|------|
| Installation & Setup | [installation.md](installation.md) |
| Distribution Management | [distributions.md](distributions.md) |
| Usage & Launch | [usage.md](usage.md) |
| Troubleshooting | [troubleshooting.md](troubleshooting.md) |

[← Back to Main Index](README.md)