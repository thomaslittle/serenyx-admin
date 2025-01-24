import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async ({ locals: { safeGetSession } }) => {
  const { session, user } = await safeGetSession();
  console.log('Protected layout server:', {
    hasSession: !!session,
    user: user?.email,
    role: user?.role
  });

  if (!session || !user) {
    throw redirect(303, '/login');
  }

  if (user.role !== 'admin') {
    throw redirect(303, '/');
  }

  return {
    session,
    role: user.role
  };
};
