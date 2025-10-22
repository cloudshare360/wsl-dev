# 02 - Configuration and Setup

## Basic Configuration

### Create .xsession File

Create the session configuration file for XFCE:

```bash
echo xfce4-session > ~/.xsession
```

### Verify .xsession File

```bash
cat ~/.xsession
# Should output: xfce4-session

ls -l ~/.xsession
# Should show: -rw-r--r-- 1 username username
```

## Critical xRDP Configuration

### Edit startwm.sh (CRITICAL STEP)

The most important configuration step - edit `/etc/xrdp/startwm.sh`:

```bash
sudo nano /etc/xrdp/startwm.sh
```

**IMPORTANT:** Place these lines at the very top, right after `#!/bin/sh`:

```bash
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR

# xrdp X session start script (c) 2015, 2017, 2021 mirabilos
# published under The MirOS Licence
# ... rest of the file
```

### Why This Configuration is Critical

- **XFCE was being launched with wrong display** (wayland-0) instead of X11 display started by xrdp
- WSLg creates display assignments (`wayland-0`) for native GUI apps
- xRDP expects its own Xorg server on separate display (like `:11.0`)
- DBUS/X authority variables leak from previous WSLg/native sessions, confusing the desktop environment

### Configure xRDP Service

```bash
# Enable xRDP service
sudo systemctl enable xrdp

# Restart xRDP service
sudo systemctl restart xrdp

# Check service status
sudo systemctl status xrdp
```

## Environment Cleanup

### Clean X Authority (If Needed)

```bash
# Remove conflicting .Xauthority file
rm -f ~/.Xauthority
```

### Check for Running Sessions

```bash
# Check who is logged in
who

# Check for running XFCE processes
ps aux | grep xfce
```

## Network Configuration

### Get WSL IP Address

```bash
# Method 1: hostname command
hostname -I

# Method 2: ip command
ip addr show eth0

# Method 3: ifconfig (if net-tools installed)
ifconfig eth0
```

### Windows Firewall (If Connection Issues)

```powershell
# Run in Windows PowerShell as Administrator
New-NetFirewallRule -DisplayName "WSL2 RDP" -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow
```

## User Account Configuration

### Set/Change User Password

```bash
# Change current user password
passwd

# Change password for specific user
sudo passwd username
```

### Change Root Password (If Needed)

From Windows PowerShell as Administrator:

```powershell
# Launch WSL as root
wsl -d Ubuntu -u root

# Then inside WSL
passwd root
```

## Connection Testing

### Test RDP Connection

1. Open **Remote Desktop Connection** (`mstsc.exe`) on Windows
2. Enter the WSL IP address (from `hostname -I`)
3. Use your Linux username and password
4. You should see the XFCE desktop

### Alternative GUI Launch Methods

#### Method 1: WSLg Integration (Windows 11/10 22H2+)

```bash
dbus-launch startxfce4
```

#### Method 2: Direct XFCE Launch

```bash
startxfce4
```

---

**Previous:** [01 - Prerequisites and Installation](./01_Prerequisites_and_Installation.md)  
**Next:** [03 - Troubleshooting Common Issues](./03_Troubleshooting_Common_Issues.md)