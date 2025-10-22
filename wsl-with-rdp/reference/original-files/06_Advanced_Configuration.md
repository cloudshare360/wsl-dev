# 06 - Advanced Configuration

## WSLg Integration

### Using WSLg for Individual Apps

WSLg (WSL Graphics) allows running individual GUI applications without RDP:

```bash
# Install GUI applications
sudo apt install firefox thunar gedit

# Launch apps directly (works on Windows 11/10 22H2+)
firefox &
thunar &
gedit &
```

### Combining WSLg with Full Desktop

```bash
# Method 1: Launch full XFCE with WSLg
dbus-launch startxfce4

# Method 2: Launch specific XFCE components
xfce4-panel &
xfdesktop &
```

## Alternative Desktop Environments

### LXQt (Ultra Lightweight)

```bash
# Install LXQt
sudo apt install lxqt-core -y

# Configure for xRDP
echo lxqt-session > ~/.xsession
sudo systemctl restart xrdp
```

### MATE Desktop

```bash
# Install MATE
sudo apt install mate-desktop-environment-core -y

# Configure for xRDP
echo mate-session > ~/.xsession
sudo systemctl restart xrdp
```

### LXDE (Minimal Resource Usage)

```bash
# Install LXDE
sudo apt install lxde-core -y

# Configure for xRDP
echo startlxde > ~/.xsession
sudo systemctl restart xrdp
```

## Custom xRDP Configuration

### Advanced xrdp.ini Settings

Edit `/etc/xrdp/xrdp.ini`:

```bash
sudo nano /etc/xrdp/xrdp.ini
```

Advanced configuration:

```ini
[Globals]
# Listening address (bind to specific interface)
address=0.0.0.0
port=3389

# Security settings
security_layer=negotiate
certificate=/etc/xrdp/cert.pem
key_file=/etc/xrdp/key.pem

# Session settings
autorun=
allow_channels=true
allow_multimon=true
bitmap_cache=true
bitmap_compression=true
bulk_compression=true

# Performance tuning
max_bpp=32
xserverbpp=24
tcp_keepalive=true
tcp_send_buffer_bytes=32768
tcp_recv_buffer_bytes=32768

# Connection limits
max_sessions=50
killconnection_timeout=60
disconnect_timeout=300

# Logging
log_file=/var/log/xrdp.log
log_level=INFO
enable_syslog=true
syslog_level=INFO
```

### Custom Session Types

Create custom session in `/etc/xrdp/xrdp.ini`:

```ini
[custom_xfce]
name=Custom XFCE
lib=libvnc.so
username=ask
password=ask
ip=127.0.0.1
port=-1
code=20
```

## SSL/TLS Configuration

### Generate Custom Certificates

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

Update xrdp.ini to use custom certificates:

```ini
[Globals]
certificate=/etc/xrdp/ssl/cert.pem
key_file=/etc/xrdp/ssl/key.pem
```

## GPU Acceleration

### Enable GPU Support in WSL2

```bash
# Check GPU availability
lspci | grep -i vga

# Install GPU drivers (NVIDIA example)
# Note: Windows GPU drivers automatically provide WSL2 support

# Verify GPU support
nvidia-smi  # For NVIDIA
glxinfo | grep "OpenGL"  # General GPU info
```

### XFCE GPU Acceleration

```bash
# Enable compositing with GPU acceleration
xfconf-query -c xfwm4 -p /general/use_compositing -s true
xfconf-query -c xfwm4 -p /general/compositor -s "opengl"
```

## Network Configuration

### Custom Network Settings

```bash
# Check current network configuration
ip addr show
ip route show

# Configure static IP (advanced)
sudo nano /etc/netplan/01-wsl.yaml
```

### Port Forwarding

```powershell
# Forward port from Windows to WSL (PowerShell as Admin)
netsh interface portproxy add v4tov4 listenport=3389 listenaddress=0.0.0.0 connectport=3389 connectaddress=$(wsl hostname -I).trim()

# List port forwarding rules
netsh interface portproxy show all

# Remove port forwarding
netsh interface portproxy delete v4tov4 listenport=3389 listenaddress=0.0.0.0
```

## Systemd Configuration

### Enable systemd in WSL2

Edit `/etc/wsl.conf`:

```bash
sudo nano /etc/wsl.conf
```

Add:

```ini
[boot]
systemd=true

[network]
generateHosts = false
generateResolvConf = false
```

Restart WSL from PowerShell:

```powershell
wsl --shutdown
wsl
```

### Systemd Service for xRDP

Create a systemd service file:

```bash
sudo nano /etc/systemd/system/xrdp-custom.service
```

Content:

```ini
[Unit]
Description=Custom xRDP Service
After=network.target

[Service]
Type=forking
PIDFile=/var/run/xrdp.pid
ExecStart=/usr/sbin/xrdp --nodaemon
ExecReload=/bin/kill -HUP $MAINPID
KillMode=mixed
TimeoutStopSec=30

[Install]
WantedBy=multi-user.target
```

Enable the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable xrdp-custom
sudo systemctl start xrdp-custom
```

## Development Environment Setup

### Install Development Tools

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

### IDE and Editors

```bash
# Visual Studio Code (GUI)
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code -y

# JetBrains Toolbox (download manually)
# IntelliJ IDEA, PyCharm, etc.
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

# Get IP address
IP=$(hostname -I | awk '{print $1}')
echo "RDP available at: $IP:3389"

# Optional: Start specific applications
# firefox &
# thunar &
```

Make executable:

```bash
chmod +x ~/start-desktop.sh
```

### Windows Batch File for Quick Connection

Create `connect-wsl.bat` on Windows desktop:

```batch
@echo off
echo Connecting to WSL2 Desktop...
for /f %%i in ('wsl hostname -I') do set WSL_IP=%%i
mstsc /v:%WSL_IP%
```

---

**Previous:** [05 - Management and Maintenance](./05_Management_and_Maintenance.md)  
**Back to:** [Main WSL-RDP Guide](../WSL-RDP-Master-Guide.md)