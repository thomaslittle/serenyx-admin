import { createBrowserClient, createServerClient, isBrowser } from '@supabase/ssr';
import { PUBLIC_SUPABASE_ANON_KEY, PUBLIC_SUPABASE_URL } from '$env/static/public';
import type { LayoutServerLoad } from './$types';
import { auth } from '$lib/stores/auth';

export const load: LayoutServerLoad = async ({ data, depends, fetch, cookies }: {
  data: { cookies: { name: string; value: string }[] },
  depends: any,
  fetch: any,
  cookies: any
}) => {
  depends('supabase:auth');

  const supabase = isBrowser()
    ? createBrowserClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, {
        global: { fetch },
        auth: {
          persistSession: true,
          detectSessionInUrl: false,
          autoRefreshToken: true
        }
      })
    : createServerClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, {
        global: { fetch },
        cookies: {
          get: (name) => data.cookies.find((c: any) => c.name === name)?.value,
          set: (name, value, options) => {
            cookies.set(name, value, {
              ...options,
              path: '/',
              sameSite: 'Lax',
              secure: true
            });
          },
          remove: (name, options) => {
            cookies.delete(name, {
              ...options,
              path: '/'
            });
          }
        }
      });

  // Force session validation
  console.log('Getting session...');
  const {
    data: { session },
    error: sessionError
  } = await supabase.auth.getSession();

  if (session?.user) {

    // Get role from app_metadata first
    const metadataRole = session.user.app_metadata?.role;

    // Only query database if no metadata role
    let dbRole = null;
    if (!metadataRole) {
      console.log('No metadata role, fetching from database...');
      try {
        const { data: roleData } = await supabase
          .from('user_roles')
          .select('role')
          .eq('user_id', session.user.id)
          .single();
        dbRole = roleData?.role;
        console.log('Role from database:', dbRole);
      } catch (error) {
        console.log('Error fetching role from database:', error);
      }
    }

    // Determine role priority: app_metadata role > database role > default role
    const role = metadataRole || dbRole || 'authenticated';


    // Create a new session object with the role properly set
    const updatedSession = {
      ...session,
      user: {
        ...session.user,
        role // Set the role directly on the user object
      }
    };

    // Update the auth store
    auth.set({
      user: updatedSession.user,
      role
    });

    console.log('Auth store updated, returning session');
    return {
      supabase,
      session: updatedSession
    };
  }

  console.log('No user in session, clearing auth store');
  auth.set({ user: null, role: null });
  return { supabase, session: null };
};
