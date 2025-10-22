<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# how to clean and uninstall existing wsl2 instances

To completely clean and uninstall WSL2 (Windows Subsystem for Linux) and all its distributions, you can follow these PowerShell-based and GUI-based steps to ensure no files or components remain.

***

### Step 1: List and Remove All WSL Distributions

Open **PowerShell** as Administrator and run:

```powershell
wsl --list --verbose
```

This lists all installed Linux distributions. To permanently delete each one, run:

```powershell
wsl --unregister <DistroName>
```

For example:

```powershell
wsl --unregister Ubuntu
wsl --unregister Debian
wsl --unregister docker-desktop
wsl --unregister docker-desktop-data
```

This removes the full filesystem and any user data tied to that distribution.[^1][^2]

***

### Step 2: Uninstall WSL Components via PowerShell

Run this in an elevated PowerShell window:

```powershell
Get-AppxPackage MicrosoftCorporationII.WindowsSubsystemForLinux | Remove-AppxPackage
```

This command removes the WSL kernel package from Windows.[^3][^4]
Optionally, you can remove the WSL GUI package (if installed):

```powershell
Get-AppxPackage *WindowsSubsystemForLinux-GUI* | Remove-AppxPackage
```


***

### Step 3: Disable Windows Optional Features

WSL relies on Windows components that you should disable:

```powershell
dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart
```

You may also optionally disable **Windows Hypervisor Platform** if not needed:

```powershell
dism.exe /online /disable-feature /featurename:HypervisorPlatform /norestart
```

After running these, **restart Windows** to apply all changes.[^5][^6]

***

### Step 4: Clean Remaining WSL File Data

WSL stores files for each distribution under:

```
%LOCALAPPDATA%\Packages\
```

Search for folders like:

- `CanonicalGroupLimited.Ubuntu...`
- `TheDebianProject.Debian...`
- `DockerDesktop...`

Manually delete them after unregistration to reclaim disk space.[^6]

***

### Step 5: Optional — Reinstall Clean WSL (if desired)

To start fresh later:

```powershell
wsl --install
```

Or, for a specific Linux version:

```powershell
wsl --install -d Ubuntu-24.04
```


***

This process ensures a complete wipe — removing all distributions, WSL kernel packages, and optional virtualization features, leaving your Windows system fully clean of WSL2 components.[^4][^3][^6]
<span style="display:none">[^10][^11][^12][^13][^14][^15][^16][^17][^18][^19][^7][^8][^9]</span>

<div align="center">⁂</div>

[^1]: https://learn.microsoft.com/en-us/windows/wsl/faq

[^2]: https://www.windowscentral.com/how-completely-remove-linux-distro-wsl

[^3]: https://pureinfotech.com/uninstall-wsl-windows-11/

[^4]: https://www.youtube.com/watch?v=6B4DromZhoA

[^5]: https://github.com/microsoft/WSL/discussions/6959

[^6]: https://synchronet.net/how-to-uninstall-wsl/

[^7]: https://www.reddit.com/r/wsl2/comments/1gaq8f7/how_to_start_fresh_with_wslubuntu/

[^8]: https://www.youtube.com/watch?v=YDNa0qcCboc

[^9]: https://gist.github.com/4wk-/889b26043f519259ab60386ca13ba91b

[^10]: https://stackoverflow.com/questions/51584765/how-do-you-install-multiple-separate-instances-of-ubuntu-in-wsl

[^11]: https://stackoverflow.com/questions/68368307/how-to-remove-wsl-distro-from-windows

[^12]: https://learn.microsoft.com/en-us/answers/questions/2120490/is-there-someway-to-forceably-completely-wipe-wsl

[^13]: https://www.ninjaone.com/blog/how-to-uninstall-wsl-distro-in-windows-11/

[^14]: https://learn.microsoft.com/en-us/windows/wsl/basic-commands

[^15]: https://www.youtube.com/watch?v=xftSZRA7exc

[^16]: https://www.reddit.com/r/Windows11/comments/1hb5n60/how_do_i_completly_uninstall_wsl/

[^17]: https://www.reddit.com/r/bashonubuntuonwindows/comments/woq3wa/wsl2_removal_questions/

[^18]: https://answers.microsoft.com/en-us/windows/forum/all/i-cant-uninstall-wsl-from-windows-11/b884feff-d93f-4e3f-9012-97b87aab3576

[^19]: https://www.reddit.com/r/WindowsHelp/comments/1ga3olr/how_can_i_completely_uninstall_wsl_and/

