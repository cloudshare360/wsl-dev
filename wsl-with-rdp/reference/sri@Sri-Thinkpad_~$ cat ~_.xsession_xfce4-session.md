<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# sri@Sri-Thinkpad:~\$ cat ~/.xsession

xfce4-session

Your `.xsession` file is **correct**—it contains only `xfce4-session`, which is exactly what is required for launching the XFCE desktop environment with xRDP.

### Summary Checklist for xRDP + XFCE in WSL2

You now have:

- XFCE installed
- `.xsession` with `xfce4-session`
- xRDP installed and running
- Likely already set the `unset` lines in `/etc/xrdp/startwm.sh`

***

#### **If you still get a blank screen via RDP:**

1. **Double check** that your `/etc/xrdp/startwm.sh` has the following as the very first two lines:

```bash
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
```

2. **Restart xrdp after editing:**

```bash
sudo systemctl restart xrdp
```

3. **Logout of other sessions** (do not be logged into the same user interactively elsewhere in another WSL terminal).
4. **Connect via RDP** (use your WSL IP address from `hostname -I`).

***

If you have done all the above and it still only shows a blank or black screen, let me know; we can check logs or try additional workarounds. Just confirm if you have added the `unset` lines to `/etc/xrdp/startwm.sh` and restarted the service.

