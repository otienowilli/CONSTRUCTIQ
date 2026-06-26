#!/bin/bash

echo "============================================"
echo "   CONSTRUCTIQ System Testing Guide"
echo "============================================"
echo ""

# Check Docker
echo "🐳 Checking Docker installation..."
if command -v docker &> /dev/null; then
    echo "✅ Docker is installed: $(docker --version)"
    
    if command -v docker-compose &> /dev/null; then
        echo "✅ docker-compose is installed: $(docker-compose --version)"
    elif docker compose version &> /dev/null; then
        echo "✅ docker compose is installed: $(docker compose version)"
    else
        echo "❌ docker-compose not found"
    fi
else
    echo "❌ Docker is NOT installed"
    echo ""
    echo "📥 Please install Docker Desktop:"
    echo "   https://www.docker.com/products/docker-desktop/"
    echo ""
fi

echo ""
echo "============================================"
echo "   Installation Requirements"
echo "============================================"
echo ""

# Check Python
echo "🐍 Checking Python..."
if command -v python3 &> /dev/null; then
    echo "✅ Python is installed: $(python3 --version)"
else
    echo "❌ Python 3 is NOT installed"
fi

# Check PHP
echo ""
echo "🐘 Checking PHP..."
if command -v php &> /dev/null; then
    echo "✅ PHP is installed: $(php --version | head -1)"
else
    echo "❌ PHP is NOT installed"
fi

# Check Node.js
echo ""
echo "📗 Checking Node.js..."
if command -v node &> /dev/null; then
    echo "✅ Node.js is installed: $(node --version)"
else
    echo "❌ Node.js is NOT installed"
fi

# Check PostgreSQL
echo ""
echo "🐘 Checking PostgreSQL..."
if command -v psql &> /dev/null; then
    echo "✅ PostgreSQL is installed: $(psql --version)"
else
    echo "❌ PostgreSQL is NOT installed"
fi

echo ""
echo "============================================"
echo "   Recommended Setup Options"
echo "============================================"
echo ""

echo "OPTION 1: Docker (Recommended - All-in-One)"
echo "  - Install Docker Desktop"
echo "  - Run: docker compose up -d"
echo "  - Everything works automatically"
echo ""

echo "OPTION 2: Manual Setup (Individual Services)"
echo "  Required installations:"
echo "  - PHP 8.2+ with Composer"
echo "  - Python 3.9+ with pip"
echo "  - Node.js 18+ with npm"
echo "  - PostgreSQL 15+"
echo "  - Redis"
echo "  - MQTT Broker (Mosquitto)"
echo ""

echo "============================================"
echo "   Quick Start (If Docker is Installed)"
echo "============================================"
echo ""

if command -v docker &> /dev/null; then
    echo "Run these commands:"
    echo ""
    echo "  # Start all services"
    echo "  docker compose up -d"
    echo ""
    echo "  # Check service health"
    echo "  docker compose ps"
    echo ""
    echo "  # View logs"
    echo "  docker compose logs -f"
    echo ""
    echo "  # Stop all services"
    echo "  docker compose down"
else
    echo "❌ Docker is not installed. Please install Docker Desktop first."
fi

echo ""
echo "============================================"
echo "   Documentation"
echo "============================================"
echo ""
echo "📚 Read these files for more information:"
echo "  - README.md - Main documentation"
echo "  - QUICKSTART.md - Quick start guide"
echo "  - TESTING_NEW_FEATURES.md - Testing guide"
echo "  - SYSTEM_UPDATES.md - What's new in v2.0"
echo ""

echo "============================================"
echo "   GitHub Repository"
echo "============================================"
echo ""
echo "🔗 https://github.com/otienowilli/CONSTRUCTIQ"
echo ""
