<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# sri@Sri-Thinkpad:~\$ echo \$DISPLAY

:0

Your environment variable `DISPLAY=:0` confirms that WSLg is managing the Linux GUI display for your WSL2 session. This is the **expected setup for Windows 11 and WSL2 with GUI support**.

### What This Means

- **WSLg is active:** You do **not** need to manually set up or modify your DISPLAY variable.
- You should **launch individual GUI applications** (e.g. `xfce4-terminal`, `thunar`, `mousepad`, `gedit`) directly from your terminal.
- These apps will open as native windows in your Windows desktop environment—fully GPU accelerated, Alt+Tab compatible, and clipboard integrated.

***

### Best Practice

- **For WSLg / WSL2 setup:**
Do **not** launch `startxfce4` or any full desktop session.
Instead, run each desired GUI program independently, like:

```bash
xfce4-terminal &
thunar &
mousepad &
```

- This is the most stable and performant workflow for WSL2-based Ubuntu desktop development.

***

**You are set up correctly for cloud developer tasks in Ubuntu via WSL2 on Windows!** If you’d like shortcuts, workflow tips, or automation scripts for this setup, let me know.

