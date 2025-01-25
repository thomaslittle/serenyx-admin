import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { createClient } from '@supabase/supabase-js';
import { PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY } from '$env/static/public';

const supabase = createClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY);

export const load: PageServerLoad = async (event) => {
  try {
    const parent = await event.parent();
    
    if (!parent || typeof parent !== 'object' || !('session' in parent)) {
      throw error(500, 'Invalid parent data');
    }

    const { session } = parent;
    
    if (session?.access_token) {
      await supabase.auth.setSession({
        access_token: session.access_token,
        refresh_token: session.refresh_token
      });
    }

    const { data: { user }, error: authError } = await supabase.auth.getUser();
    
    if (authError || !user) {
      throw error(401, 'Not authenticated');
    }

    // Check if user has admin or planning role
    const userRole = user.user_metadata?.role || user.app_metadata?.role;
    const allowedRoles = ['admin', 'planning'];
    if (!allowedRoles.includes(userRole)) {
      throw error(403, 'Unauthorized access');
    }

    // Your planning-specific data loading logic here...

    return {
      session
      // Add any other data you need to return
    };
  } catch (e: any) {
    console.error('Error in load function:', e);
    throw error(500, e.message || 'Internal server error');
  }
}; 