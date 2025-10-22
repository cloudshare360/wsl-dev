<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# Make sure xfce4-session isn't launched via Wayland, but takes the display from xrdp:

How to make sure above step

Here’s how to **ensure xfce4-session is launched with the correct Xorg session from xRDP—not Wayland**:

***

## 1. **Do Not Set DISPLAY Manually**

- Remove any lines like `export DISPLAY=...` from your `~/.bashrc`, `~/.profile`, or `/etc/environment`.
- Your RDP/xrdp session will set the correct `DISPLAY` automatically (usually something like `:11.0`).
**Never export `DISPLAY=wayland-0` for RDP/xrdp use!**

***

## 2. **Check the Environment During RDP Session**

After connecting with Remote Desktop and before launching anything:

```bash
echo $DISPLAY
```

- **Expected output:**
It should show something like `:11.0`, `:10.0`, or another Xorg display (not `wayland-0`).
- If you see `wayland-0`, something is wrong—likely .bashrc/.profile/.environment is forcing the value.

***

## 3. **Check .xsession and .xsessionrc**

Both should only have:

```
xfce4-session
```

Do **not** add any lines that set or export DISPLAY or any other session variable.

***

## 4. **Ensure No Conflicting WSLg or GUI Apps Running**

- **Before connecting via RDP:** Close any GUI apps launched via WSLg (outside of RDP), because those use Wayland and can cause session mixups.
- Only use one GUI environment at a time for each user.

***

## 5. **Inspect startwm.sh**

Your `/etc/xrdp/startwm.sh` should **not** set or export DISPLAY.
Just the unset lines, then launch Xsession.

***

## 6. **Delete Residual Files**

Sometimes stale files can cause confusion:

```bash
rm -f ~/.Xauthority
rm -rf /tmp/.ICE-unix
```


***

## 7. **Restart Everything**

```powershell
wsl --shutdown
```

Then reopen WSL, restart xrdp, and connect with RDP.

***

### **Summary Checklist**

- No exports or setting `DISPLAY` in any profile/script
- `.xsession` just `xfce4-session`
- On login through RDP, `$DISPLAY` is something like `:11.0`, not `wayland-0`
- No non-RDP WSLg GUI apps running concurrently

**That’s how you ensure XFCE4 runs under the correct display from xRDP/Xorg, not Wayland.**
If `$DISPLAY` is still `wayland-0` inside your RDP session, let me know your `.bashrc`, `.profile`, and any environment dumps for deeper investigation!

