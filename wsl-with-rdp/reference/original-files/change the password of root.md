<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# change the password of root

To change or reset the **root password in WSL2 (Ubuntu or any WSL distro)**, you can do it easily using PowerShell. Follow these exact steps:

***

### Step 1: Open PowerShell as Administrator

From the Start Menu, search for **PowerShell**, right-click, and select **Run as administrator**.[^1][^2]

***

### Step 2: Launch WSL as the Root User

Run the following command (replace `Ubuntu` with your distro name, such as `Ubuntu-20.04`, `Debian`, or `kali-linux`):

```powershell
wsl -d Ubuntu -u root
```

This opens a root shell inside your WSL environment.[^3][^4]

***

### Step 3: Change the Root Password

Once inside WSL, run:

```bash
passwd
```

This will prompt you to set a new password for the **root** account.
When typing, nothing will appear on screen — that’s normal. Just press Enter after each entry.[^2][^5]

***

### Step 4: (Optional) Change Another User’s Password

If you want to reset a regular user’s password instead of root, list users:

```bash
ls /home
```

Then change the desired user’s password:

```bash
passwd username
```

Replace *username* with your user’s name.[^6][^1]

***

### Step 5: Exit and Test

Type:

```bash
exit
```

Then start your WSL normally (without specifying `-u root`) to confirm the new password works when using `sudo`.[^4][^3]

***

This method works for all WSL2 distributions (Ubuntu, Debian, Kali, Fedora, etc.), and does not require reinstalling or resetting the distro. The **root account in WSL2 has no password by default**, so you can always regain access via the `-u root` flag.[^6][^2]
<span style="display:none">[^10][^11][^12][^13][^7][^8][^9]</span>

<div align="center">⁂</div>

[^1]: https://veerasundar.com/blog/how-to-change-wsl-user-password

[^2]: https://techybuff.com/how-to-reset-ubuntu-password-wsl/

[^3]: https://www.linkedin.com/pulse/how-reset-forgotten-password-ubuntu-wsl-step-by-step-guide-bira-ysg0f

[^4]: https://www.jamestharpe.com/wsl-root-password/

[^5]: https://learn.microsoft.com/en-us/windows/wsl/setup/environment

[^6]: https://itsfoss.com/reset-linux-password-wsl/

[^7]: https://www.reddit.com/r/bashonubuntuonwindows/comments/1h6x94m/password_for_the_ubuntu_wsl2_user/

[^8]: https://www.youtube.com/watch?v=Cun059gxoIE

[^9]: https://www.reddit.com/r/linuxquestions/comments/198otpq/sudo_password_in_wsl/

[^10]: https://www.youtube.com/watch?v=J41P4WA5bMM

[^11]: https://www.youtube.com/watch?v=1fpc9TL5bBo

[^12]: https://www.youtube.com/watch?v=RCW9PTNS440

[^13]: https://dev.to/kristenkinnearohlmann/reset-ubuntu-password-on-windows-5e4l

