import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async ({ locals: { safeGetSession } }) => {
  const { session, user } = await safeGetSession();
  console.log('Server layout session:', {
    hasSession: !!session,
    user: user?.email,
    role: user?.role
  });

  if (!session || !user) {
    console.log('No session found in server layout');
    return {
      session: null,
      role: 'user'
    };
  }

  return {
    session,
    role: user.role
  };
};
