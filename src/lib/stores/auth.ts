import { writable } from 'svelte/store';

interface AuthStore {
  isLoading: boolean;
  currentUser: any | null;
  session: any | null;
  error: Error | null;
}

const createAuthStore = () => {
  const { subscribe, set, update } = writable<AuthStore>({
    isLoading: true,
    currentUser: null,
    session: null,
    error: null
  });

  return {
    subscribe,
    setSession: (session: any) =>
      update((state) => ({
        ...state,
        session,
        currentUser: session?.user ?? null,
        isLoading: false
      })),
    setError: (error: Error) =>
      update((state) => ({ ...state, error, isLoading: false })),
    reset: () => set({ isLoading: false, currentUser: null, session: null, error: null })
  };
};

export const authStore = createAuthStore();