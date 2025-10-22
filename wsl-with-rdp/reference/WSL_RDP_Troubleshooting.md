# WSL2 RDP Troubleshooting and Debugging Guide

## Common Issues and Solutions

### Blank Screen or Immediate Logout

#### Primary Solution: Check startwm.sh Configuration

**Symptoms:**
- RDP connects but shows blank screen
- Session logs out immediately  
- Connection drops after few seconds

**Solution:**
Verify the critical configuration in `/etc/xrdp/startwm.sh`:

```bash
sudo cat /etc/xrdp/startwm.sh | head -10
```

The file MUST start with:
```bash
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
```

If the `unset` lines are missing or at the bottom, edit the file:
```bash
sudo nano /etc/xrdp/startwm.sh
```

#### Secondary Solutions

**Clean Environment Variables:**
```bash
# Remove conflicting X authority
rm -f ~/.Xauthority

# Clear any existing DISPLAY variables
unset DISPLAY
```

**Restart Services:**
```bash
sudo systemctl restart xrdp
sudo systemctl status xrdp
```

### Connection Refused or Cannot Connect

#### Check Network Configuration
```bash
# Get WSL IP address
hostname -I

# Verify xRDP is listening on port 3389
sudo netstat -tlnp | grep :3389
sudo ss -tlnp | grep :3389
```

#### Windows Firewall Issues
Run in Windows PowerShell as Administrator:
```powershell
New-NetFirewallRule -DisplayName "WSL2 RDP" -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow
```

#### Service Not Running
```bash
# Check if xRDP service is active
sudo systemctl is-active xrdp

# Start if not active
sudo systemctl start xrdp

# Enable for automatic startup
sudo systemctl enable xrdp
```

### Wayland Display Errors

**Symptoms:**
```
cannot open display: wayland-0
```

**Solutions:**
1. **Correct .xsession file:**
```bash
echo xfce4-session > ~/.xsession
cat ~/.xsession  # Should only show: xfce4-session
```

2. **Do NOT set DISPLAY manually** in .bashrc or .profile

3. **Verify startwm.sh has unset commands at the top**

### Permission Denied Errors

**Log Entry Example:**
```
[ERROR] Cannot read private key file /etc/xrdp/key.pem: Permission denied
```

**Solutions:**
```bash
# Fix xRDP certificate permissions
sudo chown xrdp:xrdp /etc/xrdp/rsakeys.ini
sudo chmod 600 /etc/xrdp/rsakeys.ini

# Regenerate certificates if needed
sudo rm /etc/xrdp/rsakeys.ini
sudo systemctl restart xrdp
```

### Multiple Session Conflicts

**Check for Existing Sessions:**
```bash
who                    # Check logged in users
ps aux | grep xfce     # Check XFCE processes  
ps aux | grep Xorg     # Check X sessions
```

**Kill Conflicting Processes:**
```bash
# Kill XFCE processes (be careful!)
pkill -f xfce

# Kill specific Xorg sessions
sudo pkill -f "Xorg.*:11"
```

### Window Manager Exits Quickly

**Log Symptoms:**
```
Window manager (pid ... display 11) exited quickly (0 secs). 
This could indicate a window manager config problem
```

**Solutions:**
```bash
# Check session errors
tail -n 20 ~/.xsession-errors

# Reinstall XFCE if corrupted
sudo apt install --reinstall xfce4

# Test XFCE startup manually
DISPLAY=:1 xfce4-session
```

## Log Analysis and Debugging

### Key Log Files

```bash
# Main xRDP log
/var/log/xrdp.log

# Session manager log  
/var/log/xrdp-sesman.log

# User session errors
~/.xsession-errors
```

### Reading Logs After Connection Attempt

```bash
# View recent log entries
tail -n 40 /var/log/xrdp.log
tail -n 40 /var/log/xrdp-sesman.log
tail -n 40 ~/.xsession-errors
```

### Critical Error Patterns

#### 1. Permission Denied for Private Key
```
[ERROR] Cannot read private key file /etc/xrdp/key.pem: Permission denied
```
**Analysis:** Not fatal - session continues with basic RDP.

#### 2. Window Manager Exit  
```
Window manager (pid ... display 11) exited quickly (0 secs)
```
**Analysis:** Root cause - desktop session failing to start.

#### 3. Wayland Display Error
```
cannot open display: wayland-0
```
**Analysis:** XFCE trying to connect to wayland-0 instead of X11 display.

#### 4. Session Termination
```
Session terminated for user [username] with no visible errors
```
**Analysis:** Check .xsession-errors for details.

### Advanced Debugging Steps

#### Enable Verbose Logging
```bash
sudo nano /etc/xrdp/xrdp.ini
```

Change log level:
```ini
[Globals]
LogLevel=DEBUG
```

Restart xRDP:
```bash
sudo systemctl restart xrdp
```

#### Monitor Logs in Real-Time
```bash
# Terminal 1: Watch xRDP log
sudo tail -f /var/log/xrdp.log

# Terminal 2: Watch session manager log  
sudo tail -f /var/log/xrdp-sesman.log

# Terminal 3: Watch user session errors
tail -f ~/.xsession-errors
```

#### Check Environment Variables
```bash
echo $DISPLAY
echo $DBUS_SESSION_BUS_ADDRESS
echo $XDG_RUNTIME_DIR
env | grep -E "(DISPLAY|DBUS|XDG|WAYLAND)"
```

#### Process Analysis
```bash
# Check for conflicts
ps aux | grep -E "(xfce|xrdp|Xorg)"

# Check listening ports
sudo netstat -tlnp | grep :3389

# Check system resources
top
free -h
df -h
```

### Successful vs Failed Connection Patterns

#### Successful Connection Log Pattern
```
[INFO ] starting Xorg session...
[INFO ] Session running
[INFO ] xfce4-session started successfully
```

#### Failed Connection Patterns

**Pattern 1: Missing startwm.sh Configuration**
```
[ERROR] Window manager exited quickly
[ERROR] cannot open display: wayland-0
```

**Pattern 2: Permission Issues**
```
[ERROR] Permission denied accessing /tmp/.ICE-unix
[ERROR] Cannot create ICE directory
```
*Solution:*
```bash
sudo chmod 1777 /tmp/.ICE-unix
sudo rm -rf ~/.ICE-unix
```

**Pattern 3: Display Conflicts**
```
[ERROR] display :11 already in use
[ERROR] Fatal server error: Server is already active
```
*Solution:*
```bash
sudo pkill -f "Xorg.*:11"
sudo systemctl restart xrdp
```

## Performance Optimization

### xRDP Performance Settings

Edit `/etc/xrdp/xrdp.ini`:
```bash
sudo nano /etc/xrdp/xrdp.ini
```

Add/modify these settings:
```ini
[Globals]
bitmap_cache=true
bitmap_compression=true
bulk_compression=true
max_bpp=32
tcp_keepalive=true
tcp_send_buffer_bytes=32768
tcp_recv_buffer_bytes=32768
```

### XFCE Performance Settings

```bash
# Disable compositor for better performance
xfconf-query -c xfwm4 -p /general/use_compositing -s false

# Reduce window effects
xfconf-query -c xfwm4 -p /general/show_popup_shadow -s false
```

---

**Previous Guide:** [Setup and Configuration](./WSL_RDP_Setup_Guide.md)  
**Next Guide:** [Management and Advanced Configuration](./WSL_RDP_Management_Guide.md)