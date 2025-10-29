#!/bin/bash
# Startup script to install Docker, Docker Compose, clone the repo, and run the service

# --- Configuration Variables (REPLACE THIS) ---
GITHUB_REPO_URL="https://github.com/kmpatel100/AI-assistant-on-GCP.git" # e.g., https://github.com/username/repo-name.git
REPO_DIR="/opt/app"
COMPOSE_FILE_NAME="docker-compose.yml" # Confirmed to be the file name in your repo

# --- 1. System Update and Dependency Installation ---
echo "--- System Update and Dependency Installation ---"
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release git

# --- 2. Install Docker Engine and Docker Compose Plugin ---
echo "--- Installing Docker Engine and Compose Plugin ---"

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
# Install Docker CE, CLI, and the Compose Plugin (preferred method for modern installs)
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# --- 3. Clone GitHub Repository ---
echo "--- Cloning repository from GitHub ---"
mkdir -p $REPO_DIR
# Clone the repository into the designated directory
git clone $GITHUB_REPO_URL $REPO_DIR

# --- 4. Run Docker Containers with Docker Compose ---
echo "--- Running Docker Compose services ---"
cd $REPO_DIR
# Use 'docker compose' (v2) which is installed as a plugin
# The '-d' runs the containers in detached mode (background)
# The '-f' explicitly points to your single file.
sudo docker compose -f $COMPOSE_FILE_NAME up -d

echo "--- Automation complete. Check 'sudo docker ps' to verify containers are running. ---"
