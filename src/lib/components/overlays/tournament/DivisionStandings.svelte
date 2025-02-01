<script lang="ts">
  import { onMount, onDestroy } from 'svelte';
  import ChevronRight from 'lucide-svelte/icons/chevron-right';
  import Trophy from 'lucide-svelte/icons/trophy';
  import Star from 'lucide-svelte/icons/star';
  import { divisions } from '$lib/stores/tournament';
  import { fetchDivisionStandings, subscribeToTournamentUpdates } from '$lib/stores/tournament';

  export let divisionName: string;
  export let autoExpand = true;
  export let autoExpandInterval = 0;

  let expanded = false;
  let cleanup: () => void;
  let autoExpandTimer: NodeJS.Timeout;

  $: currentDivision = $divisions.find((d) => d.name === divisionName);

  onMount(async () => {
    // Initial data fetch
    await fetchDivisionStandings();

    // Set up real-time subscription
    cleanup = subscribeToTournamentUpdates();

    // Set up auto-expand if enabled
    if (autoExpand && autoExpandInterval > 0) {
      autoExpandTimer = setInterval(() => {
        expanded = !expanded;
      }, autoExpandInterval * 1000);
    }
  });

  onDestroy(() => {
    if (cleanup) cleanup();
    if (autoExpandTimer) clearInterval(autoExpandTimer);
  });
</script>

<div class="w-96 bg-black bg-opacity-90">
  <!-- Header -->
  <div
    class="flex cursor-pointer items-center justify-between bg-primary p-4"
    on:click={() => (expanded = !expanded)}
  >
    <div class="flex items-center space-x-2">
      <Trophy class="h-5 w-5 text-white" />
      <h2 class="font-heading text-xl font-bold tracking-wider text-white">{divisionName}</h2>
    </div>
    <ChevronRight
      class="h-6 w-6 text-white transition-transform duration-300"
      style="transform: rotate({expanded ? '90deg' : '0deg'})"
    />
  </div>

  <!-- Standings table -->
  <div
    class="overflow-hidden transition-all duration-300"
    style="max-height: {expanded ? '24rem' : '0'}"
  >
    {#if currentDivision}
      <div class="p-4">
        <table class="w-full">
          <thead>
            <tr class="text-sm text-gray-400">
              <th class="pb-4 text-left">TEAM</th>
              <th class="pb-4 text-center">W</th>
              <th class="pb-4 text-center">L</th>
              <th class="pb-4 text-right">PTS</th>
            </tr>
          </thead>
          <tbody>
            {#each currentDivision.teams as team, index}
              <tr class="text-white {index === 0 ? 'font-bold' : ''}">
                <td class="flex items-center space-x-2 py-2">
                  {#if index === 0}
                    <Star class="h-4 w-4 text-primary" />
                  {/if}
                  <span>{team.name}</span>
                </td>
                <td class="py-2 text-center">{team.wins}</td>
                <td class="py-2 text-center">{team.losses}</td>
                <td class="py-2 text-right">{team.points}</td>
              </tr>
            {/each}
          </tbody>
        </table>
      </div>
    {:else}
      <div class="p-4 text-gray-400">No standings data available</div>
    {/if}
  </div>
</div>
