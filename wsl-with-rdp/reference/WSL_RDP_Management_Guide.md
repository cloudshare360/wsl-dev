# WSL2 RDP Management and Advanced Configuration

## WSL Distribution Management

### List and Control Distributions

```powershell
# List all installed distributions
wsl --list --verbose
wsl -l -v

# List available distributions for installation
wsl --list --online

# Start specific distribution
wsl -d Ubuntu-24.04

# Stop/shutdown distribution  
wsl --shutdown Ubuntu-24.04

# Stop all WSL distributions
wsl --shutdown

# Set default distribution
wsl --set-default Ubuntu-24.04

# Set WSL version for distribution
wsl --set-version Ubuntu-24.04 2
```

### Clean Uninstallation

#### Remove Specific Distribution
```powershell
# Unregister/delete a distribution (PERMANENT)
wsl --unregister Ubuntu-24.04
```

#### Complete WSL Cleanup
```powershell
# 1. Remove all distributions
wsl --list --verbose
wsl --unregister Ubuntu
wsl --unregister Docker-desktop
wsl --unregister Docker-desktop-data

# 2. Disable WSL features
dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart

# 3. Clean WSL data directory (as Administrator)
Remove-Item -Recurse -Force "C:\Users\$env:USERNAME\AppData\Local\Packages\CanonicalGroupLimited.*"
Remove-Item -Recurse -Force "C:\Users\$env:USERNAME\AppData\Local\Packages\TheDebianProject.*"
```

## User and Password Management

### Password Management
```bash
# Change current user password
passwd

# Change password for specific user
sudo passwd username

# Change root password
sudo passwd root
```

### Root Password from Windows
```powershell
# Launch WSL as root user
wsl -d Ubuntu-24.04 -u root

# Then change root password
passwd root
```

### Create and Manage Users
```bash
# Add new user
sudo adduser newusername

# Add user to sudo group
sudo usermod -aG sudo newusername

# Switch to new user
su - newusername
```

## Service Management

### xRDP Service Control
```bash
# Check service status
sudo systemctl status xrdp

# Start/stop/restart service
sudo systemctl start xrdp
sudo systemctl stop xrdp  
sudo systemctl restart xrdp

# Enable/disable service (auto-start)
sudo systemctl enable xrdp
sudo systemctl disable xrdp

# View service logs
sudo journalctl -u xrdp
sudo journalctl -u xrdp -f  # Follow live logs
sudo journalctl -u xrdp -b  # Logs from last boot
```

## Backup and Recovery

### Export WSL Distribution
```powershell
# Export distribution to tar file
wsl --export Ubuntu-24.04 C:\backup\ubuntu-backup.tar

# Compress the backup (optional)
tar -czf C:\backup\ubuntu-backup.tar.gz -C C:\backup ubuntu-backup.tar
```

### Import WSL Distribution
```powershell
# Import from backup
wsl --import Ubuntu-Restore C:\WSL\Ubuntu-Restore C:\backup\ubuntu-backup.tar

# Set as version 2
wsl --set-version Ubuntu-Restore 2
```

### Configuration Backup
```bash
# Backup important configuration files
mkdir ~/backup
cp ~/.xsession ~/backup/
cp -r ~/.config/xfce4 ~/backup/
sudo cp /etc/xrdp/xrdp.ini ~/backup/
sudo cp /etc/xrdp/startwm.sh ~/backup/
```

## Advanced Configuration

### WSLg Integration

#### Individual GUI Applications
```bash
# Install and run GUI applications without RDP
sudo apt install firefox thunar gedit

# Launch apps directly (Windows 11/10 22H2+)
firefox &
thunar &
gedit &
```

#### Combining WSLg with Full Desktop
```bash
# Launch full XFCE with WSLg
dbus-launch startxfce4

# Launch specific XFCE components
xfce4-panel &
xfdesktop &
```

### Alternative Desktop Environments

#### LXQt (Ultra Lightweight)
```bash
sudo apt install lxqt-core -y
echo lxqt-session > ~/.xsession
sudo systemctl restart xrdp
```

#### MATE Desktop
```bash
sudo apt install mate-desktop-environment-core -y
echo mate-session > ~/.xsession
sudo systemctl restart xrdp
```

#### LXDE (Minimal Resource Usage)
```bash
sudo apt install lxde-core -y
echo startlxde > ~/.xsession
sudo systemctl restart xrdp
```

### Custom xRDP Configuration

#### Advanced xrdp.ini Settings
```bash
sudo nano /etc/xrdp/xrdp.ini
```

