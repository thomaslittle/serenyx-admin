<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  import { page } from '$app/stores';
  import { supabase } from '$lib/supabase/client';
  import type { Database } from '$lib/supabase/types';

  type Team = Database['public']['Tables']['teams']['Row'];
  type Match = Database['public']['Tables']['matches']['Row'] & {
    team1: { name: string };
    team2: { name: string };
  };

  let teams: Team[] = [];
  let match: Match | null = null;
  let error: string | null = null;
  let loading = true;
  let saving = false;

  onMount(async () => {
    await Promise.all([fetchTeams(), fetchMatch()]);
  });

  async function fetchTeams() {
    try {
      const { data, error: fetchError } = await supabase
        .from('teams')
        .select('*')
        .order('division')
        .order('name');

      if (fetchError) throw fetchError;
      teams = data;
    } catch (e) {
      error = e.message;
    }
  }

  async function fetchMatch() {
    try {
      loading = true;
      const { data, error: fetchError } = await supabase
        .from('matches')
        .select(
          `
          *,
          team1:teams!team1_id(name),
          team2:teams!team2_id(name)
        `
        )
        .eq('id', $page.params.id)
        .single();

      if (fetchError) throw fetchError;
      match = data;
      // Convert UTC date to local datetime-local input format
      if (match) {
        const date = new Date(match.start_time);
        match.start_time = new Date(date.getTime() - date.getTimezoneOffset() * 60000)
          .toISOString()
          .slice(0, 16);
      }
    } catch (e) {
      error = e.message;
    } finally {
      loading = false;
    }
  }

  async function updateMatch() {
    if (!match) return;

    try {
      saving = true;
      const { error: updateError } = await supabase
        .from('matches')
        .update({
          team1_id: match.team1_id,
          team2_id: match.team2_id,
          start_time: match.start_time,
          division: match.division,
          status: match.status,
          team1_score: match.team1_score,
          team2_score: match.team2_score
        })
        .eq('id', match.id);

      if (updateError) throw updateError;
      goto('/admin/matches');
    } catch (e) {
      error = e.message;
    } finally {
      saving = false;
    }
  }

  async function deleteMatch() {
    if (!match || !confirm('Are you sure you want to delete this match?')) return;

    try {
      saving = true;
      const { error: deleteError } = await supabase.from('matches').delete().eq('id', match.id);

      if (deleteError) throw deleteError;
      goto('/admin/matches');
    } catch (e) {
      error = e.message;
    } finally {
      saving = false;
    }
  }

  $: teamsByDivision = teams.reduce(
    (acc, team) => {
      if (!acc[team.division]) {
        acc[team.division] = [];
      }
      acc[team.division].push(team);
      return acc;
    },
    {} as Record<string, Team[]>
  );

  $: divisions = [...new Set(teams.map((team) => team.division))].sort();

  $: if (match && match.team1_id && match.team2_id) {
    const team1 = teams.find((t) => t.id === match.team1_id);
    const team2 = teams.find((t) => t.id === match.team2_id);
    if (team1 && team2 && team1.division === team2.division) {
      match.division = team1.division;
    }
  }
</script>

