<script lang="ts">
  import { onMount } from 'svelte';
  import { page } from '$app/stores';
  import MatchTicker from '$lib/components/overlays/tournament/MatchTicker.svelte';
  import DivisionStandings from '$lib/components/overlays/tournament/DivisionStandings.svelte';
  import type { DivisionStanding } from '$lib/types/tournament';
  import { divisions } from '$lib/stores/tournament';
  import { fetchDivisionStandings } from '$lib/stores/tournament';
  
  // Get URL parameters
  $: component = $page.url.searchParams.get('component') || 'ticker';
  $: interval = parseInt($page.url.searchParams.get('interval') || '5', 10);
  $: autoExpand = parseInt($page.url.searchParams.get('autoExpand') || '0', 10);
  $: selectedDivisions = ($page.url.searchParams.get('divisions') || '').split(',').filter(Boolean);

  onMount(async () => {
    await fetchDivisionStandings();
  });
</script>

<div class="fixed inset-0 pointer-events-none select-none">
  {#if component === 'ticker'}
    <MatchTicker />
  {:else if component === 'standings'}
    <div class="absolute right-0 top-0 p-4 space-y-4">
      {#each $divisions as division}
        {#if selectedDivisions.length === 0 || selectedDivisions.includes(division.name)}
          <DivisionStandings
            divisionName={division.name}
            autoExpand={autoExpand > 0}
            autoExpandInterval={autoExpand}
          />
        {/if}
      {/each}
    </div>
  {/if}
</div>

<style>
  :global(body) {
    margin: 0;
    padding: 0;
    overflow: hidden;
  }
</style>