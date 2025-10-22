# Node.js Development Environment

> 🟨 **Node.js Stack** | ⏱️ **10 minutes** | 📦 **npm, nvm, TypeScript, modern tools**

## 📋 Overview

Set up a complete Node.js development environment using NVM (Node Version Manager) for version management, along with modern JavaScript/TypeScript development tools and popular frameworks.

## 🎯 What You'll Get

- **Node.js** latest LTS version via NVM
- **npm** Node package manager
- **nvm** Node Version Manager for multiple Node versions
- **TypeScript** Modern JavaScript with type safety
- **Development tools** ESLint, Prettier, testing utilities
- **Build tools** Modern bundlers and development servers

---

## 📋 Prerequisites

Before starting, ensure you have:
- ✅ [Essential Tools](../01-system-setup/essential-tools.md) installed
- ✅ Internet connectivity

---

## 🚀 Installation Steps

### Step 1: Install NVM (Node Version Manager)

```bash
# Download and install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Reload shell configuration to use NVM
source ~/.bashrc

# Verify NVM installation
nvm --version
```

### Step 2: Install Node.js via NVM

```bash
# Install latest LTS version of Node.js
nvm install --lts

# Use the LTS version
nvm use --lts

# Set LTS as default
nvm alias default lts/*

# Verify installations
node --version
npm --version
```

### Step 3: Install Global Development Tools

```bash
# Install TypeScript and development tools globally
npm install -g \
    typescript \
    ts-node \
    eslint \
    prettier \
    nodemon \
    pm2 \
    serve \
    http-server

# Verify TypeScript installation
tsc --version
```

### Step 4: Install Build and Development Tools

```bash
# Install modern build tools and utilities
npm install -g \
    webpack \
    webpack-cli \
    vite \
    parcel \
    rollup \
    yarn \
    pnpm

# Verify installations
webpack --version
vite --version
yarn --version
```

### Step 5: Configure npm for Development

```bash
# Set npm registry (default is usually fine)
npm config set registry https://registry.npmjs.org/

# Configure npm init defaults (optional)
npm config set init.author.name "Your Name"
npm config set init.author.email "your.email@example.com"
npm config set init.license "MIT"

# View npm configuration
npm config list
```

---

## ✅ Verification

### Test Node.js Installation

```bash
# Check Node.js and npm versions
node --version
npm --version
nvm --version

# Test Node.js with simple script
node -e "console.log('Node.js is working! Version:', process.version)"

# List installed global packages
npm list -g --depth=0
```

### Test NVM Functionality

```bash
# List available Node.js versions
nvm list-remote --lts

# List installed versions
nvm list

# Test installing another version (optional)
# nvm install 18
# nvm use 18
# nvm use default
```

### Test Development Tools

```bash
# Create test project directory
mkdir -p ~/nodejs-test
cd ~/nodejs-test

# Initialize npm project
npm init -y

# Install test dependency
npm install express

# Create simple test script
cat > index.js << 'EOF'
const express = require('express');
const app = express();
const port = 3001;

app.get('/', (req, res) => {
    res.json({
        message: 'Hello from Node.js!',
        version: process.version,
        timestamp: new Date().toISOString()
    });
});

app.listen(port, '0.0.0.0', () => {
    console.log(`Server running at http://localhost:${port}`);
});
EOF

# Test TypeScript
echo 'console.log("TypeScript is working!");' > test.ts
tsc test.ts
node test.js
```

---

## 🛠️ Development Workflows

### Creating New Projects

```bash
# Standard npm project
mkdir my-node-project
cd my-node-project
npm init -y

# TypeScript project
mkdir my-ts-project
cd my-ts-project
npm init -y
npm install -D typescript @types/node
npx tsc --init
```

### Package Management

```bash
# Install dependencies
npm install package-name
npm install -D dev-package-name    # Development dependency
npm install -g global-package      # Global installation

# Update packages
npm update
npm outdated                       # Check for outdated packages

