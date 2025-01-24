import { redirect } from '@sveltejs/kit';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ parent }) => {
  const { session } = await parent();

  // If the user is already logged in, redirect to home
  if (session) {
    throw redirect(303, '/');
  }
};
