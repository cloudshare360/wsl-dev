#!/bin/bash

# Web Developer Quick Install Script
# Installs everything needed for modern web development

set -e

echo "🚀 Starting Web Developer Environment Setup..."
echo "This will install: Code-Server + Node.js + React + TypeScript"
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running in WSL
if ! grep -q microsoft /proc/version; then
    print_warning "This script is designed for WSL2. Some features may not work correctly."
fi

# Configure passwordless sudo for development
print_status "Configuring passwordless sudo..."
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
sudo visudo -c

# Update system
print_status "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Add comprehensive shell configuration
print_status "Configuring development environment..."
cat >> ~/.bashrc << 'EOF'

# === WSL Development Environment Setup ===

# Essential PATH additions
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Node.js (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Development aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias ports='netstat -tuln'
alias processes='ps aux'
alias disk='df -h'
alias memory='free -h'

# Service management aliases
alias start-code='sudo systemctl start code-server'
alias stop-code='sudo systemctl stop code-server'
alias restart-code='sudo systemctl restart code-server'
alias status-code='sudo systemctl status code-server'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'

# Network debugging
alias myip='ip addr show eth0 | grep "inet " | awk "{print \$2}" | cut -d/ -f1'
alias listening='netstat -tuln | grep LISTEN'

# Node.js aliases
alias ni='npm install'
alias nr='npm run'
alias ns='npm start'
alias nt='npm test'
alias nb='npm run build'

EOF

source ~/.bashrc

# Install essential tools
print_status "Installing essential system tools..."
sudo apt install -y curl wget git build-essential software-properties-common \
    apt-transport-https ca-certificates gnupg lsb-release unzip zip \
    tree htop neofetch net-tools

# Install Code-Server
print_status "Installing Code-Server..."
curl -fsSL https://code-server.dev/install.sh | sh

# Configure Code-Server
print_status "Configuring Code-Server..."
mkdir -p ~/.config/code-server

cat > ~/.config/code-server/config.yaml << EOF
bind-addr: 0.0.0.0:3000
auth: none
password: 
cert: false
EOF

# Create systemd service for Code-Server
sudo tee /etc/systemd/system/code-server.service > /dev/null << EOF
[Unit]
Description=code-server
After=network.target

[Service]
Type=exec
ExecStart=/usr/bin/code-server --config ~/.config/code-server/config.yaml
Restart=always
User=$USER
Environment=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
Environment=HOME=/home/$USER

[Install]
WantedBy=multi-user.target
EOF

# Enable and start Code-Server
sudo systemctl daemon-reload
sudo systemctl enable code-server
sudo systemctl start code-server

# Install Node.js via NVM
print_status "Installing Node.js via NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

# Source NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install latest LTS Node.js
nvm install --lts
nvm use --lts
nvm alias default lts/*

# Install global development tools
print_status "Installing global Node.js development tools..."
npm install -g typescript @types/node ts-node create-react-app \
    eslint prettier @typescript-eslint/parser @typescript-eslint/eslint-plugin \
    nodemon concurrently live-server http-server

# Install Code-Server extensions
print_status "Installing VS Code extensions..."
code-server --install-extension ms-vscode.vscode-typescript-next
code-server --install-extension esbenp.prettier-vscode
code-server --install-extension ms-vscode.eslint
code-server --install-extension bradlc.vscode-tailwindcss
code-server --install-extension ms-vscode.vscode-json
code-server --install-extension ms-vscode.hexeditor
code-server --install-extension ms-vscode.live-server

# Create sample React project
print_status "Creating sample React TypeScript project..."
cd ~
npx create-react-app web-dev-demo --template typescript
cd web-dev-demo

# Add additional dependencies
npm install @types/react @types/react-dom tailwindcss autoprefixer postcss

# Initialize Tailwind CSS
npx tailwindcss init -p

# Update Tailwind config
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

# Add Tailwind to CSS
cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
EOF

# Create sample component
mkdir -p src/components
cat > src/components/Welcome.tsx << 'EOF'
import React from 'react';

const Welcome: React.FC = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center">
      <div className="bg-white rounded-lg shadow-xl p-8 max-w-md">
        <h1 className="text-3xl font-bold text-gray-800 mb-4">
          🎉 Web Dev Environment Ready!
        </h1>
        <p className="text-gray-600 mb-6">
          Your React + TypeScript development environment is set up and ready to use.
        </p>
        <div className="space-y-2">
          <div className="flex items-center">
            <span className="text-green-500">✅</span>
            <span className="ml-2">React 18 with TypeScript</span>
          </div>
          <div className="flex items-center">
            <span className="text-green-500">✅</span>
            <span className="ml-2">Tailwind CSS</span>
          </div>
          <div className="flex items-center">
            <span className="text-green-500">✅</span>
            <span className="ml-2">ESLint + Prettier</span>
          </div>
          <div className="flex items-center">
            <span className="text-green-500">✅</span>
            <span className="ml-2">Code-Server</span>
          </div>
        </div>
        <button 
          className="mt-6 w-full bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded transition duration-200"
          onClick={() => alert('Start building amazing web applications!')}
        >
          Get Started
        </button>
      </div>
    </div>
  );
};

export default Welcome;
EOF

# Update App.tsx
cat > src/App.tsx << 'EOF'
import React from 'react';
import Welcome from './components/Welcome';

function App() {
  return (
    <div className="App">
      <Welcome />
    </div>
  );
}

export default App;
EOF

# Create service management script
print_status "Creating service management tools..."
cat > ~/manage-services.sh << 'MGEOF'
#!/bin/bash

SERVICE_NAME="code-server"

show_status() {
    echo "📊 Service Status:"
    systemctl status $SERVICE_NAME --no-pager
}

start_service() {
    echo "🚀 Starting $SERVICE_NAME..."
    sudo systemctl start $SERVICE_NAME
    sleep 2
    show_status
}

stop_service() {
    echo "🛑 Stopping $SERVICE_NAME..."
    sudo systemctl stop $SERVICE_NAME
    sleep 2
    show_status
}

restart_service() {
    echo "🔄 Restarting $SERVICE_NAME..."
    sudo systemctl restart $SERVICE_NAME
    sleep 2
    show_status
}

check_port() {
    local port=3000
    echo "🌐 Checking port $port:"
    if netstat -tuln | grep -q ":$port "; then
        echo "✅ Code-Server is listening on port $port"
        WSL_IP=$(ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
        echo "🔗 Access at: http://$WSL_IP:$port"
    else
        echo "❌ Code-Server is not listening on port $port"
    fi
}

case "$1" in
    start)
        start_service
        check_port
        ;;
    stop)
        stop_service
        ;;
    restart)
        restart_service
        check_port
        ;;
    status)
        show_status
        check_port
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        ;;
esac
MGEOF

chmod +x ~/manage-services.sh

# Create verification script
print_status "Creating environment verification script..."
cat > ~/verify-environment.sh << 'VEREOF'
#!/bin/bash

echo "🔍 WSL Development Environment Verification"
echo "=========================================="

# System Information
echo -e "\n📊 System Information:"
echo "OS: $(lsb_release -d | cut -d: -f2 | xargs)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"

# Network Configuration
echo -e "\n🌐 Network Configuration:"
WSL_IP=$(ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
echo "WSL IP Address: $WSL_IP"

# Service Status
echo -e "\n🔧 Service Status:"
services=("code-server")
for service in "${services[@]}"; do
    if systemctl list-unit-files | grep -q "^$service.service"; then
        status=$(systemctl is-active $service 2>/dev/null || echo "not-installed")
        echo "$service: $status"
    else
        echo "$service: not-installed"
    fi
done

# Port Status
echo -e "\n🌐 Port Status:"
ports=(3000 8080)
for port in "${ports[@]}"; do
    if netstat -tuln | grep -q ":$port "; then
        echo "Port $port: LISTENING"
    else
        echo "Port $port: AVAILABLE"
    fi
done

# Development Tools
echo -e "\n🛠️ Development Tools:"
tools=(
    "git:git --version"
    "curl:curl --version | head -1"
    "node:node --version"
    "npm:npm --version"
)

for tool in "${tools[@]}"; do
    name="${tool%%:*}"
    cmd="${tool##*:}"
    if command -v "${name}" >/dev/null 2>&1; then
        version=$(eval $cmd 2>/dev/null | head -1)
        echo "$name: $version"
    else
        echo "$name: NOT INSTALLED"
    fi
done

echo -e "\n✅ Verification Complete!"
VEREOF

chmod +x ~/verify-environment.sh

# Get WSL IP address
WSL_IP=$(ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)

print_success "Web Developer Environment Setup Complete!"
echo ""
echo "🌐 Access Points:"
echo "   Code-Server: http://$WSL_IP:3000"
echo "   React App: cd ~/web-dev-demo && npm start"
echo ""
echo "🛠️ Installed Tools:"
echo "   ✅ Code-Server (VS Code in browser)"
echo "   ✅ Node.js $(node --version) with NVM"
echo "   ✅ npm $(npm --version)"
echo "   ✅ TypeScript $(tsc --version)"
echo "   ✅ React development tools"
echo "   ✅ ESLint + Prettier"
echo "   ✅ Tailwind CSS"
echo ""
echo "🚀 Quick Start:"
echo "   1. Open http://$WSL_IP:3000 in your browser"
echo "   2. Navigate to ~/web-dev-demo in the terminal"
echo "   3. Run 'npm start' to start the React dev server"
echo "   4. Start coding!"
echo ""
echo "🔧 Management Commands:"
echo "   ~/manage-services.sh start    # Start Code-Server"
echo "   ~/manage-services.sh status   # Check status"
echo "   ~/verify-environment.sh       # Verify installation"
echo ""
echo "📖 Quick Reference:"
echo "   cs-start, cs-stop, cs-restart # Service management"
echo "   myip                          # Get WSL IP"
echo "   ports                         # Show listening ports"
echo ""
print_success "Happy coding! 🎉"