import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { createClient } from '@supabase/supabase-js';
import { PUBLIC_SUPABASE_URL } from '$env/static/public';
import { SUPABASE_SERVICE_ROLE_KEY } from '$env/static/private';

const supabaseAdmin = createClient(
  PUBLIC_SUPABASE_URL,
  SUPABASE_SERVICE_ROLE_KEY
);

export const load: PageServerLoad = async ({ params, locals }) => {
  try {
    const { session } = await locals.safeGetSession();
    const isOwnProfile = session?.user?.id === params.id;

    // First get the user's details using admin client
    const { data: userData, error: userError } = await supabaseAdmin.auth.admin.getUserById(params.id);

    if (userError || !userData.user) {
      console.error('User fetch error:', userError);
      throw error(404, 'User not found');
    }

    // Then get the user's role from the database
    const { data: userRole, error: roleError } = await locals.supabase
      .from('user_roles')
      .select('role')
      .eq('user_id', params.id)
      .single();

    // If role doesn't exist, default to 'authenticated'
    const role = roleError ? 'authenticated' : userRole.role;

    return {
      user: {
        id: params.id,
        role,
        email: userData.user.email,
        last_sign_in_at: userData.user.last_sign_in_at,
        created_at: userData.user.created_at
      },
      isOwnProfile
    };
  } catch (e) {
    console.error('Load error:', e);
    if (e.status === 404) {
      throw e;
    }
    throw error(500, 'Failed to load user data');
  }
}; 