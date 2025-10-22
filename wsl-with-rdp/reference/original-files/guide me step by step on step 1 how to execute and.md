<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# guide me step by step on step 1 how to execute and verify  "1. Do Not Set DISPLAY Manually"

then guide me for sub-sequent steps

Let's go step-by-step to make sure no manual `DISPLAY` variable is interfering with your xRDP graphical environment. We'll check the relevant shell configuration files, remove any problematic lines, and then confirm the correct display is being used.

***

## **Step 1: Do Not Set DISPLAY Manually**

### **1. Check your shell configuration files for DISPLAY settings**

Run each of these commands in your WSL terminal:

```bash
grep DISPLAY ~/.bashrc

grep DISPLAY ~/.profile

grep DISPLAY /etc/environment
```


#### **If you see any lines like these:**

```
export DISPLAY=:0
export DISPLAY=wayland-0
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
```

That means you have a manual DISPLAY override — these must be removed because xRDP sessions set their own correct DISPLAY.

### **2. Edit and remove those lines if found**

If, for example, `grep` shows a result inside `.bashrc`, open that file:

```bash
nano ~/.bashrc
```

- Find any line with `DISPLAY=` or `export DISPLAY=`.
- Delete those lines.
- Save (press `Ctrl+O`, then `Enter`, then `Ctrl+X` to exit).

Repeat the same for `.profile` and `/etc/environment` if `grep` shows any such entries.

### **3. Verify no DISPLAY exports remain**

After editing, re-run your checks:

```bash
grep DISPLAY ~/.bashrc ~/.profile /etc/environment
```

If nothing prints, it means all manual DISPLAY exports are gone — perfect.

### **4. Restart to clear environment cache**

Shut down your WSL instance completely:

```powershell
wsl --shutdown
```

Then reopen Ubuntu and your RDP session.

### **5. Verify that xRDP sets its own DISPLAY**

After connecting through RDP to Ubuntu, run:

```bash
echo $DISPLAY
```

✅ **Expected result:** something like `:10.0` or `:11.0`
❌ **Wrong:** `wayland-0` or hard-coded IP like `172....:0.0`

This confirms xRDP is correctly assigning its own Xorg display.

***

## **Next Steps (After Step 1)**

Once you’ve confirmed your DISPLAY variable isn’t manually set, continue in order:

### **Step 2: Check .xsession and .xsessionrc**

Run:

```bash
cat ~/.xsession
```

Output should be exactly:

```
xfce4-session
```

If not, fix it:

```bash
echo xfce4-session > ~/.xsession
```


### **Step 3: Verify startwm.sh**

Open:

```bash
sudo nano /etc/xrdp/startwm.sh
```

Make sure the first two lines are:

```bash
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
```

Then save (`Ctrl+O`, `Enter`, `Ctrl+X`).
Restart xrdp:

```bash
sudo systemctl restart xrdp
sudo systemctl restart xrdp-sesman
```


### **Step 4: Remove leftover display auth files**

```bash
rm -f ~/.Xauthority
sudo rm -rf /tmp/.ICE-unix
```


### **Step 5: Restart and reconnect**

Completely reset your WSL2 environment:

```powershell
wsl --shutdown
```

Then reconnect via Remote Desktop. After logging in again, verify the current session:

```bash
echo $DISPLAY
```

It should now read something like `:11.0` — meaning your XFCE session runs on the proper Xorg display under xRDP, not Wayland.

***

Once these steps are complete, your RDP-based XFCE4 Ubuntu desktop will always launch under the correct Xorg display and stay stable.

