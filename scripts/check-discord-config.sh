#!/bin/bash
source .env

# Check required environment variables
if [ -z "$SSH_PW" ] || [ -z "$SERVER_IP" ]; then
    echo "Error: Required environment variables are not set"
    echo "Please ensure SSH_PW and SERVER_IP are set in .env"
    exit 1
fi

# Install sshpass if not already installed
if ! command -v sshpass &> /dev/null; then
    echo "Installing sshpass..."
    apt-get update && apt-get install -y sshpass
fi

# Helper function to run SSH commands with password
run_ssh_cmd() {
    sshpass -p "$SSH_PW" ssh -o StrictHostKeyChecking=no "root@$SERVER_IP" "$1"
}

# Get the project ID from an existing Supabase container name
PROJECT_ID=$(run_ssh_cmd "docker ps --format '{{.Names}}' | grep 'supabase' | head -n 1 | cut -d'-' -f3")

if [ -z "$PROJECT_ID" ]; then
    echo "Error: Could not determine Supabase project ID"
    exit 1
fi

echo "Found project ID: $PROJECT_ID"

# Get the auth container name
AUTH_CONTAINER="supabase-auth-$PROJECT_ID"
echo "Auth container name: $AUTH_CONTAINER"

# Check if the auth container is running
if ! run_ssh_cmd "docker ps --format '{{.Names}}' | grep -q '^$AUTH_CONTAINER$'"; then
    echo "Error: Auth container is not running"
    exit 1
fi

# Check if Discord provider is enabled
echo "Checking Discord provider configuration..."
run_ssh_cmd "docker exec $AUTH_CONTAINER env | grep -i 'discord'"

# Verify the settings endpoint
echo "Checking Auth service settings..."
run_ssh_cmd "curl -s http://localhost:9999/settings | jq .external.discord" 