Advanced configuration:
```ini
[Globals]
# Network settings
address=0.0.0.0
port=3389

# Security settings
security_layer=negotiate
certificate=/etc/xrdp/cert.pem
key_file=/etc/xrdp/key.pem

# Performance settings
bitmap_cache=true
bitmap_compression=true  
bulk_compression=true
max_bpp=32
xserverbpp=24
tcp_keepalive=true
tcp_send_buffer_bytes=32768
tcp_recv_buffer_bytes=32768

# Session limits
max_sessions=50
killconnection_timeout=60
disconnect_timeout=300

# Logging
log_file=/var/log/xrdp.log
log_level=INFO
enable_syslog=true
```

### SSL/TLS Configuration

#### Generate Custom Certificates
```bash
# Create certificate directory
sudo mkdir -p /etc/xrdp/ssl

# Generate private key
sudo openssl genrsa -out /etc/xrdp/ssl/key.pem 2048

# Generate certificate
sudo openssl req -new -x509 -key /etc/xrdp/ssl/key.pem -out /etc/xrdp/ssl/cert.pem -days 365

# Set permissions
sudo chmod 600 /etc/xrdp/ssl/key.pem
sudo chmod 644 /etc/xrdp/ssl/cert.pem
sudo chown xrdp:xrdp /etc/xrdp/ssl/*
```

Update xrdp.ini:
```ini
[Globals]
certificate=/etc/xrdp/ssl/cert.pem
key_file=/etc/xrdp/ssl/key.pem
```

### GPU Acceleration

#### Enable GPU Support
```bash
# Check GPU availability
lspci | grep -i vga

# Verify GPU support (NVIDIA example)
nvidia-smi
glxinfo | grep "OpenGL"
```

#### XFCE GPU Acceleration
```bash
# Enable compositing with GPU acceleration
xfconf-query -c xfwm4 -p /general/use_compositing -s true
xfconf-query -c xfwm4 -p /general/compositor -s "opengl"
```

### Network Configuration

#### Port Forwarding
```powershell
# Forward port from Windows to WSL (PowerShell as Admin)
netsh interface portproxy add v4tov4 listenport=3389 listenaddress=0.0.0.0 connectport=3389 connectaddress=$(wsl hostname -I).trim()

# List port forwarding rules
netsh interface portproxy show all

# Remove port forwarding
netsh interface portproxy delete v4tov4 listenport=3389 listenaddress=0.0.0.0
```

### Development Environment

#### Install Development Tools
```bash
# Essential development packages
sudo apt install build-essential git curl wget vim nano -y

# Programming languages
sudo apt install python3 python3-pip nodejs npm -y

# Database tools
sudo apt install sqlite3 postgresql-client mysql-client -y

# Container tools
sudo apt install docker.io docker-compose -y
sudo usermod -aG docker $USER
```

#### Visual Studio Code
```bash
# Install VS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code -y
```

## System Maintenance

### Updates and Upgrades
```bash
# Update WSL kernel (from PowerShell)
wsl --update
wsl --version

# Update distribution packages
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y

# Clean package cache
sudo apt autoremove -y
sudo apt autoclean
```

### Performance Monitoring
```bash
# Check system resources
free -h    # Memory usage
df -h      # Disk usage  
top        # CPU usage
ps aux | head -20  # Running processes
```

### Security Configuration
```bash
# Check firewall status
sudo ufw status

# Enable firewall
sudo ufw enable

# Allow RDP (if needed from external networks)
sudo ufw allow 3389/tcp

# Check user login history
last
sudo grep "Failed password" /var/log/auth.log
```

## Automation Scripts

### Startup Script
Create `/home/username/start-desktop.sh`:
```bash
#!/bin/bash
# Auto-start desktop services

# Start xRDP if not running
if ! systemctl is-active --quiet xrdp; then
    sudo systemctl start xrdp
fi

# Get and display IP address
IP=$(hostname -I | awk '{print $1}')
echo "RDP available at: $IP:3389"
```

Make executable:
```bash
chmod +x ~/start-desktop.sh
```

### Windows Connection Script
Create `connect-wsl.bat` on Windows desktop:
```batch
@echo off
echo Connecting to WSL2 Desktop...
for /f %%i in ('wsl hostname -I') do set WSL_IP=%%i
mstsc /v:%WSL_IP%
```

---

**Previous Guide:** [Troubleshooting and Debugging](./WSL_RDP_Troubleshooting.md)  
**Back to:** [Main WSL-RDP Guide](../WSL-RDP-Master-Guide.md)