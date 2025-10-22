#!/bin/bash
# WSL Documentation Local Server Setup Script
# Provides multiple options for serving the documentation locally

set -e

echo "========================================"
echo "WSL Documentation Local Server Setup"
echo "========================================"
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if port is available
port_available() {
    ! netstat -tuln 2>/dev/null | grep ":$1 " >/dev/null
}

# Default port
PORT=8080

# Check if port is in use and find alternative
while ! port_available $PORT; do
    echo "⚠️  Port $PORT is in use, trying $((PORT + 1))"
    PORT=$((PORT + 1))
done

echo "🌐 Will use port: $PORT"
echo ""

# Check available server options
echo "📋 Available server options:"
echo ""

SERVERS_AVAILABLE=0

if command_exists npm && command_exists node; then
    echo "✅ Option 1: Live Server (Recommended)"
    echo "   - Best experience with auto-reload"
    echo "   - Good for development and browsing"
    SERVERS_AVAILABLE=$((SERVERS_AVAILABLE + 1))
    OPTION_1_AVAILABLE=true
else
    echo "❌ Option 1: Live Server (Not Available)"
    echo "   - Requires Node.js and npm"
    OPTION_1_AVAILABLE=false
fi

if command_exists python3; then
    echo "✅ Option 2: Python 3 HTTP Server"
    echo "   - Simple static file server"
    echo "   - Good for basic documentation browsing"
    SERVERS_AVAILABLE=$((SERVERS_AVAILABLE + 1))
    OPTION_2_AVAILABLE=true
elif command_exists python; then
    echo "✅ Option 2: Python 2 HTTP Server"
    echo "   - Simple static file server"
    echo "   - Good for basic documentation browsing"
    SERVERS_AVAILABLE=$((SERVERS_AVAILABLE + 1))
    OPTION_2_AVAILABLE=true
else
    echo "❌ Option 2: Python HTTP Server (Not Available)"
    echo "   - Requires Python"
    OPTION_2_AVAILABLE=false
fi

if command_exists php; then
    echo "✅ Option 3: PHP Built-in Server"
    echo "   - Simple HTTP server"
    echo "   - Good for static content"
    SERVERS_AVAILABLE=$((SERVERS_AVAILABLE + 1))
    OPTION_3_AVAILABLE=true
else
    echo "❌ Option 3: PHP Server (Not Available)"
    echo "   - Requires PHP"
    OPTION_3_AVAILABLE=false
fi

echo ""

if [ $SERVERS_AVAILABLE -eq 0 ]; then
    echo "❌ No supported servers found!"
    echo ""
    echo "Please install one of the following:"
    echo "• Node.js and npm: https://nodejs.org/"
    echo "• Python: https://python.org/"
    echo "• PHP: https://php.net/"
    echo ""
    echo "After installation, run this script again."
    exit 1
fi

echo "Choose your preferred server option:"
echo ""

if [ "$OPTION_1_AVAILABLE" = true ]; then
    echo "1) Live Server (Recommended)"
fi

if [ "$OPTION_2_AVAILABLE" = true ]; then
    echo "2) Python HTTP Server"
fi

if [ "$OPTION_3_AVAILABLE" = true ]; then
    echo "3) PHP Built-in Server"
fi

echo "q) Quit"
echo ""

read -p "Enter your choice: " choice

case $choice in
    1)
        if [ "$OPTION_1_AVAILABLE" = true ]; then
            echo ""
            echo "🚀 Setting up Live Server..."
            
            # Check if live-server is installed
            if ! command_exists live-server; then
                echo "📦 Installing live-server..."
                npm install -g live-server
            fi
            
            echo "🌐 Starting Live Server on port $PORT..."
            echo "📱 Your documentation will be available at: http://localhost:$PORT"
            echo "🔄 Server will auto-reload when files change"
            echo ""
            echo "Press Ctrl+C to stop the server"
            echo ""
            
            live-server --port=$PORT --open=/index.html --wait=1000
        else
            echo "❌ Live Server is not available"
            exit 1
        fi
        ;;
    2)
        if [ "$OPTION_2_AVAILABLE" = true ]; then
            echo ""
            echo "🐍 Starting Python HTTP Server..."
            echo "📱 Your documentation will be available at: http://localhost:$PORT"
            echo ""
            echo "Press Ctrl+C to stop the server"
            echo ""
            
            if command_exists python3; then
                python3 -m http.server $PORT
            else
                python -m SimpleHTTPServer $PORT
            fi
        else
            echo "❌ Python HTTP Server is not available"
            exit 1
        fi
        ;;
    3)
        if [ "$OPTION_3_AVAILABLE" = true ]; then
            echo ""
            echo "🐘 Starting PHP Built-in Server..."
            echo "📱 Your documentation will be available at: http://localhost:$PORT"
            echo ""
            echo "Press Ctrl+C to stop the server"
            echo ""
            
            php -S localhost:$PORT
        else
            echo "❌ PHP Server is not available"
            exit 1
        fi
        ;;
    q|Q)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac