<script lang="ts">
  import { onMount, onDestroy } from 'svelte';
  import { Clock } from 'lucide-svelte';
  import {
    matches,
    standings,
    eventInfo,
    fetchScheduledMatches,
    subscribeToTournamentUpdates
  } from '$lib/stores/startgg';

  let currentIndex = $state(0);
  let loading = $state(true);
  let error = $state<string | null>(null);
  let interval: ReturnType<typeof setInterval>;
  let showingStats = $state(false);

  // Function to advance to next match or stat
  function nextItem() {
    if (showingStats) {
      // Always go back to matches when in stats view
      showingStats = false;
      currentIndex = 0;
    } else {
      // Only switch to stats if we have standings and we're at the end of matches
      if (currentIndex + 1 >= $matches.length && $standings.length > 0) {
        showingStats = true;
        currentIndex = 0;
      } else {
        currentIndex = (currentIndex + 1) % $matches.length;
      }
    }
  }

  // Refresh matches periodically
  async function refreshMatches() {
    try {
      await fetchScheduledMatches();
      loading = false;
      if (currentIndex >= $matches.length) {
        currentIndex = 0;
      }
    } catch (err) {
      error = err instanceof Error ? err.message : 'An error occurred';
      loading = false;
    }
  }

  onMount(() => {
    refreshMatches();
    interval = setInterval(nextItem, 5000);
    const refreshInterval = setInterval(refreshMatches, 30000);
    const cleanup = subscribeToTournamentUpdates();

    return () => {
      clearInterval(interval);
      clearInterval(refreshInterval);
      cleanup();
    };
  });
</script>

<div class="fixed bottom-0 left-0 right-0 bg-transparent">
  <!-- Tournament Info -->
  <div class="border-b border-red-600 py-2 text-center">
    <h2 class="text-lg font-bold text-black">{$eventInfo.name}</h2>
    <p class="text-sm text-gray-600">{$eventInfo.date}</p>
  </div>

  <!-- Ticker -->
  <div class="relative h-12 overflow-hidden">
    <div class="absolute left-0 right-0 top-0 h-1 bg-red-600"></div>

    <div class="flex h-full items-center bg-[#e8e4dc]/80 px-4">
      <div class="flex items-center space-x-2 border-r border-red-600 pr-4 text-red-600">
        <Clock class="h-4 w-4" />
        <span class="text-sm font-bold">
          {showingStats ? 'STANDINGS' : 'UPCOMING'}
        </span>
      </div>

      <div class="relative h-full flex-1">
        {#if loading}
          <div class="flex items-center justify-center">
            <div class="h-4 w-4 animate-spin rounded-full border-b-2 border-red-600"></div>
          </div>
        {:else if error}
          <div class="text-sm text-red-500">{error}</div>
        {:else if showingStats}
          <div class="relative h-full overflow-hidden">
            {#each $standings as standing, index (index)}
              <div
                class="match-item absolute inset-0 flex items-center justify-between px-4"
                class:active={index === currentIndex}
                style="transform: translateY({(index - currentIndex) * 100}%)"
              >
                <div class="flex items-center space-x-4">
                  <span class="text-red-600">#{standing.placement}</span>
                  <span class="text-black">{standing.team}</span>
                  <span class="text-red-600">{standing.score} pts</span>
                </div>
              </div>
            {/each}
          </div>
        {:else if $matches.length === 0}
          <div class="flex h-full items-center justify-center">
            <span class="text-gray-600">No upcoming matches</span>
          </div>
        {:else}
          <div class="relative h-full overflow-hidden">
            {#each $matches as match, index (match.id)}
              <div
                class="match-item absolute inset-0 flex items-center justify-between px-4"
                class:active={index === currentIndex}
                style="transform: translateY({(index - currentIndex) * 100}%)"
              >
                <div class="flex items-center space-x-4">
                  <span class="text-red-600">{match.time}</span>
                  <span class="text-black">{match.team1}</span>
                  <span class="font-bold text-red-600">VS</span>
                  <span class="text-black">{match.team2}</span>
                </div>
                <div class="text-sm text-gray-600">{match.division}</div>
              </div>
            {/each}
          </div>
        {/if}
      </div>

      <!-- Counter -->
      {#if ($matches.length > 0 && !showingStats) || ($standings.length > 0 && showingStats)}
        <div class="border-l border-red-600 pl-4 text-sm text-gray-600">
          {#if showingStats}
            {currentIndex + 1} / {$standings.length}
          {:else}
            {currentIndex + 1} / {$matches.length}
          {/if}
        </div>
      {/if}
    </div>
  </div>
</div>

<style>
  .match-item {
    transition:
      transform 500ms ease-in-out,
      opacity 500ms ease-in-out;
    opacity: 0;
    will-change: transform, opacity;
  }

  .match-item.active {
    opacity: 1;
  }
</style>
