# 05 - Management and Maintenance

## WSL Distribution Management

### List WSL Distributions

```powershell
# List all installed distributions
wsl --list --verbose

# Short form
wsl -l -v

# List available distributions for installation
wsl --list --online
```

### Start and Stop Distributions

```powershell
# Start specific distribution
wsl -d Ubuntu-24.04

# Stop/shutdown distribution
wsl --shutdown Ubuntu-24.04

# Stop all WSL distributions
wsl --shutdown
```

### Distribution State Management

```powershell
# Set default distribution
wsl --set-default Ubuntu-24.04

# Set WSL version for distribution
wsl --set-version Ubuntu-24.04 2

# Check distribution status
wsl --status
```

## Clean Uninstallation

### Remove Specific Distribution

```powershell
# Unregister/delete a distribution (PERMANENT)
wsl --unregister Ubuntu-24.04

# This removes all data and settings for that distribution
```

### Complete WSL Cleanup

```powershell
# 1. List and remove all distributions
wsl --list --verbose
wsl --unregister Ubuntu
wsl --unregister Docker-desktop
wsl --unregister Docker-desktop-data

# 2. Disable WSL features
dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart

# 3. Remove WSL update (if installed separately)
# Go to Add/Remove Programs and uninstall "Windows Subsystem for Linux Update"
```

### Clean WSL Data Directory

```powershell
# Remove WSL data (run as Administrator)
# Default location: C:\Users\%USERNAME%\AppData\Local\Packages\
Remove-Item -Recurse -Force "C:\Users\$env:USERNAME\AppData\Local\Packages\CanonicalGroupLimited.*"
Remove-Item -Recurse -Force "C:\Users\$env:USERNAME\AppData\Local\Packages\TheDebianProject.*"
```

## User and Password Management

### Change User Password

```bash
# Change current user password
passwd

# Change password for specific user
sudo passwd username
```

### Root Password Management

#### Method 1: From WSL

```bash
# Change root password (requires sudo access)
sudo passwd root
```

#### Method 2: From Windows PowerShell

```powershell
# Launch WSL as root user
wsl -d Ubuntu-24.04 -u root

# Then inside WSL, change root password
passwd root
```

### Create New Users

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

# Start service
sudo systemctl start xrdp

# Stop service
sudo systemctl stop xrdp

# Restart service
sudo systemctl restart xrdp

# Enable service (auto-start)
sudo systemctl enable xrdp

# Disable service
sudo systemctl disable xrdp
```

### Service Logs

```bash
# View service logs
sudo journalctl -u xrdp

# Follow live logs
sudo journalctl -u xrdp -f

# View logs from last boot
sudo journalctl -u xrdp -b
```

## Performance Optimization

### System Resources

```bash
# Check memory usage
free -h

# Check disk usage
df -h

# Check CPU usage
top

# Check running processes
ps aux | head -20
```

### xRDP Performance Tuning

Edit `/etc/xrdp/xrdp.ini`:

```bash
sudo nano /etc/xrdp/xrdp.ini
```

Optimize settings:

```ini
[Globals]
# Performance settings
bitmap_cache=true
bitmap_compression=true
bulk_compression=true
max_bpp=32

# Memory settings
tcp_keepalive=true
tcp_send_buffer_bytes=32768
tcp_recv_buffer_bytes=32768

# Session settings
killconnection_timeout=60
max_sessions=10
```

### XFCE Performance Settings

```bash
# Disable compositor for better performance
xfconf-query -c xfwm4 -p /general/use_compositing -s false

# Reduce window effects
xfconf-query -c xfwm4 -p /general/show_popup_shadow -s false
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

# Set as default version 2
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

## System Updates

### Update WSL Kernel

```powershell
# Update WSL kernel
wsl --update

# Check WSL version
wsl --version
```

### Update Distribution Packages

```bash
# Update package lists
sudo apt update

# Upgrade all packages
sudo apt upgrade -y

# Full system upgrade
sudo apt full-upgrade -y

# Clean package cache
sudo apt autoremove -y
sudo apt autoclean
```

## Security Considerations

### Firewall Configuration

```bash
# Check firewall status
sudo ufw status

# Enable firewall
sudo ufw enable

# Allow RDP (if needed from external networks)
sudo ufw allow 3389/tcp

# Allow SSH (if needed)
sudo ufw allow 22/tcp
```

### User Security

```bash
# Check user login history
last

# Check failed login attempts
sudo grep "Failed password" /var/log/auth.log

# Lock a user account
sudo passwd -l username

# Unlock a user account
sudo passwd -u username
```

---

**Previous:** [04 - Log Analysis and Debugging](./04_Log_Analysis_and_Debugging.md)  
**Next:** [06 - Advanced Configuration](./06_Advanced_Configuration.md)