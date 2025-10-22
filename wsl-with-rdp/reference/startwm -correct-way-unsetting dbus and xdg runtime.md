<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# sri@Sri-Thinkpad:~\$ cat ~/.xsession

xfce4-session
sri@Sri-Thinkpad:~\$ cat /etc/xrdp/startwm.sh
\#!/bin/sh

# xrdp X session start script (c) 2015, 2017, 2021 mirabilos

# published under The MirOS Licence

# Rely on /etc/pam.d/xrdp-sesman using pam_env to load both

# /etc/environment and /etc/default/locale to initialise the

# locale and the user environment properly.

if test -r /etc/profile; then
. /etc/profile
fi

if test -r ~/.profile; then
. ~/.profile
fi

test -x /etc/X11/Xsession \&\& exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsession

unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR

You have the correct `unset` lines in `/etc/xrdp/startwm.sh`, but **they are placed at the end of the script**.
**They must be at the very top—before any other commands or sourcing happens.**

***

## **What You Should Do**

1. **Edit `/etc/xrdp/startwm.sh` so the two `unset` lines are the very first lines after the shebang (`#!/bin/sh`):**
```sh
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
# xrdp X session start script (c) 2015, 2017, 2021 mirabilos
# published under The MirOS Licence

# Rely on /etc/pam.d/xrdp-sesman using pam_env to load both
# /etc/environment and /etc/default/locale to initialise the
# locale and the user environment properly.

if test -r /etc/profile; then
        . /etc/profile
fi

if test -r ~/.profile; then
        . ~/.profile
fi

test -x /etc/X11/Xsession && exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsession
```


***

2. **Save the file** (`Ctrl+O`, `Enter`) and **exit** (`Ctrl+X`).
3. **Restart xrdp services:**
```bash
sudo systemctl restart xrdp
sudo systemctl restart xrdp-sesman
```

4. **Clean up session artifacts again:**
```bash
rm -f ~/.Xauthority
sudo rm -rf /tmp/.ICE-unix
```

5. **Shut down and restart WSL for a fresh session:**
```powershell
wsl --shutdown
```

6. **Reconnect to Ubuntu through Remote Desktop** and try logging in again.
7. **After logging in, run:**
```bash
echo $DISPLAY
```

- It should show `:10.0`, `:11.0`, etc.

***

**Summary:**
The crucial mistake was placing the `unset` lines at the end of the script—**they must go at the very top** to properly clear the environment **before** launching any other scripts or session components. This is a common cause for the "cannot open display: wayland-0" issue with xRDP + XFCE on WSL2.

**Move the lines, restart everything, and you should be able to see your XFCE desktop over RDP!**

