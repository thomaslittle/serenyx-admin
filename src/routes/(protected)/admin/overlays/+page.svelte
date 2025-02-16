<script lang="ts">
  type Overlay = {
    id: string;
    name: string;
    description: string;
    url: string;
    type: 'scoreboard' | 'calendar' | 'trophy';
  };

  const overlays: Overlay[] = [
    {
      id: 'timer',
      name: 'timer',
      description: 'Contdown timer/stream starting screen',
      url: '',
      type: 'scoreboard'
    },
    {
      id: 'desk',
      name: 'desk',
      description: 'Caster Booth',
      url: '',
      type: 'scoreboard'
    },
    {
      id: 'match',
      name: 'Match Overlay',
      description: 'Live match scores, player stats, and team information',
      url: '',
      type: 'scoreboard'
    },
    {
      id: 'tournament',
      name: 'Match Schedule',
      description: 'Upcoming matches ticker for tournament schedule',
      url: '',
      type: 'calendar'
    },
    {
      id: 'tournament',
      name: 'Division Standings',
      description: 'Current tournament standings by division',
      url: '',
      type: 'trophy'
    }
  ];

  const iconMap = {
    scoreboard: ScoreBoard,
    calendar: CalendarStats,
    trophy: Trophy
  };
</script>

<div class="min-h-screen bg-white p-6 dark:bg-neutral-900">
  <div class="mx-auto max-w-7xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2
          class="font-heading text-2xl font-bold uppercase leading-7 text-neutral-900 dark:text-white sm:truncate sm:text-3xl"
        >
          Broadcast Overlays
        </h2>
      </div>
    </div>

    <div class="mt-8 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
      {#each overlays as overlay}
        <div
          class="group relative rounded-lg bg-neutral-100 p-6 focus-within:ring-2 focus-within:ring-inset focus-within:ring-red-500 dark:bg-neutral-800"
        >
          <div>
            <span class="inline-flex size-10 rounded-lg dark:text-white">
              {#if iconMap[overlay.type]}
                <svelte:component this={iconMap[overlay.type]} class="size-10" />
              {:else}
                <ScoreBoard class="size-10" /> <!-- Fallback icon -->
              {/if}
            </span>
          </div>
          <div class="mt-4">
            <h3 class="text-lg font-medium text-neutral-900 dark:text-white">
              <a
                href={`/admin/overlays/${overlay.id}`}
                class="font-bold uppercase focus:outline-none"
              >
                {overlay.name}
              </a>
            </h3>
            <p class="mt-2 text-sm text-gray-400">
              {overlay.description}
            </p>
          </div>
          <div class="mt-4">
            <!-- <img
							src={overlay.previewUrl}
							alt={`Preview of ${overlay.name}`}
							class="h-48 w-full rounded-md object-cover"
						/> -->
          </div>
          <div class="mt-4 flex space-x-2">
            <a
              href={`/admin/overlays/${overlay.id}`}
              class="inline-flex items-center rounded-md bg-neutral-200 px-3 py-2 text-sm font-semibold text-neutral-900 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
            >
              Settings
            </a>
            <!-- <a
              href={`${overlay.url}/preview`}
              class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white"
              target="_blank"
              rel="noopener noreferrer"
            >
              Preview
            </a> -->
          </div>
        </div>
      {/each}
    </div>

    <!-- Quickstart Guide -->
    <div class="mt-12 rounded-lg bg-neutral-100 p-6 dark:bg-neutral-800">
      <h2 class="font-heading mb-4 text-2xl font-black uppercase text-primary">Quickstart Guide</h2>
      <div class="prose prose-invert max-w-none">
        <ol class="space-y-4 text-neutral-900 dark:text-white">
          <li>
            <strong class="text-neutral-900 dark:text-white">Select an overlay:</strong> Choose the overlay
            type for the to broadcast.
          </li>
          <li>
            <strong class="text-neutral-900 dark:text-white">Configure settings:</strong> Customize the
            overlay appearance and behavior in the settings panel.
          </li>
          <li>
            <strong class="text-neutral-900 dark:text-white">Add to OBS:</strong>
            <ul class="mt-2 space-y-2">
              <li>Add a new "Browser" source in OBS</li>
              <li>Copy the overlay URL from the settings or preview page</li>
              <li>Set the width to 1920 and height to 1080</li>
              <li>Enable "Refresh browser when scene becomes active" if needed</li>
            </ul>
          </li>
        </ol>
      </div>
    </div>
  </div>
</div>

<style>
  /* Add custom prose styling for dark theme */
  :global(.prose-invert) {
    --tw-prose-invert-headings: theme(colors.white);
    --tw-prose-invert-body: theme(colors.gray.300);
  }
</style>
