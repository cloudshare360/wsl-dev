<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# sri@Sri-Thinkpad:~\$ grep DISPLAY ~/.bashrc

grep DISPLAY ~/.profile

grep DISPLAY /etc/environment
sri@Sri-Thinkpad:~\$

Great! Since **none of those grep commands returned any output**, it means there are **no manual DISPLAY settings** present in your `~/.bashrc`, `~/.profile`, or `/etc/environment`.

This is exactly what you want—your xRDP session will now use its own DISPLAY assignment, and no environment variable override will interfere.

***

### **Proceed with Next Steps**

**Step 2:**
Verify `.xsession`

```bash
cat ~/.xsession
```

Should be:

```
xfce4-session
```

If not, fix with:

```bash
echo xfce4-session > ~/.xsession
```

**Step 3:**
Check `/etc/xrdp/startwm.sh`

```bash
sudo nano /etc/xrdp/startwm.sh
```

Make sure the top lines are:

```
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
```

Save and exit, then:

```bash
sudo systemctl restart xrdp
sudo systemctl restart xrdp-sesman
```

**Step 4:**
Clean up session artifacts:

```bash
rm -f ~/.Xauthority
sudo rm -rf /tmp/.ICE-unix
```

**Step 5:**
Completely shut down and restart WSL:

```powershell
wsl --shutdown
```

Reopen Ubuntu, reconnect via Remote Desktop, and verify the display on login:

```bash
echo $DISPLAY
```

**Expected:**
`:10.0`, `:11.0`, etc. (Not `wayland-0`)

You now have a clean, correct environment for launching XFCE4 via xRDP with the assigned Xorg session display.
If you follow these steps and still encounter a blank screen, let me know the exact output of the `echo $DISPLAY` command (after connecting via RDP), and we’ll move to the next diagnostic options!

