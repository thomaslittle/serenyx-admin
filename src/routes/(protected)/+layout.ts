import { redirect } from '@sveltejs/kit';
import type { LayoutLoad } from './$types';

export const load: LayoutLoad = async ({ parent }) => {
  const data = await parent();
  console.log('Protected layout data:', data);

  if (!data.session?.user) {
    console.log('No session in protected layout, redirecting to login');
    throw redirect(303, '/login');
  }

  if (data.session.user.role !== 'admin') {
    console.log('User is not admin, redirecting to home');
    throw redirect(303, '/');
  }

  return {
    session: data.session,
    role: data.session.user.role
  };
};
