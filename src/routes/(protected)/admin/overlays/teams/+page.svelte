<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from '$lib/supabase/client';
  import type { Database } from '$lib/supabase/types';

  type Team = Database['public']['Tables']['teams']['Row'];
  type TeamOverlay = {
    team: Team;
    visible: boolean;
    position: 'left' | 'right';
  };

  let teams: Team[] = [];
  let selectedTeams: TeamOverlay[] = [];
  let loading = true;
  let error: string | null = null;

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
        .order('points', { ascending: false });

      if (fetchError) throw fetchError;
      teams = data;
    } catch (e) {
      error = e.message;
    } finally {
      loading = false;
    }
  }

  function addTeamToOverlay(team: Team) {
    if (selectedTeams.length >= 2) {
      error = 'You can only add up to 2 teams to the overlay';
      return;
    }

    if (selectedTeams.some((t) => t.team.id === team.id)) {
      error = 'This team is already in the overlay';
      return;
    }

    const position = selectedTeams.length === 0 ? 'left' : 'right';
    selectedTeams = [...selectedTeams, { team, visible: true, position }];
    error = null;
  }

  function removeTeamFromOverlay(teamId: string) {
    selectedTeams = selectedTeams.filter((t) => t.team.id !== teamId);
  }

  function toggleTeamVisibility(teamId: string) {
    selectedTeams = selectedTeams.map((t) =>
      t.team.id === teamId ? { ...t, visible: !t.visible } : t
    );
  }

  function swapTeamPositions() {
    if (selectedTeams.length !== 2) return;
    selectedTeams = selectedTeams.map((t) => ({
      ...t,
      position: t.position === 'left' ? 'right' : 'left'
    }));
  }

  function getStreamUrl() {
    if (selectedTeams.length === 0) return '';
    const params = new URLSearchParams();
    selectedTeams.forEach((t) => {
      params.append('team', t.team.id);
      params.append('visible', t.visible.toString());
      params.append('position', t.position);
    });
    return `/overlays/teams?${params.toString()}`;
  }
</script>

<div class="min-h-screen bg-white p-8 dark:bg-neutral-900">
  <div class="mx-auto max-w-7xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2 class="font-heading text-2xl font-bold uppercase text-white sm:text-3xl">
          Team Overlays
        </h2>
      </div>
    </div>

    {#if error}
      <div class="mt-4 rounded-md bg-red-500 p-4">
        <p class="text-sm capitalize leading-none text-neutral-900 dark:text-white">{error}</p>
      </div>
    {/if}

    <div class="mt-8 grid grid-cols-1 gap-8 lg:grid-cols-2">
      <!-- Team Selection -->
      <div class="rounded-lg bg-neutral-800 p-6 dark:bg-neutral-800">
        <h3 class="text-lg font-medium text-white">Available Teams</h3>
        {#if loading}
          <div class="mt-4 text-white">Loading teams...</div>
        {:else}
          <div class="mt-4 space-y-4">
            {#each teams as team}
              <div class="flex items-center justify-between">
                <div class="flex items-center">
                  {#if team.logo_url}
                    <img src={team.logo_url} alt="" class="h-8 w-8 flex-shrink-0 rounded-full" />
                  {/if}
                  <span class="ml-3 text-sm text-white">{team.name}</span>
                </div>
                <button
                  on:click={() => addTeamToOverlay(team)}
                  class="bg-primarypx-2.5 inline-flex items-center rounded-md py-1.5 text-sm font-semibold text-white"
                >
                  Add to Overlay
                </button>
              </div>
            {/each}
          </div>
        {/if}
      </div>

      <!-- Overlay Preview and Controls -->
      <div class="rounded-lg bg-neutral-800 p-6 dark:bg-neutral-800">
        <h3 class="text-lg font-medium text-white">Current Overlay</h3>
        <div class="mt-4">
          {#if selectedTeams.length === 0}
            <p class="text-sm text-gray-400">No teams selected</p>
          {:else}
            <div class="space-y-4">
              {#each selectedTeams as { team, visible, position }}
                <div class="flex items-center justify-between rounded-md bg-neutral-700 p-4">
                  <div class="flex items-center">
                    {#if team.logo_url}
                      <img src={team.logo_url} alt="" class="h-8 w-8 flex-shrink-0 rounded-full" />
                    {/if}
                    <span class="ml-3 text-sm text-white">{team.name}</span>
                    <span class="ml-2 text-sm text-gray-400">({position})</span>
                  </div>
                  <div class="flex space-x-2">
                    <button
                      on:click={() => toggleTeamVisibility(team.id)}
                      class="inline-flex items-center rounded-md bg-neutral-600 px-2.5 py-1.5 text-sm font-semibold text-white hover:bg-neutral-500"
                    >
                      {visible ? 'Hide' : 'Show'}
                    </button>
                    <button
                      on:click={() => removeTeamFromOverlay(team.id)}
                      class="bg-primarypx-2.5 inline-flex items-center rounded-md py-1.5 text-sm font-semibold text-white"
                    >
                      Remove
                    </button>
                  </div>
                </div>
              {/each}

              {#if selectedTeams.length === 2}
                <button
                  on:click={swapTeamPositions}
                  class="mt-4 w-full rounded-md bg-neutral-600 px-3 py-2 text-sm font-semibold text-white hover:bg-neutral-500"
                >
                  Swap Positions
                </button>
              {/if}

              <div class="mt-6">
                <h4 class="text-sm font-medium text-white">Overlay URL</h4>
                <input
                  type="text"
                  readonly
                  value={getStreamUrl()}
                  class="mt-1 w-full rounded-md bg-neutral-700 px-3 py-2 text-sm text-white"
                />
              </div>
            </div>
          {/if}
        </div>
      </div>
    </div>
  </div>
</div>
