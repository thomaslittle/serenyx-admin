<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  import { supabase } from '$lib/supabase/client';
  import type { Database } from '$lib/supabase/types';

  type Team = Database['public']['Tables']['teams']['Row'];
  type Match = Database['public']['Tables']['matches']['Row'];

  let teams: Team[] = [];
  let match: Partial<Match> = {
    team1_id: '',
    team2_id: '',
    start_time: new Date().toISOString().slice(0, 16),
    division: '',
    status: 'upcoming',
    team1_score: 0,
    team2_score: 0
  };
  let error: string | null = null;
  let loading = true;
  let saving = false;

  onMount(async () => {
    await fetchTeams();
  });

  async function fetchTeams() {
    try {
      loading = true;
      const { data, error: fetchError } = await supabase
        .from('teams')
        .select('*')
        .order('division')
        .order('name');

      if (fetchError) throw fetchError;
      teams = data;
    } catch (e) {
      error = e.message;
    } finally {
      loading = false;
    }
  }

  async function createMatch() {
    try {
      saving = true;
      const { data, error: createError } = await supabase
        .from('matches')
        .insert([match])
        .select()
        .single();

      if (createError) throw createError;
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

  $: if (match.team1_id && match.team2_id) {
    const team1 = teams.find((t) => t.id === match.team1_id);
    const team2 = teams.find((t) => t.id === match.team2_id);
    if (team1 && team2 && team1.division === team2.division) {
      match.division = team1.division;
    }
  }
</script>

<div class="min-h-screen bg-neutral-900 p-8">
  <div class="mx-auto max-w-3xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2 class="text-2xl font-bold uppercase tracking-widest text-white sm:text-3xl">
          New Match
        </h2>
      </div>
      <div class="mt-4 flex md:ml-4 md:mt-0">
        <a
          href="/admin/matches"
          class="inline-flex items-center rounded-md bg-neutral-600 px-3 py-2 text-sm font-semibold text-white hover:bg-neutral-500"
        >
          Cancel
        </a>
      </div>
    </div>

    {#if error}
      <div class="mt-4 rounded-md bg-red-500 p-4">
        <p class="text-sm text-white">{error}</p>
      </div>
    {/if}

    {#if loading}
      <div class="mt-8 text-white">Loading teams...</div>
    {:else}
      <form on:submit|preventDefault={createMatch} class="mt-8 space-y-6">
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
            <label for="team1_score" class="block text-sm font-medium text-white"
              >Team 1 Score</label
            >
            <input
              type="number"
              id="team1_score"
              bind:value={match.team1_score}
              min="0"
              class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
            />
          </div>

          <div>
            <label for="team2_score" class="block text-sm font-medium text-white"
              >Team 2 Score</label
            >
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
            class="w-full rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600 disabled:opacity-50"
          >
            {saving ? 'Creating...' : 'Create Match'}
          </button>
        </div>
      </form>
    {/if}
  </div>
</div>
