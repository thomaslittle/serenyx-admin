import { writable } from 'svelte/store';
import type { User } from '@supabase/supabase-js';

interface AuthStore {
  user: User | null;
  role: string;
}

export const auth = writable<AuthStore>({
  user: null,
  role: 'user'
});

export const canAccessAdmin = (role: string) => {
  return role === 'admin';
};

export const canManageUsers = (role: string) => {
  return role === 'admin';
};

export const canManageTeams = (role: string) => {
  return role === 'admin';
};

export const canDeleteItems = (role: string) => {
  return role === 'admin';
};
