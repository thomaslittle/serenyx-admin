import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { createClient } from '@supabase/supabase-js';
import { PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY } from '$env/static/public';

// Create a new Supabase client instance
const supabase = createClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY);

export const load: PageServerLoad = async (event) => {
  try {
    const parent = await event.parent();
    
    // Check if parent data exists and has required properties
    if (!parent || typeof parent !== 'object') {
      throw error(500, 'Parent data is not an object');
    }
    
    if (!('session' in parent)) {
      throw error(500, 'Parent data missing required properties');
    }

    const { session } = parent;
    
    // Set the session token for the Supabase client
    if (session?.access_token) {
      // Use the correct method to set the session
      await supabase.auth.setSession({
        access_token: session.access_token,
        refresh_token: session.refresh_token
      });
    }

    // Use secure method to validate session
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

    // Get all users from the view - RLS will handle permissions
    const { data: users, error: usersError } = await supabase
      .from('user_management')
      .select('id, email, last_sign_in_at, raw_app_meta_data, role');

    if (usersError) {
      console.error('Users error:', usersError);
      throw error(500, usersError.message);
    }

    // Get available roles
    const { data: availableRoles, error: rolesError } = await supabase
      .from('role_permissions')
      .select('role', { count: 'exact', head: true })
      .order('role', { ascending: true });

    if (rolesError) {
      console.error('Roles error:', rolesError);
      throw error(500, rolesError.message);
    }

    // Format users with their roles
    const formattedUsers = users?.map((user: any) => ({
      id: user.id,
      email: user.email,
      last_sign_in_at: user.last_sign_in_at,
      role: user.raw_app_meta_data?.role || user.role || 'authenticated'
    }));

    return {
      session,
      users: formattedUsers,
      availableRoles: availableRoles?.map((r: any) => r.role)
    };
  } catch (e: any) {
    console.error('Error in load function:', e);
    throw error(500, e.message || 'Internal server error');
  }
}; 