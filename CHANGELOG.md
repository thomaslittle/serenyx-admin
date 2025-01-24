# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Debug information section on homepage showing user details and auth state
- Logout button in top right corner
- Proper session persistence across page reloads
- Admin role-based access control
- Protected routes for admin section

### Changed

- Updated database schema to use boolean `is_admin` flag
- Modified Row Level Security (RLS) policies to use text comparison for roles
- Improved session handling in hooks.server.ts
- Enhanced authentication flow in protected layouts
- Simplified Supabase client initialization

### Fixed

- Session persistence issues after login
- Role-based access control bugs
- Multiple GoTrueClient instances warning
- Missing autocomplete attributes on login form
- Type issues in session handling
- Redirect loops in protected routes

### Security

- Implemented proper role checks for admin routes
- Added server-side session validation
- Enhanced JWT claim handling
- Improved cookie security settings

### Technical Debt

- Consolidated Supabase client initialization
- Improved TypeScript type safety
- Enhanced error handling and logging
- Standardized session object structure

### Development Experience

- Added detailed debug logging
- Improved error messages
- Enhanced development setup instructions
- Added session state visibility
