#!/bin/bash
source .env

# Check required environment variables
if [ -z "$SSH_PW" ] || [ -z "$SERVER_IP" ] || [ -z "$DISCORD_CLIENT_ID" ] || [ -z "$DISCORD_CLIENT_SECRET" ] || [ -z "$SUPABASE_DOMAIN" ]; then
    echo "Error: Required environment variables are not set"
    echo "Please ensure SSH_PW, SERVER_IP, DISCORD_CLIENT_ID, DISCORD_CLIENT_SECRET, and SUPABASE_DOMAIN are set in .env"
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

# Configure Discord provider
echo "Configuring Discord provider..."
run_ssh_cmd "docker exec $AUTH_CONTAINER sh -c 'export GOTRUE_EXTERNAL_DISCORD_ENABLED=true; export GOTRUE_EXTERNAL_DISCORD_CLIENT_ID=$DISCORD_CLIENT_ID; export GOTRUE_EXTERNAL_DISCORD_SECRET=$DISCORD_CLIENT_SECRET; export GOTRUE_EXTERNAL_DISCORD_REDIRECT_URI=https://$SUPABASE_DOMAIN/auth/v1/callback'"

# Restart the auth container
echo "Restarting auth container..."
run_ssh_cmd "docker restart $AUTH_CONTAINER"

echo "Discord provider configuration complete."