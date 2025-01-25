import { superValidate } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import type { PageServerLoad, Actions } from './$types';
import { fail, redirect } from '@sveltejs/kit';
import { supabase } from '$lib/supabase/client';
import { formSchema } from './schema';

export const load: PageServerLoad = async () => {
  const form = await superValidate(zod(formSchema));
  console.log('Load form:', form);
  return { form };
};

export const actions: Actions = {
  default: async ({ request }) => {
    console.log('Form submission received');
    const form = await superValidate(request, zod(formSchema));
    console.log('Validated form:', form);
    
    if (!form.valid) {
      console.log('Form validation failed:', form.errors);
      return fail(400, { form });
    }

    try {
      console.log('Inserting match:', form.data);
      const { data: matchData, error: createError } = await supabase
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