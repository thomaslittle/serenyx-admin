# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Implemented Role-Based Access Control (RBAC) following Supabase best practices
- Added `user_roles` table for role management
- Added `role_permissions` table for permission management
- Created `app_role` and `app_permission` enum types
- Added database functions for role checking (`auth.role()`)
- Added permission-based function checks (`hasPermission`)
- Enhanced debug panel showing role and permission information
- Added role-based navigation visibility
- Protected admin routes with role checks
- Added data table component for user management
- Implemented user role management interface
- Added bulk user deletion functionality
- Added email filtering and column visibility controls
- Implemented pagination for user lists

### Changed

- Switched from JWT claims to database role lookup
- Updated auth store to handle role and permissions
- Modified login flow to fetch roles from database
- Updated protected layout to verify roles
- Enhanced session handling with role information
- Improved role verification in server-side routes
- Refactored admin user management to use shadcn-svelte components
- Improved user interface with modern table features
- Enhanced user role editing with dropdown selection

### Fixed

- Role persistence issues after login
- Permission checking in protected routes
- Role-based access control bugs
- Session role synchronization
- Admin route protection
- User table rendering and state management
- Role selection and update functionality
- Table pagination and filtering issues

### Security

- Implemented proper role-permission relationship
- Added database-level role verification
- Enhanced permission checking system
- Improved role assignment security
- Added role-based policy controls

### Technical Debt

- Consolidated role management system
- Improved role type safety
- Enhanced permission checking
- Standardized role verification

### Development Experience

- Added role debugging information
- Enhanced role error messages
- Improved role management documentation
- Added permission visibility in debug panel
- Separated table components for better maintainability
- Added type safety for user management interfaces
- Improved component organization following shadcn patterns
