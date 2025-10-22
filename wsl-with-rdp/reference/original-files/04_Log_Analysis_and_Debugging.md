# 04 - Log Analysis and Debugging

## Understanding xRDP Logs

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

After attempting RDP connection, run:

```bash
# View last 40 lines of each log
tail -n 40 /var/log/xrdp.log
tail -n 40 /var/log/xrdp-sesman.log
tail -n 40 ~/.xsession-errors
```

## Critical Error Patterns

### 1. Permission Denied for Private Key

**Log Entry:**
```
[ERROR] Cannot read private key file /etc/xrdp/key.pem: Permission denied
```

**Analysis:** Security protocol for RDP TLS fallback - this is **NOT FATAL**. The session continues with basic RDP.

### 2. Window Manager Exit

**Log Entry:**
```
Window manager (pid ... display 11) exited quickly (0 secs). 
This could indicate a window manager config problem
```

**Analysis:** This is often the **ROOT CAUSE**! The full desktop session (xfce4-session) is failing to start or crashing immediately.

### 3. Wayland Display Error

**Log Entry:**
```
cannot open display: wayland-0
```

**Analysis:** XFCE is trying to connect to "wayland-0" instead of the X11 display opened by xrdp (like `:11.0`).

### 4. Session Termination

**Log Entry:**
```
Session terminated for user [username] with no visible errors
```

**Analysis:** Session closed without clear error message - check .xsession-errors for details.

## Debugging Steps

### Step 1: Enable Verbose Logging

Edit `/etc/xrdp/xrdp.ini`:

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

### Step 2: Monitor Logs in Real-Time

Open multiple terminals and run:

```bash
# Terminal 1: Watch xRDP log
sudo tail -f /var/log/xrdp.log

# Terminal 2: Watch session manager log
sudo tail -f /var/log/xrdp-sesman.log

# Terminal 3: Watch user session errors
tail -f ~/.xsession-errors
```

Then attempt RDP connection and observe logs.

### Step 3: Check Environment Variables

```bash
# Check current display
echo $DISPLAY

# Check DBUS session
echo $DBUS_SESSION_BUS_ADDRESS

# Check XDG runtime
echo $XDG_RUNTIME_DIR

# List all environment variables
env | grep -E "(DISPLAY|DBUS|XDG|WAYLAND)"
```

### Step 4: Process Analysis

```bash
# Check for conflicting processes
ps aux | grep -E "(xfce|xrdp|Xorg)"

# Check listening ports
sudo netstat -tlnp | grep :3389

# Check system resources
top
free -h
df -h
```

## Common Log Patterns and Solutions

### Successful Connection Pattern

```
[INFO ] starting Xorg session...
[INFO ] Session running
[INFO ] xfce4-session started successfully
```

### Failed Connection Patterns

#### Pattern 1: Missing startwm.sh Configuration
```
[ERROR] Window manager exited quickly
[ERROR] cannot open display: wayland-0
```
**Solution:** Fix startwm.sh with unset commands at top.

#### Pattern 2: Permission Issues
```
[ERROR] Permission denied accessing /tmp/.ICE-unix
[ERROR] Cannot create ICE directory
```
**Solution:** 
```bash
sudo chmod 1777 /tmp/.ICE-unix
sudo rm -rf ~/.ICE-unix
```

#### Pattern 3: Display Conflicts
```
[ERROR] display :11 already in use
[ERROR] Fatal server error: Server is already active
```
**Solution:**
```bash
# Kill existing X sessions
sudo pkill -f "Xorg.*:11"
sudo systemctl restart xrdp
```

## Advanced Debugging

### Manual Session Testing

Test XFCE session manually:

```bash
# Set display
export DISPLAY=:1

# Start X server (in background)
sudo X :1 &

# Test XFCE session
DISPLAY=:1 xfce4-session
```

### Strace Debugging

For advanced users, trace system calls:

```bash
# Trace xfce4-session startup
strace -f -o /tmp/xfce-trace.log xfce4-session

# Analyze the trace
grep -E "(ENOENT|EACCES|failed)" /tmp/xfce-trace.log
```

### Network Debugging

```bash
# Test RDP port connectivity
telnet $(hostname -I | awk '{print $1}') 3389

# Check routing
ip route show

# Test DNS resolution
nslookup $(hostname)
```

## Log Cleanup

### Rotate Large Logs

```bash
# Check log sizes
sudo ls -lh /var/log/xrdp*

# Rotate logs if too large
sudo logrotate -f /etc/logrotate.d/xrdp
```

### Clear Session Errors

```bash
# Clear user session error log
> ~/.xsession-errors

# Or remove completely
rm ~/.xsession-errors
```

---

**Previous:** [03 - Troubleshooting Common Issues](./03_Troubleshooting_Common_Issues.md)  
**Next:** [05 - Management and Maintenance](./05_Management_and_Maintenance.md)