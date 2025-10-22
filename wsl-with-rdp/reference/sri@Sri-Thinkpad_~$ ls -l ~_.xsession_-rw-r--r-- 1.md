<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# sri@Sri-Thinkpad:~\$ ls -l ~/.xsession

-rw-r--r-- 1 sri sri 14 Oct 22 09:43 /home/sri/.xsession

Your output confirms that the `.xsession` file **exists** in your home directory as `/home/sri/.xsession`.
It is owned by your user (`sri`), has the correct permissions, and was last modified at 09:43.

### Next Step

Check that its content is exactly:

```
xfce4-session
```

You can view the content with:

```bash
cat ~/.xsession
```

If this line is present, you’re correctly set up for xRDP to launch the XFCE session.

If you are still seeing a blank RDP screen after this, proceed to:

- Double-check you edited `/etc/xrdp/startwm.sh` (with the `unset` lines at the top)
- Restart xrdp:

```bash
sudo systemctl restart xrdp
```

- Make sure you are not logged in as the same user locally in other sessions when connecting via RDP.

Let me know what you see in your `.xsession` file, or if you need further troubleshooting!

