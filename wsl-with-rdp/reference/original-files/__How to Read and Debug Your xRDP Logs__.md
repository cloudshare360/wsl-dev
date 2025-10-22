<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

### **How to Read and Debug Your xRDP Logs**

#### 1. **Understanding the Log**

- **Key signals of failure shown:**
    - `[ERROR] Cannot read private key file /etc/xrdp/key.pem: Permission denied`
        - → Security protocol for RDP TLS fallback: this is not fatal—the session continues with basic RDP.
    - `Window manager (pid ... display 11) exited quickly (0 secs). This could indicate a window manager config problem`
        - → **This is often the root cause!** The full desktop session (xfce4-session) is failing to start or crashing immediately.
    - Session is "terminated" for your user with no visible errors before the exit.
    - `cannot open display: wayland-0:` in `.xsession-errors` log file
        - → Your xfce4-session is trying to connect to "wayland-0", not to the X11 display opened by xrdp.


#### 2. **What To Look For**

- Check that `xfce4-session` is starting with the correct display—**should be X11** (like `:11.0`), **not** `wayland-0`.
- See if there are permission (owned by root or missing) or configuration issues in `/tmp/.ICE-unix` or `$HOME/.Xauthority`.
- Watch for duplicate running dbus, gpg-agent, or previous desktop/XFCE/Xorg instances that may block new sessions.

***

### **Why the Issue Happens**

- **XFCE is being launched with the wrong display (wayland-0) instead of the X11 display started by xrdp/Xorg.**
- WSLg is creating display assignments (`wayland-0`) for native GUI apps, while xrdp expects/starts its own Xorg server on a separate display (like `:11.0`).
- Sometimes, DBUS/X authority variables leak from previous WSLg/native sessions, confusing the desktop environment.

***

## **Actionable Steps to Fix**

#### **A. Clean Up Environment and .Xauthority**

1. **Delete any conflicting `.Xauthority` file:**

```bash
rm -f ~/.Xauthority
```

2. **Make sure xfce4-session isn't launched via Wayland, but takes the display from xrdp:**
    - Your `.xsession` should only contain:

```
xfce4-session
```

    - Do NOT set `DISPLAY` manually or export it in `.profile` or `.bashrc`.

#### **B. Ensure startwm.sh Script is Correct**

Open `/etc/xrdp/startwm.sh`, and make sure it’s exactly like this at the top:

```bash
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
```

- Do **not** export or set `DISPLAY` anywhere here!


#### **C. Restart xrdp Cleanly**

```bash
sudo systemctl restart xrdp
sudo systemctl restart xrdp-sesman
```


#### **D. Shut Down and Clean WSL**

Shut down all running WSL sessions:

```powershell
wsl --shutdown
```

Then reopen Ubuntu and retry connecting.

#### **E. Start With a Fresh RDP Connection**

- Ensure NO WSLg GUI apps are running outside of RDP (close any Windows-opened Linux GUIs first).
- Launch **only one** RDP session at a time.

***

### **Expert Note:**

- Do **not** attempt to use both WSLg and xRDP/Xorg sessions at the exact same time on the same user account—display environments will conflict.
- If you ever edited `.bashrc`, `.profile`, or `/etc/environment` to set `DISPLAY`, remove those lines.

***

### **What Would Be Most Relevant in This Log (For Future Debugging):**

- Any `[ERROR]` messages after “starting window manager” about session, permissions, or files.
- Exit codes from Xorg and xfce4-session.
- Any mention of “cannot open display” (should match your assigned xrdp/Xorg display like `:11.0`).

***

**Summary:**
Your core issue is XFCE4 launching with Wayland instead of the Xorg session from xrdp.
**Fix: Wipe `.Xauthority`, never set `DISPLAY` values by hand, ensure startwm.sh only unsets environment variables, and always cleanly shut down all WSL and GUI apps between session types.**

If this still does not resolve it, let me know! We can try a minimal `.xsession` script or switch to a vanilla `.xinitrc` for advanced debug.

