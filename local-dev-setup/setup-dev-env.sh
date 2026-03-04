#!/bin/bash

# Catch all failures
set -euo pipefail

# Load environment variables
if [ -f .env ]; then
  set -a
  source .env
  set +a
else
  echo ".env file not found"
  exit 1
fi

# Set up logging script automation (everything after this in the log file)
exec >>(tee -a "$LOG_FILE") 2>&1

# Print to the terminal that the set up is starting 
echo "====================================="
echo "Starting developer environment setup"
echo "====================================="

# Configure user and permissions
if id "$DEV_USER" &>/dev/null; then

  echo "User $DEV_USER already exists."

else

  useradd "$DEV_USER"

  echo "User $DEV_USER created."

fi

# Save environment variable for the user
echo "export DEV_ENV=$DEV_ENV" >> "/home/$DEV_USER/.bashrc"

# Install packages
apt update
apt install -y $BASE_PACKAGES

# Clone the project repo
if [ ! -d "$PROJECT_DIR" ]; then
  su - "$DEV_USER" -c "git clone $REPO_URL $PROJECT_DIR"
fi

# Set up project database - TBC
systemctl start postgresql

# Start, enable and verify services - TBC
