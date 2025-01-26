import { redirect } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import { supabase } from '$lib/supabase/client';

export const load: PageLoad = async () => {
  const {
    data: { session },
    error
  } = await supabase.auth.getSession();

  if (error) throw error;

  if (session) {
    const role = session.user.app_metadata.role || 'authenticated';
    throw redirect(303, role === 'admin' ? '/admin' : '/');
  }

  throw redirect(303, '/login');
}; 