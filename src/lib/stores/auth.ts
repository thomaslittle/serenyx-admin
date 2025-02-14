import { writable } from "svelte/store";

interface AuthStore {
  userId: string | null;
  isAdmin: boolean;
  userData: {
    email?: string;
    username?: string;
    firstName?: string;
    lastName?: string;
    imageUrl?: string;
    publicMetadata?: {
      role?: string;
      [key: string]: any;
    };
  } | null;
}

const initialState: AuthStore = {
  userId: null,
  isAdmin: false,
  userData: null,
};

export const auth = writable<AuthStore>(initialState);

export const canAccessAdmin = (user: any) => {
  return user?.publicMetadata?.role === "admin";
};

export const canManageUsers = (user: any) => {
  return user?.publicMetadata?.role === "admin";
};

export const canManageTeams = (user: any) => {
  return user?.publicMetadata?.role === "admin";
};

export const canDeleteItems = (user: any) => {
  return user?.publicMetadata?.role === "admin";
};

export const hasPermission = (user: any, permission: string) => {
  if (!user) return false;

  const role = user.publicMetadata?.role;
  if (!role) return false;

  // Define permission mappings
  const rolePermissions: Record<string, string[]> = {
    admin: ["channels.delete", "messages.delete"],
    moderator: ["messages.delete"],
  };

  return rolePermissions[role]?.includes(permission) || false;
};
