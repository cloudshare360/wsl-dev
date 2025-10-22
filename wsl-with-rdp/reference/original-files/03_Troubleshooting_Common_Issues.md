# 03 - Troubleshooting Common Issues

## Blank Screen or Immediate Logout

### Symptoms
- RDP connects but shows blank screen
- Session logs out immediately
- Connection drops after few seconds

### Primary Solution: Check startwm.sh Configuration

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

If the `unset` lines are at the bottom or missing, edit the file:

```bash
sudo nano /etc/xrdp/startwm.sh
```

### Secondary Solutions

#### Clean Environment Variables

```bash
# Remove conflicting X authority
rm -f ~/.Xauthority

# Clear any existing DISPLAY variables
unset DISPLAY
```

#### Restart Services

```bash
# Restart xRDP
sudo systemctl restart xrdp

# Check service status
sudo systemctl status xrdp
```

## Connection Refused or Cannot Connect

### Check Network Configuration

```bash
# Get WSL IP address
hostname -I

# Check if xRDP is listening on port 3389
sudo netstat -tlnp | grep :3389

# Alternative: check with ss command
sudo ss -tlnp | grep :3389
```

### Windows Firewall Issues

Run in Windows PowerShell as Administrator:

```powershell
# Allow RDP through Windows Firewall
New-NetFirewallRule -DisplayName "WSL2 RDP" -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow
```

### Service Not Running

```bash
# Check if xRDP service is active
sudo systemctl is-active xrdp

# If not active, start it
sudo systemctl start xrdp

# Enable for automatic startup
sudo systemctl enable xrdp
```

## Wayland Display Errors

### Symptoms
```
cannot open display: wayland-0
```

### Solution

This indicates XFCE is trying to connect to Wayland instead of X11. Ensure:

1. **Correct .xsession file:**
```bash
echo xfce4-session > ~/.xsession
cat ~/.xsession  # Should only show: xfce4-session
```

2. **Do NOT set DISPLAY manually in .bashrc or .profile**

3. **Verify startwm.sh has the unset commands at the top**

## Permission Denied Errors

### Log Entry Example
```
[ERROR] Cannot read private key file /etc/xrdp/key.pem: Permission denied
```

### Solutions

```bash
# Fix xRDP certificate permissions
sudo chown xrdp:xrdp /etc/xrdp/rsakeys.ini
sudo chmod 600 /etc/xrdp/rsakeys.ini

# Regenerate certificates if needed
sudo rm /etc/xrdp/rsakeys.ini
sudo systemctl restart xrdp
```

## Multiple Session Conflicts

### Check for Existing Sessions

```bash
# Check who is logged in
who

# Check for running XFCE processes
ps aux | grep xfce

# Check for existing X sessions
ps aux | grep Xorg
```

### Kill Conflicting Processes

```bash
# Kill all XFCE processes (be careful!)
pkill -f xfce

# Kill specific Xorg sessions if needed
sudo pkill -f "Xorg.*:11"
```

## Window Manager Exits Quickly

### Log Symptoms
```
Window manager (pid ... display 11) exited quickly (0 secs). 
This could indicate a window manager config problem
```

### Solutions

1. **Check .xsession-errors log:**
```bash
tail -n 20 ~/.xsession-errors
```

2. **Verify XFCE installation:**
```bash
# Reinstall XFCE if corrupted
sudo apt install --reinstall xfce4
```

3. **Test XFCE startup manually:**
```bash
# Try starting XFCE directly
DISPLAY=:1 xfce4-session
```

## Performance Issues

### Optimize xRDP Settings

Edit `/etc/xrdp/xrdp.ini`:

```bash
sudo nano /etc/xrdp/xrdp.ini
```

Add or modify these settings:

```ini
[Globals]
bitmap_cache=true
bitmap_compression=true
bulk_compression=true
max_bpp=32
```

### Reduce Desktop Effects

In XFCE desktop:
1. Go to **Settings** → **Window Manager Tweaks**
2. **Compositor** tab → Disable **Enable display compositing**
3. Restart xRDP session

---

**Previous:** [02 - Configuration and Setup](./02_Configuration_and_Setup.md)  
**Next:** [04 - Log Analysis and Debugging](./04_Log_Analysis_and_Debugging.md)