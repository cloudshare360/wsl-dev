Here is a Markdown document containing clear examples and explanations for the most commonly used WSL (Windows Subsystem for Linux) commands related to installation, version management, listing, installation, uninstallation, and login operations for distributions:

```markdown
# Essential WSL (Windows Subsystem for Linux) Commands

## 1. Installing WSL

Install WSL (latest version) on Windows 10/11 (requires administrator CMD/PowerShell):

```
wsl --install
```

_If you want WSL 1 specifically (less common nowadays), see Microsoft’s docs._

---

## 2. Updating WSL to the Latest Version

Upgrade to the latest version of WSL (get WSL 2 features):

```
wsl --update
```

_Check for installed version:_

```
wsl --version
```

---

## 3. Listing Available Distros Online

View all distributions available for download from the Microsoft Store:

```
wsl --list --online
# or the shorthand:
wsl -l -o
```

---

## 4. Listing Distros Installed Locally

See which Linux distributions are currently installed on your computer:

```
wsl --list --verbose
# or shorthand:
wsl -l -v
```

---

## 5. Installing a Specific Distro

Install (for example) Ubuntu:

```
wsl --install -d Ubuntu
```

_Or specify another distro name from the available list:_

```
wsl --install -d <DistroName>
```

_Install without default user (for advanced/scenario scripting):_

```
wsl --install --no-launch <DistroName>
```

---

## 6. Uninstalling/Unregistering a Distro

Remove (unregister) a specific distribution (e.g., Ubuntu):

```
wsl --unregister Ubuntu
```

**Note:** This completely deletes all data and settings for that distribution.

---

## 7. Logging in / Launching a Specific Distro

Start a specific installed distribution (e.g., Debian):

```
wsl -d Debian
```

_Or, just launch the default distro:_

```
wsl
```

---

**References:**
- [Microsoft WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/)
- Run `wsl --help` for more options.
```

Let me know if you want to expand any section or add advanced use-cases!

[1](https://vigilant-goggles-x4pjj946qqjf6v7g.github.dev/)