<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from '$lib/supabase/client';
  import type { Database } from '$lib/supabase/types';
  import { redirect } from '@sveltejs/kit';

  type Match = Database['public']['Tables']['matches']['Row'] & {
    team1_name: string;
    team2_name: string;
  };

  export let data: { session: any };

  let matches: Match[] = [];
  let loading = true;
  let error: string | null = null;

  if (data?.session?.user?.role !== 'admin') {
    throw redirect(303, '/');
  }

  onMount(async () => {
    console.log('User role:', data?.session?.user?.role);
    console.log('Session:', data?.session);
    await fetchMatches();
  });

  async function fetchMatches() {
    try {
      loading = true;
      const { data, error: fetchError } = await supabase
        .from('matches')
        .select(
          `
          *,
          team1:teams!matches_team1_id_fkey(name),
          team2:teams!matches_team2_id_fkey(name)
        `
        )
        .order('start_time', { ascending: true });

      if (fetchError) throw fetchError;
      if (data) {
        matches = data.map((match) => ({
          ...match,
          team1_name: match.team1?.name,
          team2_name: match.team2?.name
        }));
      } else {
        error = 'No matches found';
      }
    } catch (e: any) {
      error = e?.message ?? 'An unknown error occurred';
    } finally {
      loading = false;
    }
  }

  async function updateMatchStatus(matchId: string, status: 'upcoming' | 'live' | 'completed') {
    try {
      const { error: updateError } = await supabase
        .from('matches')
        .update({ status })
        .eq('id', matchId);

      if (updateError) throw updateError;
      await fetchMatches();
    } catch (e: any) {
      error = e?.message ?? 'An unknown error occurred';
    }
  }
</script>

<div class="min-h-screen bg-neutral-900 p-8">
  <div class="mx-auto max-w-7xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2 class="text-2xl font-bold uppercase tracking-widest text-white sm:text-3xl">Matches</h2>
      </div>
      <div class="mt-4 flex md:ml-4 md:mt-0">
        <a
          href="/admin/matches/new"
          class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white hover:bg-red-500"
        >
          Add Match
        </a>
      </div>
    </div>

    {#if error}
      <div class="mt-4 rounded-md bg-red-500 p-4">
        <p class="text-sm text-white">{error}</p>
      </div>
    {/if}

    <div class="mt-8">
      {#if loading}
        <div class="text-white">Loading matches...</div>
      {:else}
        <div class="overflow-hidden rounded-lg bg-neutral-800 shadow">
          <table class="min-w-full divide-y divide-gray-700">
            <thead>
              <tr>
                <th class="px-6 py-3 text-left text-sm font-semibold text-white">Teams</th>
                <th class="px-6 py-3 text-left text-sm font-semibold text-white">Start Time</th>
                <th class="px-6 py-3 text-left text-sm font-semibold text-white">Division</th>
                <th class="px-6 py-3 text-left text-sm font-semibold text-white">Status</th>
                <th class="px-6 py-3 text-left text-sm font-semibold text-white">Score</th>
                <th class="relative px-6 py-3">
                  <span class="sr-only">Actions</span>
                </th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-700">
              {#each matches as match}
                <tr>
                  <td class="whitespace-nowrap px-6 py-4">
                    <div class="text-sm text-white">{match.team1_name} vs {match.team2_name}</div>
                  </td>
                  <td class="whitespace-nowrap px-6 py-4">
                    <div class="text-sm text-white">
                      {new Date(match.start_time).toLocaleString()}
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-6 py-4">
                    <div class="text-sm text-white">{match.division}</div>
                  </td>
                  <td class="whitespace-nowrap px-6 py-4">
                    <select
                      value={match.status}
                      on:change={(e) => updateMatchStatus(match.id, e.currentTarget.value as any)}
                      class="rounded-md bg-neutral-700 px-2 py-1 text-sm text-white"
                    >
                      <option value="upcoming">Upcoming</option>
                      <option value="live">Live</option>
                      <option value="completed">Completed</option>
                    </select>
                  </td>
                  <td class="whitespace-nowrap px-6 py-4">
                    <div class="text-sm text-white">
                      {match.team1_score} - {match.team2_score}
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-6 py-4 text-right text-sm">
                    <a href={`/admin/matches/${match.id}`} class="text-primary hover:text-red-500">
                      Edit
                    </a>
                  </td>
                </tr>
              {/each}
            </tbody>
          </table>
        </div>
      {/if}
    </div>
  </div>
</div>
