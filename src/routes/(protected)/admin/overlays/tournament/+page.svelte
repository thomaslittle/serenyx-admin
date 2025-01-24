<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  import { divisions } from '$lib/stores/tournament';
  import { fetchDivisionStandings } from '$lib/stores/tournament';

  let overlayUrl = '';
  let selectedComponent = 'ticker';
  let tickerInterval = 5;
  let autoExpandInterval = 0;
  let selectedDivisions: string[] = [];

  onMount(async () => {
    await fetchDivisionStandings();
    // Set initial selected divisions
    selectedDivisions = $divisions.map((d) => d.name);
  });

  function generateOverlayUrl() {
    const baseUrl = window.location.origin;
    const params = new URLSearchParams();

    params.set('component', selectedComponent);

    if (selectedComponent === 'ticker') {
      params.set('interval', tickerInterval.toString());
    } else if (selectedComponent === 'standings') {
      params.set('divisions', selectedDivisions.join(','));
      params.set('autoExpand', autoExpandInterval.toString());
    }

    overlayUrl = `${baseUrl}/overlays/tournament?${params.toString()}`;
  }

  function toggleDivision(divisionName: string) {
    if (selectedDivisions.includes(divisionName)) {
      selectedDivisions = selectedDivisions.filter((d) => d !== divisionName);
    } else {
      selectedDivisions = [...selectedDivisions, divisionName];
    }
  }
</script>

<div class="min-h-screen bg-neutral-900 p-8">
  <div class="mx-auto max-w-7xl">
    <h2 class="mb-8 text-2xl font-bold text-white">Tournament Overlay Controls</h2>

    <!-- Overlay Selection -->
    <div class="mb-8 rounded-lg bg-neutral-800 p-6">
      <h3 class="mb-4 text-lg font-medium text-white">Select Component</h3>

      <div class="space-y-4">
        <div class="flex items-center space-x-4">
          <input
            type="radio"
            id="ticker"
            bind:group={selectedComponent}
            value="ticker"
            class="h-4 w-4 border-gray-600 bg-neutral-700 text-primary focus:ring-red-600"
          />
          <label for="ticker" class="text-white">Match Schedule Ticker</label>
        </div>

        <div class="flex items-center space-x-4">
          <input
            type="radio"
            id="standings"
            bind:group={selectedComponent}
            value="standings"
            class="h-4 w-4 border-gray-600 bg-neutral-700 text-primary focus:ring-red-600"
          />
          <label for="standings" class="text-white">Division Standings</label>
        </div>
      </div>

      <button
        on:click={generateOverlayUrl}
        class="mt-6 rounded-md bg-primary px-4 py-2 text-white transition-colors hover:bg-red-500"
      >
        Generate Overlay URL
      </button>
    </div>

    <!-- Component Settings -->
    <div class="mt-8 space-y-8">
      {#if selectedComponent === 'ticker'}
        <div class="rounded-lg bg-neutral-800 p-6">
          <h3 class="mb-4 text-lg font-medium text-white">Ticker Settings</h3>
          <div class="space-y-4">
            <div>
              <label class="mb-2 block text-sm font-medium text-white">
                Update Interval (seconds)
              </label>
              <input
                type="number"
                min="1"
                max="60"
                bind:value={tickerInterval}
                class="w-32 rounded-md border-0 bg-neutral-700 px-4 py-2 text-white ring-1 ring-inset ring-gray-600"
              />
            </div>
          </div>
        </div>
      {:else if selectedComponent === 'standings'}
        <div class="rounded-lg bg-neutral-800 p-6">
          <h3 class="mb-4 text-lg font-medium text-white">Standings Settings</h3>
          <div class="space-y-4">
            <div>
              <label class="mb-2 block text-sm font-medium text-white"> Divisions to Show </label>
              <div class="space-y-2">
                {#each $divisions as division}
                  <label class="flex items-center space-x-2">
                    <input
                      type="checkbox"
                      checked={selectedDivisions.includes(division.name)}
                      on:change={() => toggleDivision(division.name)}
                      class="rounded border-gray-600 bg-neutral-700 text-primary focus:ring-red-600"
                    />
                    <span class="text-white">{division.name}</span>
                  </label>
                {/each}
              </div>
            </div>
            <div>
              <label class="mb-2 block text-sm font-medium text-white">
                Auto-expand Interval (seconds)
              </label>
              <input
                type="number"
                min="0"
                max="60"
                bind:value={autoExpandInterval}
                class="w-32 rounded-md border-0 bg-neutral-700 px-4 py-2 text-white ring-1 ring-inset ring-gray-600"
              />
              <p class="mt-1 text-sm text-gray-400">Set to 0 to disable auto-expansion</p>
            </div>
          </div>
        </div>
      {/if}
    </div>

    {#if overlayUrl}
      <!-- Overlay URL -->
      <div class="mb-8 rounded-lg bg-neutral-800 p-6">
        <h3 class="mb-4 text-lg font-medium text-white">Overlay URL</h3>
        <div class="flex items-center space-x-4">
          <input
            type="text"
            readonly
            value={overlayUrl}
            class="flex-1 rounded-md border-0 bg-neutral-700 px-4 py-2 text-white ring-1 ring-inset ring-gray-600"
          />
          <button
            on:click={() => navigator.clipboard.writeText(overlayUrl)}
            class="rounded-md bg-neutral-700 px-4 py-2 text-white transition-colors hover:bg-neutral-600"
          >
            Copy
          </button>
        </div>
        <p class="mt-2 text-sm text-gray-400">Use this URL as a Browser Source in OBS</p>
      </div>

      <!-- Preview -->
      <div class="rounded-lg bg-neutral-800 p-6">
        <h3 class="mb-4 text-lg font-medium text-white">Preview</h3>
        <div class="relative aspect-video w-full overflow-hidden rounded-lg bg-neutral-900">
          <iframe title="Overlay Preview" src={overlayUrl} class="h-full w-full border-0"></iframe>
        </div>
        <p class="mt-2 text-sm text-gray-400">This is how the overlay will appear in OBS</p>
      </div>
    {/if}
  </div>
</div>
