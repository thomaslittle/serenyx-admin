# Serenyx Broadcast

A modern broadcast management system for esports tournaments and events. Built with SvelteKit, Tailwind CSS, and Supabase.

## Features

- 🎮 Match Overlay Management
- 📊 Team Standings Display
- 📝 Broadcast Script Editor
- 🌓 Dark/Light Mode Support
- 🔒 Secure Authentication
- 📱 Responsive Design

## Tech Stack

- **Frontend**: SvelteKit, Tailwind CSS
- **Backend**: Supabase
- **Authentication**: Supabase Auth, Discord OAuth
- **Database**: PostgreSQL (via Supabase)
- **Deployment**: Docker

## Environment Setup

The application requires several environment variables to be set. Create a `.env` file in the root directory with the following variables:

### Required Environment Variables

```env
# Server Configuration
SERVER_IP=           # Your server IP address (e.g., 123.45.67.89)
SSH_PW=             # SSH password for server access

# Supabase Configuration
PUBLIC_SUPABASE_URL=       # Your Supabase project URL (e.g., https://your-project.supabase.co)
PUBLIC_SUPABASE_ANON_KEY=  # Supabase anonymous key (from Project Settings -> API)
SUPABASE_SERVICE_ROLE_KEY= # Supabase service role key (from Project Settings -> API)
SUPABASE_DOMAIN=           # Your Supabase domain without protocol (e.g., your-project.supabase.co)

# Database Configuration
DATABASE_URL=       # PostgreSQL connection URL (e.g., postgresql://user:pass@host:port/db)
DIRECT_URL=         # Direct database connection URL (same format as DATABASE_URL)
PGPASSWORD=         # PostgreSQL password (same as in DATABASE_URL)

# Backup Configuration
BACKUP_DB_HOST=     # Database host for backups (e.g., localhost)
BACKUP_DB_PORT=     # Database port for backups (default: 5432)
BACKUP_DB_USER=     # Database user for backups
BACKUP_DB_NAME=     # Database name for backups (default: postgres)

# Discord Configuration
DISCORD_CLIENT_ID=      # Discord OAuth application client ID (from Discord Developer Portal)
DISCORD_CLIENT_SECRET=  # Discord OAuth application client secret (from Discord Developer Portal)

# Admin Configuration
ADMIN_EMAIL=       # Admin user email
ADMIN_PASSWORD=    # Admin user password (min 8 characters)
```

### Environment Files

The project uses different environment files for different purposes:

- `.env`: Production environment variables
- `.env.local`: Local development variables (git-ignored)
- `.env.example`: Template with all required variables (committed to git)

For local development, copy `.env.example` to `.env.local` and fill in the values. The local setup uses:

- Supabase running locally on port 54321
- PostgreSQL running locally on port 54322
- Default PostgreSQL credentials (username: postgres, password: postgres)

## Getting Started

1. Clone the repository
2. Copy `.env.example` to `.env` and fill in your values
3. Install dependencies:

```bash
npm install
```

4. Create a test admin user:

```bash
npx tsx scripts/create-admin.ts
```

5. Start the development server:

```bash
npm run dev
```

## Database Management

### Backup Database

Creates a backup of the current database state:

```bash
./scripts/db-backup.sh
```

Requires: `BACKUP_DB_HOST`, `BACKUP_DB_PORT`, `BACKUP_DB_USER`, `BACKUP_DB_NAME`, `PGPASSWORD`

### Restore Database

Restores the database from a backup file:

```bash
./scripts/db-restore.sh
```

Requires: `BACKUP_DB_HOST`, `BACKUP_DB_PORT`, `BACKUP_DB_USER`, `BACKUP_DB_NAME`, `PGPASSWORD`

### Configure Discord Authentication

Sets up Discord OAuth for authentication:

```bash
./scripts/configure-discord-auth.sh
```

Requires: `SSH_PW`, `SERVER_IP`, `DISCORD_CLIENT_ID`, `DISCORD_CLIENT_SECRET`, `SUPABASE_DOMAIN`

### Check Auth Configuration

Verifies the current authentication setup:

```bash
./scripts/check-auth-config.sh
```

Requires: `SSH_PW`, `SERVER_IP`, `SUPABASE_SERVICE_ROLE_KEY`

## Building for Production

```bash
npm run build
```

You can preview the production build with:

```bash
npm run preview
```

## Security Notes

- Never commit `.env` or `.env.local` files
- Keep your service role key secure
- Regularly rotate passwords and API keys
- Use different values for development and production
- All sensitive scripts are git-ignored by default

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request
