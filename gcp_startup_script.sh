#!/bin/bash

# Redirect all output to a log file for easy debugging
exec > >(tee /var/log/startup-script-output.log|logger -t startup-script -s 2>/dev/console) 2>&1

echo "--- Starting GCP Startup Script ---"

# Exit if any command fails
set -e

# --- 1. System Update ---
echo "Updating apt packages..."
sudo apt-get update -y

# --- 2. Install Docker Prerequisites ---
echo "Installing Docker prerequisites..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# --- 3. Add Docker GPG Key and Repository ---
echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# --- 4. Install Docker Engine & Docker Compose ---
echo "Installing Docker Engine..."
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "Installing Docker Compose..."
# Using a more recent version, you can adjust as needed
DOCKER_COMPOSE_VERSION="v2.12.2"
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# --- 5. Install Git and Clone Repository ---
echo "Installing Git..."
sudo apt-get install -y git

# Define a reliable path for the application
APP_DIR="/opt/ai-assistant"
echo "Cloning GitHub repository into ${APP_DIR}..."
git clone https://github.com/kmpatel100/AI-assistant-on-GCP ${APP_DIR}

# --- 6. Start Docker Containers ---
echo "Navigating to ${APP_DIR} and starting containers..."
cd ${APP_DIR} && sudo /usr/local/bin/docker-compose up -d

echo "--- GCP Startup Script Finished Successfully ---"
