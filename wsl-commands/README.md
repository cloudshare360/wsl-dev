# WSL Commands Reference

> 🌐 **Best Viewing Experience:** [GitHub Pages Site](https://cloudshare360.github.io/wsl-dev/) | 📂 **Source:** [GitHub Repository](https://github.com/cloudshare360/wsl-dev)

Welcome to the comprehensive WSL (Windows Subsystem for Linux) commands reference. This documentation is organized by categories for easy navigation and quick access to the commands you need.

## 📋 Quick Navigation

### Core Categories
- **[📦 Installation & Setup](installation.md)** - Installing WSL, updating versions, and initial setup
- **🐧 Distribution Management](distributions.md)** - Managing Linux distributions (list, install, uninstall)
- **🚀 Usage & Launch](usage.md)** - Starting distributions, logging in, and basic operations
- **🔧 Advanced Commands](advanced.md)** - Advanced WSL configurations and power-user commands
- **🩺 Troubleshooting](troubleshooting.md)** - Common issues, solutions, and diagnostic commands

### Specialized Guides
- **[🖥️ WSL with RDP](../wsl-with-rdp/WSL-RDP-Master-Guide.md)** - Complete guide for GUI desktop via RDP

## 🔄 Quick Command Reference

| Action | Command | Category |
|--------|---------|----------|
| Install WSL | `wsl --install` | [Installation](installation.md) |
| List online distros | `wsl --list --online` | [Distributions](distributions.md) |
| List installed distros | `wsl --list --verbose` | [Distributions](distributions.md) |
| Launch default distro | `wsl` | [Usage](usage.md) |
| Launch specific distro | `wsl -d <DistroName>` | [Usage](usage.md) |
| Uninstall distro | `wsl --unregister <DistroName>` | [Distributions](distributions.md) |

## 📚 Getting Started

If you're new to WSL, start with:
1. [Installation & Setup](installation.md) - Get WSL running on your system
2. [Distribution Management](distributions.md) - Install your preferred Linux distribution
3. [Usage & Launch](usage.md) - Learn how to work with your WSL environment

## 🆘 Need Help?

- Check the [Troubleshooting](troubleshooting.md) section for common issues
- For advanced configurations, see [Advanced Commands](advanced.md)
- Run `wsl --help` in your terminal for built-in help

## 📖 External Resources

- [Microsoft WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/)
- [WSL GitHub Repository](https://github.com/microsoft/WSL)
- [WSL Community Forum](https://github.com/microsoft/WSL/discussions)

---

*Last updated: October 2025*