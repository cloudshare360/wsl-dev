<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# i installed with above steps, but when connected with rdp; on login getting blank screen

This is a **common issue** when using xRDP with XFCE on Ubuntu under WSL2—a successful login but then only a blank or black screen is shown. Here are the **most effective solutions** based on recent guides and troubleshooting communities:

***

## 1. **Edit the xRDP Startup Script**

Open the file `/etc/xrdp/startwm.sh` and add these lines at the very top:

```bash
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
```

So the start of your `startwm.sh` should look like:

```bash
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
# rest of the file...
```

**Save and exit.**

***

## 2. **Restart xRDP Service**

After saving the changes, restart xrdp:

```bash
sudo systemctl restart xrdp
```


***

## 3. **Check or Create .xsession File**

In your home directory, ensure you have a `.xsession` file with content:

```bash
echo xfce4-session > ~/.xsession
chmod +x ~/.xsession
```


***

## 4. **Make Sure the User is Not Logged In Locally**

If the same user is logged into the same session elsewhere (for example, via WSL terminal, console, or another xRDP connection), log out all other sessions before connecting via RDP—**only one active desktop per user can be open**.

***

## 5. **Connect with RDP Again**

Try reconnecting with Windows Remote Desktop (`mstsc`) after doing the above steps.

***

## 6. **(Optional, For Troubleshooting) Check xRDP and Xorg Logs**

- `/var/log/xrdp.log`
- `/var/log/xrdp-sesman.log`
- `/var/log/Xorg.*.log`

These can reveal desktop/permission issues.

***

## Community-Verified:

This workaround is the most referenced and confirmed fix for xRDP black/blank screens with XFCE and Ubuntu on WSL2 as of late 2025.[^1][^2][^3]

***

**Summary:**
Edit `/etc/xrdp/startwm.sh`, add the unset lines, make sure `.xsession` exists and references `xfce4-session`, restart xrdp, and ensure you only have a single login.
This should resolve the blank screen and load your XFCE desktop UI over RDP!
<span style="display:none">[^10][^11][^12][^4][^5][^6][^7][^8][^9]</span>

<div align="center">⁂</div>

[^1]: https://github.com/microsoft/WSL/issues/5719

[^2]: https://www.youtube.com/watch?v=2ZFFIy70C8Y

[^3]: https://www.scribd.com/document/893249663/WSL-Xfce4-Xrdp-Black-Screen-Fix-Guide

[^4]: https://c-nergy.be/blog/?p=16682

[^5]: https://www.reddit.com/r/Ubuntu/comments/1e9edvt/wsl2_ubuntu_remote_desktop_connection_black/

[^6]: https://forum.xfce.org/viewtopic.php?id=15896

[^7]: https://github.com/neutrinolabs/xrdp/issues/2775

[^8]: https://www.reddit.com/r/bashonubuntuonwindows/comments/1iswe9g/xrdp_not_working_black_screen/

[^9]: https://forum.level1techs.com/t/ubuntu-remote-desktop-2025/232550

[^10]: https://github.com/microsoft/wslg/issues/1338

[^11]: https://learn.microsoft.com/en-us/answers/questions/4198022/cannot-connect-to-xrdp-running-in-wsl-via-remote-d

[^12]: https://stackoverflow.com/questions/61860208/running-graphical-linux-desktop-applications-from-wsl-2-error-e233-cannot-op

