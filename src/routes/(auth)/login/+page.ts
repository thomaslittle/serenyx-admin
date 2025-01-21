import { redirect } from '@sveltejs/kit';
import type { PageLoad } from './$types';

export const load: PageLoad = async (event) => {
  const { supabase } = await event.parent();
  const { data: { session } } = await supabase.auth.getSession();
  
  if (session) {
    throw redirect(303, '/admin');
  }
  
  return {};
};