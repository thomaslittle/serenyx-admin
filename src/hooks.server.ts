import { PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY } from '$env/static/public';
import { createSupabaseServerClient } from '@supabase/auth-helpers-sveltekit';
import { redirect, type Handle } from '@sveltejs/kit';

export const handle: Handle = async ({ event, resolve }) => {
  // Initialize the Supabase client
  event.locals.supabase = createSupabaseServerClient({
    supabaseUrl: PUBLIC_SUPABASE_URL,
    supabaseKey: PUBLIC_SUPABASE_ANON_KEY,
    event,
    options: {
      auth: {
        persistSession: true,
        autoRefreshToken: true,
        detectSessionInUrl: true
      }
    }
  });

  // Get session from event.locals
  event.locals.getSession = async () => {
    const {
      data: { session }
    } = await event.locals.supabase.auth.getSession();
    return session;
  };

  // Check if the route is protected
  if (event.url.pathname.startsWith('/admin')) {
    const session = await event.locals.getSession();
    if (!session) {
      throw redirect(303, '/login');
    }
  }

  // Check if it's the login page and user is already logged in
  if (event.url.pathname === '/login') {
    const session = await event.locals.getSession();
    if (session) {
      throw redirect(303, '/admin');
    }
  }

  // Get the response and set appropriate headers
  const response = await resolve(event, {
    filterSerializedResponseHeaders(name) {
      return name === 'content-range';
    }
  });

  return response;
};