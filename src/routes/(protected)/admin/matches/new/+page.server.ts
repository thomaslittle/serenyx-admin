import { superValidate } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import type { PageServerLoad, Actions } from './$types';
import { fail, redirect, error } from '@sveltejs/kit';
import { formSchema } from './schema';

export const load: PageServerLoad = async ({ locals }) => {
  const { session, user } = await locals.safeGetSession();
  
  if (!session?.access_token || !user) {
    throw error(401, 'Unauthorized');
  }

  // Verify admin role
  const metadataRole = user.app_metadata?.role;
  let dbRole = null;
  
  if (!metadataRole) {
    const { data: roleData } = await locals.supabase
      .from('user_roles')
      .select('role')
      .eq('user_id', user.id)
      .single();
    dbRole = roleData?.role;
  }

  const isAdmin = metadataRole === 'admin' || dbRole === 'admin';
  if (!isAdmin) {
    throw error(403, 'Unauthorized');
  }

  const form = await superValidate(zod(formSchema));
  console.log('Load form:', form);
  return { form };
};

export const actions: Actions = {
  default: async ({ request, locals }) => {
    console.log('Form submission received');
    const form = await superValidate(request, zod(formSchema));
    console.log('Validated form:', form);
    
    if (!form.valid) {
      console.log('Form validation failed:', form.errors);
      return fail(400, { form });
    }

    try {
      const { session, user } = await locals.safeGetSession();
      
      if (!session?.access_token || !user) {
        return fail(401, { form, error: 'Unauthorized' });
      }

      // Verify admin role
      const metadataRole = user.app_metadata?.role;
      let dbRole = null;
      
      if (!metadataRole) {
        const { data: roleData } = await locals.supabase
          .from('user_roles')
          .select('role')
          .eq('user_id', user.id)
          .single();
        dbRole = roleData?.role;
      }

      const isAdmin = metadataRole === 'admin' || dbRole === 'admin';
      if (!isAdmin) {
        return fail(403, { form, error: 'Unauthorized' });
      }

      console.log('Inserting match:', form.data);
      const { data: matchData, error: createError } = await locals.supabase
        .from('matches')
        .insert([{
          team1_id: form.data.team1_id,
          team2_id: form.data.team2_id,
          start_time: form.data.start_time,
          division: form.data.division,
          status: form.data.status,
          team1_score: form.data.team1_score,
          team2_score: form.data.team2_score
        }])
        .select()
        .single();

      if (createError) {
        console.error('Database error:', createError);
        return fail(500, {
          form,
          error: createError.message
        });
      }

      console.log('Match created:', matchData);
      throw redirect(303, '/admin/matches');
    } catch (e) {
      if (e instanceof Error) {
        console.error('Error creating match:', e);
        return fail(500, {
          form,
          error: e.message
        });
      }
      throw e;
    }
  }
}; 