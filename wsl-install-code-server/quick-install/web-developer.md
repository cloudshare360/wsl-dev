# Web Developer Quick Install

> 🚀 **One-Click Setup** | ⏱️ **30 minutes** | 💻 **Node.js + React + Code-Server**

## 📋 What Gets Installed

This script installs everything needed for modern web development:

- ✅ **Essential System Tools** (curl, wget, git, build tools)
- ✅ **Code-Server** (VS Code in browser, port 3000, no password)
- ✅ **Node.js** (via NVM, latest LTS)
- ✅ **React Development** (Create React App, TypeScript)
- ✅ **Development Tools** (ESLint, Prettier, testing tools)

## 🚀 Quick Installation

### Option 1: One-Command Install

```bash
# Download and run the complete web developer setup
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/quick-install/web-developer.sh | bash
```

### Option 2: Manual Step-by-Step

```bash
# 1. Essential Tools (5 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/01-system-setup/essential-tools.md | bash

# 2. Code-Server (10 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/02-code-server/installation.md | bash

# 3. Node.js (10 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/04-programming-languages/nodejs.md | bash

# 4. React Setup (5 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/05-frontend-frameworks/react.md | bash
```

## ✅ After Installation

### Access Your Development Environment

1. **Get your WSL IP address:**
   ```bash
   ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
   ```

2. **Open in browser:**
   - `http://YOUR_WSL_IP:3000`

3. **Create your first React app:**
   ```bash
   npx create-react-app my-app
   cd my-app
   npm start
   ```

### Verify Installation

```bash
# Run verification script
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/08-troubleshooting/verification.md | bash
```

## 🎯 What's Included

| Component | Version | Purpose |
|-----------|---------|---------|
| **Code-Server** | Latest | Browser-based VS Code |
| **Node.js** | LTS | JavaScript runtime |
| **npm** | Latest | Package manager |
| **React** | Latest | Frontend framework |
| **TypeScript** | Latest | Type-safe JavaScript |
| **ESLint** | Latest | Code linting |
| **Prettier** | Latest | Code formatting |

## 🔗 Next Steps

After installation, you can:

1. **[Add Docker](../03-containers/docker.md)** - Containerization
2. **[Add Python](../04-programming-languages/python.md)** - Backend development
3. **[Add Database Tools](../07-development-tools/database-tools.md)** - Data persistence
4. **[Add API Testing](../07-development-tools/api-testing.md)** - API development

---

**🎉 Web development environment ready in 30 minutes!**