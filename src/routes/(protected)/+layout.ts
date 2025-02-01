import { redirect } from '@sveltejs/kit';
import type { LayoutLoad } from './$types';
import type { SupabaseClient } from '@supabase/supabase-js';

export const load: LayoutLoad = async ({ parent }) => {
  console.log('Protected layout starting...');
  const { session, supabase } = await parent();

  if (!session?.user) {
    console.log('No session in protected layout, redirecting to login');
    throw redirect(303, '/login');
  }

  // Get role from app_metadata first, as it's the most authoritative source
  const metadataRole = session.user.app_metadata?.role;
  
  // Check user_roles table as well
  let dbRole = null;
  if (!metadataRole) {
    const { data: roleData } = await supabase
      .from('user_roles')
      .select('role')
      .eq('user_id', session.user.id)
      .single();
    dbRole = roleData?.role;
  }

  // Check if user is admin based on either source
  const isAdmin = metadataRole === 'admin' || dbRole === 'admin';

  if (!isAdmin) {
    console.log('User is not admin, redirecting to home. Roles:', {
      metadataRole,
      dbRole
    });
    throw redirect(303, '/');
  }

  console.log('Admin access granted');
  return {
    session: {
      ...session,
      user: {
        ...session.user,
        role: metadataRole || dbRole || 'authenticated'
      }
    },
    role: metadataRole || dbRole || 'authenticated',
    supabase
  };
};
