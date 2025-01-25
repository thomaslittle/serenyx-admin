import { writable } from 'svelte/store';
import type { User } from '@supabase/supabase-js';

interface AuthStore {
  user: User | null;
  role: string | null;
}

export const auth = writable<AuthStore>({
  user: null,
  role: null
});

export const canAccessAdmin = (role: string | null) => {
  return role === 'admin';
};

export const canManageUsers = (role: string | null) => {
  return role === 'admin';
};

export const canManageTeams = (role: string | null) => {
  return role === 'admin';
};

export const canDeleteItems = (role: string | null) => {
  return role === 'admin';
};

export const hasPermission = (role: string | null, permission: string) => {
  if (!role) return false;
  
  // Define permission mappings
  const rolePermissions: Record<string, string[]> = {
    admin: ['channels.delete', 'messages.delete'],
    moderator: ['messages.delete']
  };

  return rolePermissions[role]?.includes(permission) || false;
};
