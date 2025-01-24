import { createBrowserClient, createServerClient, isBrowser } from '@supabase/ssr';
import { PUBLIC_SUPABASE_ANON_KEY, PUBLIC_SUPABASE_URL } from '$env/static/public';
import type { LayoutLoad } from './$types';
import { auth } from '$lib/stores/auth';

export const load: LayoutLoad = async ({ data, depends, fetch }) => {
  depends('supabase:auth');

  const supabase = isBrowser()
    ? createBrowserClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, {
        global: {
          fetch
        },
        auth: { persistSession: true }
      })
    : createServerClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, {
        global: {
          fetch
        },
        cookies: {
          getAll() {
            return data.cookies;
          }
        }
      });

  const {
    data: { session }
  } = await supabase.auth.getSession();

  if (session?.user) {
    const role = session.user.role || 'user';
    console.log('Root layout session:', { user: session.user.email, role });

    auth.set({
      user: session.user,
      role
    });

    return {
      session,
      role
    };
  }

  console.log('No session found in root layout');
  auth.set({ user: null, role: 'user' });

  return {
    session: null,
    role: 'user'
  };
};
