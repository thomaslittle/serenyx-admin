import { redirect } from '@sveltejs/kit';
import type { LayoutLoad } from './$types';

export const load: LayoutLoad = async ({ parent }) => {
  console.log('Protected layout starting...');
  const data = await parent();

  if (!data.session?.user) {
    console.log('No session in protected layout, redirecting to login');
    throw redirect(303, '/login');
  }

  // Get role from app_metadata first, as it's the most authoritative source
  const metadataRole = data.session.user.app_metadata?.role;
  const sessionRole = data.session.user.role;

  // Check if user is admin based on app_metadata role
  const isAdmin = metadataRole === 'admin';

  if (!isAdmin) {
    console.log('User is not admin, redirecting to home. Roles:', {
      metadataRole,
      sessionRole
    });
    throw redirect(303, '/');
  }

  console.log('Admin access granted');
  return {
    session: data.session,
    role: metadataRole || sessionRole || 'authenticated'
  };
};
