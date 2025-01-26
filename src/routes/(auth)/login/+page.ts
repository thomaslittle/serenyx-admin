import { redirect } from '@sveltejs/kit';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ parent }) => {
  const { session } = await parent();

  // If user is already logged in, redirect them
  if (session) {
    const role = session.user.app_metadata.role || 'authenticated';
    throw redirect(303, role === 'admin' ? '/admin' : '/');
  }
};
