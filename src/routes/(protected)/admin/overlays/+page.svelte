<script lang="ts">
  import type { Database } from '$lib/supabase/types';
  import { supabase } from '$lib/supabase/client';

  type Overlay = {
    id: string;
    name: string;
    description: string;
    url: string;
    previewUrl: string;
  };

  const overlays: Overlay[] = [
    {
      id: 'match',
      name: 'Match Overlay',
      description: 'Live match scores, player stats, and team information',
      url: '/overlays/match',
      previewUrl: '/api/placeholder/400/225'
    },
    {
      id: 'tournament',
      name: 'Match Schedule',
      description: 'Upcoming matches ticker for tournament schedule',
      url: '/overlays/tournament?component=ticker',
      previewUrl: '/api/placeholder/400/225'
    },
    {
      id: 'tournament',
      name: 'Division Standings',
      description: 'Current tournament standings by division',
      url: '/overlays/tournament?component=standings',
      previewUrl: '/api/placeholder/400/225'
    }
  ];
</script>

<div class="min-h-screen bg-neutral-900 p-8">
  <div class="mx-auto max-w-7xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2
          class="text-2xl font-bold uppercase leading-7 tracking-widest text-white sm:truncate sm:text-3xl"
        >
          Broadcast Overlays
        </h2>
      </div>
    </div>

    <div class="mt-8 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
      {#each overlays as overlay}
        <div
          class="group relative rounded-lg bg-neutral-800 p-6 focus-within:ring-2 focus-within:ring-inset focus-within:ring-red-500"
        >
          <div>
            <span class="inline-flex rounded-lg bg-primary p-3 text-white ring-4 ring-gray-800">
              <!-- Icon placeholder -->
            </span>
          </div>
          <div class="mt-8">
            <h3 class="text-lg font-medium text-white">
              <a href={`/admin/overlays/${overlay.id}`} class="focus:outline-none">
                {overlay.name}
                <span class="absolute inset-0" aria-hidden="true" />
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
              href={`/admin/overlays/${overlay.id}/settings`}
              class="inline-flex items-center rounded-md bg-neutral-700 px-3 py-2 text-sm font-semibold text-white hover:bg-neutral-600"
            >
              Settings
            </a>
            <a
              href={`${overlay.url}/preview`}
              class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white hover:bg-red-500"
              target="_blank"
              rel="noopener noreferrer"
            >
              Preview
            </a>
          </div>
        </div>
      {/each}
    </div>

    <!-- Quickstart Guide -->
    <div class="mt-12 rounded-lg bg-neutral-800 p-6">
      <h3 class="mb-4 text-lg font-medium text-white">Quickstart Guide</h3>
      <div class="prose prose-invert max-w-none">
        <ol class="space-y-4 text-gray-300">
          <li>
            <strong class="text-white">Select an overlay:</strong> Choose the overlay type for the to
            broadcast.
          </li>
          <li>
            <strong class="text-white">Configure settings:</strong> Customize the overlay appearance
            and behavior in the settings panel.
          </li>
          <li>
            <strong class="text-white">Add to OBS:</strong>
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
