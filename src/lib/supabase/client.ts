import { createBrowserClient } from '@supabase/ssr';
import { PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY } from '$env/static/public';
import type { Database } from './types';
import { browser } from '$app/environment';

// Create a single instance of the Supabase client
export const supabase = createBrowserClient<Database>(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, {
  cookies: {
    get(key) {
      if (!browser) return '';
      return document.cookie
        .split('; ')
        .find((row) => row.startsWith(`${key}=`))
        ?.split('=')[1];
    },
    set(key, value, options) {
      if (!browser) return;
      document.cookie = `${key}=${value}${options?.path ? `; path=${options.path}` : ''}${
        options?.expires ? `; expires=${options.expires.toUTCString()}` : ''
      }`;
    },
    remove(key, options) {
      if (!browser) return;
      document.cookie = `${key}=; expires=Thu, 01 Jan 1970 00:00:00 GMT${
        options?.path ? `; path=${options.path}` : ''
      }`;
    }
  }
});
