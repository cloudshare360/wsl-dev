# Full Stack Developer Quick Install

> 🔥 **Complete Stack** | ⏱️ **45 minutes** | 💡 **Frontend + Backend + Database**

## 📋 What Gets Installed

Everything for full-stack development:

- ✅ **Essential System Tools** (curl, wget, git, build tools)
- ✅ **Code-Server** (VS Code in browser, port 3000)
- ✅ **Node.js + TypeScript** (Latest LTS via NVM)
- ✅ **Python 3 + Pipenv** (Backend development)
- ✅ **React + Next.js** (Frontend frameworks)
- ✅ **Docker + Docker Compose** (Containerization)
- ✅ **Database Tools** (PostgreSQL client, Redis tools)

## 🚀 Quick Installation

### Option 1: Complete Setup (Recommended)

```bash
# Full stack installation - everything you need
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/quick-install/fullstack.sh | bash
```

### Option 2: Step-by-Step Installation

```bash
# 1. System Foundation (5 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/01-system-setup/essential-tools.md | bash

# 2. Code-Server (10 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/02-code-server/installation.md | bash

# 3. Docker Platform (10 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/03-containers/docker.md | bash

# 4. Python Backend (10 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/04-programming-languages/python.md | bash

# 5. Node.js Frontend (10 minutes)
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/04-programming-languages/nodejs.md | bash
```

## 🏗️ Tech Stack Overview

### Frontend
- **React 18** - Component library
- **Next.js 14** - Full-stack framework
- **TypeScript** - Type safety
- **Tailwind CSS** - Utility-first CSS

### Backend
- **Python 3.12** - Server-side development
- **FastAPI** - Modern API framework
- **Node.js** - JavaScript runtime
- **Express.js** - Web framework

### DevOps & Tools
- **Docker** - Containerization
- **Docker Compose** - Multi-container apps
- **PostgreSQL** - Database
- **Redis** - Caching

## ✅ Getting Started

### 1. Access Your Environment

```bash
# Get WSL IP
ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
```

Open: `http://YOUR_WSL_IP:3000`

### 2. Create Sample Projects

#### React Frontend
```bash
npx create-react-app frontend
cd frontend
npm install @types/react @types/react-dom typescript
npm start
```

#### FastAPI Backend
```bash
mkdir backend && cd backend
pipenv install fastapi uvicorn python-multipart
pipenv shell

# Create app.py
cat > app.py << 'EOF'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="Full Stack API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"message": "Full Stack API Ready!"}

@app.get("/health")
def health_check():
    return {"status": "healthy", "stack": "python+react"}
EOF

# Run the API
uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```

#### Docker Compose Stack
```bash
mkdir fullstack-project && cd fullstack-project

cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: devdb
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: devpass
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
      - /app/node_modules

  backend:
    build: ./backend
    ports:
      - "8000:8000"
    volumes:
      - ./backend:/app
    depends_on:
      - postgres
      - redis

volumes:
  postgres_data:
EOF

docker-compose up -d
```

## 🧪 Verification

```bash
# Check all services
curl -fsSL https://raw.githubusercontent.com/cloudshare360/wsl-dev/main/wsl-install-code-server/08-troubleshooting/fullstack-verification.md | bash
```

## 📊 Resource Usage

| Component | RAM | CPU | Disk |
|-----------|-----|-----|------|
| Code-Server | 200MB | Low | 500MB |
| Node.js | 100MB | Low | 200MB |
| Python | 50MB | Low | 300MB |
| Docker | 500MB | Med | 2GB |
| **Total** | **~850MB** | **Medium** | **~3GB** |

## 🎯 Development Workflow

1. **Frontend Development**: React/Next.js in Code-Server
2. **Backend APIs**: Python FastAPI + Node.js Express
3. **Database**: PostgreSQL with pgAdmin
4. **Testing**: Jest (frontend) + pytest (backend)
5. **Deployment**: Docker containers

## 🔗 Add More Tools

Extend your stack:

- **[Cloud Tools](../06-cloud-tools/aws-cli.md)** - AWS deployment
- **[API Testing](../07-development-tools/api-testing.md)** - Postman/Insomnia
- **[Database GUIs](../07-development-tools/database-tools.md)** - pgAdmin, Redis Commander
- **[CI/CD Tools](../07-development-tools/cicd-tools.md)** - GitHub Actions

---

**🎉 Full-stack development environment ready in 45 minutes!**

> Perfect for: Web applications, API development, microservices, startup MVPs