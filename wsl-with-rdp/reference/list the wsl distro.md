<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# list the wsl distro

To list your current Windows Subsystem for Linux (WSL) distributions, you can use specific `wsl` commands from PowerShell or Command Prompt.

### Listing Installed Distributions

To see which Linux distros you have installed:

```
wsl --list --verbose
```

or equivalently:

```
wsl -l -v
```

This will show each distribution’s name, version (WSL 1 or WSL 2), and running state (Stopped/Running).[^3][^7][^8]

### Listing All Available Online Distributions

To see which distributions are **available to install** from Microsoft Store:

```
wsl --list --online
```

or

```
wsl -l -o
```

This lists all official WSL distros that can be installed on your system.[^1][^6]

### Common WSL Distros

According to the current Microsoft listing, typical WSL-compatible Linux distributions include :[^5]

- Ubuntu (22.04, 20.04, 18.04, 16.04, and Community Preview)
- Debian
- Kali Linux
- AlmaLinux
- Fedora
- openSUSE Leap and Tumbleweed
- Alpine Linux
- Oracle Linux
- Pengwin
- SUSE Linux Enterprise Server
- Amazon Linux
- Arch Linux (via community tools)


### Additional Commands

- To see only **running** distros:

```
wsl --list --running
```

- To set a default distro:

```
wsl --set-default <DistroName>
```


These commands work across Windows 10 and Windows 11 systems that have WSL2 support enabled.[^7][^8][^3]
<span style="display:none">[^2][^4][^9]</span>

<div align="center">⁂</div>

[^1]: https://learn.microsoft.com/en-us/windows/wsl/basic-commands

[^2]: https://stackoverflow.com/questions/74740375/how-to-list-out-all-the-distros-available-in-windows-subsystem-for-linux-in-wind

[^3]: https://www.elevenforum.com/t/list-installed-windows-subsystem-for-linux-wsl-distros-in-windows-11.12200/

[^4]: https://www.reddit.com/r/bashonubuntuonwindows/comments/1co100t/wsl_recommended_distribution/

[^5]: https://github.com/sirredbeard/awesome-wsl

[^6]: https://winaero.com/list-available-wsl-linux-distros-windows-10/

[^7]: https://learn.microsoft.com/en-us/windows/wsl/install

[^8]: https://pureinfotech.com/list-installed-wsl-distros-windows-11/

[^9]: https://www.devopsschool.com/blog/list-of-commands-for-wsl/