# Remove packages
npm uninstall package-name
```

### Using Different Node Versions

```bash
# Install specific Node version
nvm install 18.17.0

# Switch between versions
nvm use 18.17.0
nvm use default

# Run command with specific version
nvm exec 18.17.0 node --version
```

---

## 🎯 Common Node.js Commands

### Development Scripts

```bash
# Common package.json scripts
{
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js",
    "build": "tsc",
    "test": "jest",
    "lint": "eslint .",
    "format": "prettier --write ."
  }
}

# Run scripts
npm start
npm run dev
npm test
```

### Process Management with PM2

```bash
# Start application with PM2
pm2 start index.js --name "my-app"

# List running processes
pm2 list

# Stop/restart application
pm2 stop my-app
pm2 restart my-app

# View logs
pm2 logs my-app

# Stop all processes
pm2 stop all
```

---

## 🎨 Sample Projects

### Express.js API Server

```bash
# Create Express API project
mkdir ~/express-api-demo
cd ~/express-api-demo

# Initialize project and install dependencies
npm init -y
npm install express cors helmet morgan
npm install -D nodemon

# Create server file
cat > server.js << 'EOF'
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(helmet());
app.use(cors());
app.use(morgan('combined'));
app.use(express.json());

// Routes
app.get('/api/health', (req, res) => {
    res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

app.get('/api/users', (req, res) => {
    res.json({
        users: [
            { id: 1, name: 'Alice', role: 'admin' },
            { id: 2, name: 'Bob', role: 'user' }
        ]
    });
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
EOF

# Update package.json scripts
npm pkg set scripts.start="node server.js"
npm pkg set scripts.dev="nodemon server.js"

# Run development server
npm run dev
```

### TypeScript Project

```bash
# Create TypeScript project
mkdir ~/typescript-demo
cd ~/typescript-demo

# Initialize project
npm init -y
npm install -D typescript @types/node ts-node

# Create TypeScript config
npx tsc --init

# Create TypeScript file
cat > src/index.ts << 'EOF'
interface User {
    id: number;
    name: string;
    email: string;
}

class UserService {
    private users: User[] = [
        { id: 1, name: 'Alice', email: 'alice@example.com' },
        { id: 2, name: 'Bob', email: 'bob@example.com' }
    ];

    getUsers(): User[] {
        return this.users;
    }

    getUserById(id: number): User | undefined {
        return this.users.find(user => user.id === id);
    }
}

const userService = new UserService();
console.log('All users:', userService.getUsers());
console.log('User 1:', userService.getUserById(1));
EOF

# Create source directory
mkdir -p src

# Add build scripts to package.json
npm pkg set scripts.build="tsc"
npm pkg set scripts.start="node dist/index.js"
npm pkg set scripts.dev="ts-node src/index.ts"

# Run TypeScript
npm run dev
```

---

## 🚨 Troubleshooting

### NVM Issues

```bash
# Reload NVM
source ~/.bashrc

# Reinstall NVM if needed
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Check NVM installation directory
ls -la ~/.nvm
```

### npm Permission Issues

```bash
# Fix npm permissions (avoid using sudo with npm)
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### Package Installation Issues

```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and reinstall
rm -rf node_modules package-lock.json
npm install

# Check npm configuration
npm config list
```

### Port Already in Use

```bash
# Find process using port 3000
lsof -i :3000

# Kill process using port
kill -9 $(lsof -t -i:3000)

# Or use different port
PORT=3001 npm start
```

---

## 🔗 Next Steps

Now that Node.js is set up, you can:

1. **[Install Frontend Frameworks](../05-frontend-frameworks/)** - React, Angular, or Next.js
2. **[Install Java](./java.md)** - Add Java development (optional)
3. **[Setup Development Tools](../07-development-tools/)** - Add databases, API testing
4. **[Install Docker](../03-containers/docker.md)** - Containerize Node.js applications

---

**🟨 Node.js development environment is ready!**

> 💡 **Quick Start:** Create a new project with `npm init -y` and start building!