<div class="min-h-screen bg-white p-6 dark:bg-neutral-900">
  <div class="mx-auto max-w-3xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2 class="font-heading text-2xl font-bold uppercase text-white sm:text-3xl">
          {#if loading}
            Loading...
          {:else if match}
            Edit Match: {match.team1.name} vs {match.team2.name}
          {:else}
            Match Not Found
          {/if}
        </h2>
      </div>
      <div class="mt-4 flex space-x-3 md:ml-4 md:mt-0">
        <a
          href="/admin/matches"
          class="inline-flex items-center rounded-md bg-neutral-600 px-3 py-2 text-sm font-semibold text-white hover:bg-neutral-500"
        >
          Cancel
        </a>
        {#if match}
          <button
            type="button"
            on:click={deleteMatch}
            disabled={saving}
            class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white disabled:opacity-50"
          >
            Delete Match
          </button>
        {/if}
      </div>
    </div>

    {#if error}
      <div class="mt-4 flex items-center gap-2 rounded-md border border-primary/40 p-2">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          class="stroke-primary"
          ><g fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
            ><path d="M20 16v2m0 4.01l.01-.011M4 6v6s0 3 7 3s7-3 7-3V6" /><path
              d="M11 3c7 0 7 3 7 3s0 3-7 3s-7-3-7-3s0-3 7-3m0 18c-7 0-7-3-7-3v-6"
            /></g
          ></svg
        >
        <p class="text-sm capitalize leading-none text-neutral-900 dark:text-white">{error}</p>
      </div>
    {/if}

    {#if loading}
      <div class="mt-8 text-white">Loading match information...</div>
    {:else if match}
      <form on:submit|preventDefault={updateMatch} class="mt-8 space-y-6">
        <div>
          <label for="team1" class="block text-sm font-medium text-white">Team 1</label>
          <select
            id="team1"
            bind:value={match.team1_id}
            required
            class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
          >
            <option value="">Select a team</option>
            {#each divisions as division}
              <optgroup label={division}>
                {#each teamsByDivision[division] as team}
                  <option value={team.id} disabled={team.id === match.team2_id}>
                    {team.name}
                  </option>
                {/each}
              </optgroup>
            {/each}
          </select>
        </div>

        <div>
          <label for="team2" class="block text-sm font-medium text-white">Team 2</label>
          <select
            id="team2"
            bind:value={match.team2_id}
            required
            class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
          >
            <option value="">Select a team</option>
            {#each divisions as division}
              <optgroup label={division}>
                {#each teamsByDivision[division] as team}
                  <option value={team.id} disabled={team.id === match.team1_id}>
                    {team.name}
                  </option>
                {/each}
              </optgroup>
            {/each}
          </select>
        </div>

        <div>
          <label for="start_time" class="block text-sm font-medium text-white">Start Time</label>
          <input
            type="datetime-local"
            id="start_time"
            bind:value={match.start_time}
            required
            class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
          />
        </div>

        <div>
          <label for="division" class="block text-sm font-medium text-white">Division</label>
          <input
            type="text"
            id="division"
            bind:value={match.division}
            required
            readonly={match.team1_id && match.team2_id}
            class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm {match.team1_id &&
            match.team2_id
              ? 'opacity-50'
              : ''}"
          />
          {#if match.team1_id && match.team2_id}
            <p class="mt-1 text-sm text-gray-400">Division is set based on selected teams</p>
          {/if}
        </div>

        <div class="grid grid-cols-2 gap-4">
          <div>
            <label for="team1_score" class="block text-sm font-medium text-white">
              {match.team1.name} Score
            </label>
            <input
              type="number"
              id="team1_score"
              bind:value={match.team1_score}
              min="0"
              class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
            />
          </div>

          <div>
            <label for="team2_score" class="block text-sm font-medium text-white">
              {match.team2.name} Score
            </label>
            <input
              type="number"
              id="team2_score"
              bind:value={match.team2_score}
              min="0"
              class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
            />
          </div>
        </div>

        <div>
          <label for="status" class="block text-sm font-medium text-white">Status</label>
          <select
            id="status"
            bind:value={match.status}
            required
            class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
          >
            <option value="upcoming">Upcoming</option>
            <option value="live">Live</option>
            <option value="completed">Completed</option>
          </select>
        </div>

        <div>
          <button
            type="submit"
            disabled={saving}
            class="w-full rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600 disabled:opacity-50"
          >
            {saving ? 'Saving...' : 'Save Changes'}
          </button>
        </div>
      </form>
    {:else}
      <div class="mt-8 text-white">Match not found.</div>
    {/if}
  </div>
</div>
