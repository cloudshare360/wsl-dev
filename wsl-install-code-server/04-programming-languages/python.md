# Python Development Environment

> 🐍 **Python 3 Stack** | ⏱️ **15 minutes** | 📦 **pip, pipenv, common packages**

## 📋 Overview

Set up a complete Python development environment with Python 3, package managers, virtual environments, and popular development packages for web development, data science, and testing.

## 🎯 What You'll Get

- **Python 3** latest version with development headers
- **pip3** Python package installer
- **pipenv** Advanced dependency and virtual environment management
- **Popular packages** Flask, Django, FastAPI, Jupyter, data science tools
- **Development tools** Testing, linting, and formatting utilities

---

## 📋 Prerequisites

Before starting, ensure you have:
- ✅ [Essential Tools](../01-system-setup/essential-tools.md) installed
- ✅ Internet connectivity

---

## 🚀 Installation Steps

### Step 1: Install Python and Core Tools

```bash
# Install Python 3 and essential packages
sudo apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    python3-setuptools \
    python3-wheel

# Verify Python installation
python3 --version
pip3 --version
```

### Step 2: Upgrade pip and Install pipenv

```bash
# Upgrade pip to latest version
python3 -m pip install --upgrade pip

# Install pipenv for advanced dependency management
pip3 install --user pipenv

# Add pip user binaries to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Verify pipenv installation
pipenv --version
```

### Step 3: Install Web Development Frameworks

```bash
# Install popular web frameworks
pip3 install --user \
    flask \
    django \
    fastapi \
    uvicorn \
    gunicorn \
    requests \
    jinja2
```

### Step 4: Install Data Science Packages

```bash
# Install data science and analysis tools
pip3 install --user \
    jupyter \
    pandas \
    numpy \
    matplotlib \
    seaborn \
    plotly \
    scipy \
    scikit-learn
```

### Step 5: Install Development Tools

```bash
# Install testing, linting, and formatting tools
pip3 install --user \
    pytest \
    pytest-cov \
    black \
    flake8 \
    pylint \
    autopep8 \
    isort \
    mypy
```

---

## ✅ Verification

### Test Python Installation

```bash
# Check Python version
python3 --version

# Check pip version
pip3 --version

# Check pipenv version
pipenv --version

# List installed packages
pip3 list --user
```

### Test Virtual Environment

```bash
# Create a test project directory
mkdir -p ~/python-test
cd ~/python-test

# Create virtual environment with pipenv
pipenv install requests

# Activate virtual environment
pipenv shell

# Test inside virtual environment
python -c "import requests; print('Requests version:', requests.__version__)"

# Exit virtual environment
exit
```

### Test Web Framework (Flask)

```bash
# Create a simple Flask app
cat > ~/python-test/app.py << 'EOF'
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return '<h1>Hello from Python Flask!</h1><p>Python development environment is working!</p>'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
EOF

# Test Flask installation
cd ~/python-test
python3 -c "import flask; print('Flask version:', flask.__version__)"
```

---

## 🛠️ Development Workflows

### Using Virtual Environments with pipenv

```bash
# Create new project with pipenv
mkdir my-python-project
cd my-python-project

# Initialize new Pipfile
pipenv install

# Install development dependencies
pipenv install requests flask
pipenv install pytest black --dev

# Activate virtual environment
pipenv shell

# Install from requirements.txt (if you have one)
pipenv install -r requirements.txt

# Generate requirements.txt from Pipfile
pipenv requirements > requirements.txt
```

### Using Standard venv

```bash
# Create virtual environment
python3 -m venv my-project-env

# Activate virtual environment
source my-project-env/bin/activate

# Install packages
pip install flask requests

# Deactivate virtual environment
deactivate
```

### Jupyter Notebook Setup

```bash
# Start Jupyter Notebook server
jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser

# Access Jupyter via browser:
# http://YOUR_WSL_IP:8888
```

---

## 🎯 Common Python Commands

### Package Management

```bash
# Install package globally
pip3 install --user package_name

# Install package in virtual environment
pipenv install package_name

# List installed packages
pip3 list --user
pipenv list

# Update package
pip3 install --upgrade package_name
pipenv update package_name

# Uninstall package
pip3 uninstall package_name
pipenv uninstall package_name
```

### Code Quality Tools

```bash
# Format code with black
black your_script.py

# Check code style with flake8
flake8 your_script.py

# Sort imports with isort
isort your_script.py

# Type checking with mypy
mypy your_script.py

# Run tests with pytest
pytest tests/
```

---

## 🎨 Sample Projects

### Simple Flask API

```bash
# Create Flask API project
mkdir ~/flask-api-demo
cd ~/flask-api-demo

# Create Pipfile and install dependencies
pipenv install flask flask-cors

# Create API file
cat > app.py << 'EOF'
from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/api/hello')
def hello():
    return jsonify({"message": "Hello from Python API!", "status": "success"})

@app.route('/api/data')
def data():
    return jsonify({
        "users": ["Alice", "Bob", "Charlie"],
        "count": 3
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
EOF

# Run the API
pipenv run python app.py
```

### Data Analysis Project

```bash
# Create data analysis project
mkdir ~/data-analysis-demo
cd ~/data-analysis-demo

# Install data science packages
pipenv install pandas matplotlib seaborn jupyter

# Create sample analysis script
cat > analysis.py << 'EOF'
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Create sample data
data = {
    'Name': ['Alice', 'Bob', 'Charlie', 'Diana'],
    'Age': [25, 30, 35, 28],
    'Salary': [50000, 60000, 70000, 55000]
}

df = pd.DataFrame(data)
print("Sample Data:")
print(df)

# Simple analysis
print(f"\nAverage Age: {df['Age'].mean():.1f}")
print(f"Average Salary: ${df['Salary'].mean():,.0f}")
EOF

# Run analysis
pipenv run python analysis.py
```

---

## 🚨 Troubleshooting

### pip Installation Issues

```bash
# Fix pip issues
python3 -m pip install --upgrade pip

# Clear pip cache
pip3 cache purge

# Install with --user flag if permission denied
pip3 install --user package_name
```

### Virtual Environment Issues

```bash
# Remove broken virtual environment
pipenv --rm

# Recreate virtual environment
pipenv install

# Clear pipenv cache
pipenv --clear
```

### Import Errors

```bash
# Check Python path
python3 -c "import sys; print('\n'.join(sys.path))"

# Check if package is installed
pip3 show package_name

# Reinstall package
pip3 uninstall package_name
pip3 install package_name
```

---

## 🔗 Next Steps

Now that Python is set up, you can:

1. **[Install Node.js](./nodejs.md)** - Add JavaScript development (optional)
2. **[Install Java](./java.md)** - Add Java development (optional)  
3. **[Setup Development Tools](../07-development-tools/)** - Add databases, API testing tools
4. **[Install Docker](../03-containers/docker.md)** - Containerize Python applications

---

**🐍 Python development environment is ready!**

> 💡 **Quick Start:** Create a new project with `pipenv install flask` and start building!