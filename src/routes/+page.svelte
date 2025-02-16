<script lang="ts">
  import { useClerkContext } from 'svelte-clerk';
  import Loader from '$lib/components/ui/loader.svelte';
  import TopTeams from '$lib/components/TopTeams.svelte';
  import { onMount } from 'svelte';
  import 'iconify-icon';
  import { page } from '$app/stores';
  import { fly } from 'svelte/transition';

  const ctx = useClerkContext();
  const userId = $derived(ctx.auth.userId);
  const firstName = $derived(ctx.user?.firstName);

  let loading = $state(true);
  let error = $state<string | null>(null);
  let leftTeams = $state([]);
  let rightTeams = $state([]);
  let leftTournamentTitle = $state('Loading...');
  let rightTournamentTitle = $state('Loading...');

  let showLeft = $state(false);
  let showRight = $state(false);

  // Fetch both tournaments
  $effect(() => {
    loading = true;
    error = null;

    // Array to track all fetch promises
    const fetchPromises = [
      // Left tournament
      fetch(
        '/api/standings?slug=tournament/serenyx-league-2025-1v1-hub/event/serenyx-league-100-1v1-gauntlet-2'
      )
        .then((response) => {
          if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
          return response.json();
        })
        .then((data) => {
          leftTeams = data.standings;
          leftTournamentTitle = data.tournamentName;
        }),

      // Right tournament
      fetch(
        '/api/standings?slug=tournament/serenyx-league-2025-2v2-hub/event/serenyx-league-200-2v2-blitz-1'
      )
        .then((response) => {
          if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
          return response.json();
        })
        .then((data) => {
          rightTeams = data.standings;
          rightTournamentTitle = data.tournamentName;
        })
    ];

    // Handle all fetch operations
    Promise.all(fetchPromises)
      .catch((err) => {
        console.error('Error fetching tournaments:', err);
        error = err.message;
      })
      .finally(() => {
        loading = false;
      });
  });

  $effect(() => {
    if (!loading && !error) {
      // Trigger animations after a short delay
      setTimeout(() => {
        showLeft = true;
        setTimeout(() => {
          showRight = true;
        }, 150);
      }, 100);
    }
  });
</script>

<main class="relative">
  <div
    class="relative flex min-h-screen items-center justify-center bg-white"
    style="min-height: calc(100vh)"
  >
    <!-- Fullscreen video -->

    <video
      autoplay
      muted
      loop
      playsinline
      class="absolute inset-0 h-full w-full object-cover opacity-100"
    >
      <source src="https://cdn.serenyxleague.com/r/csvCjr.webm" type="video/webm" />
      Your browser does not support the video tag.
    </video>

    <div
      class="text-shadow-sm absolute right-0 top-0 z-10 mx-auto flex items-center justify-center gap-3 p-4 drop-shadow-md"
    >
      <a
        href="https://www.twitch.tv/serenyxleague"
        target="_blank"
        rel="noopener noreferrer"
        aria-label="Twitch"
      >
        <iconify-icon icon="tabler:brand-twitch" height="26" class="hover:text-[#e90e4b]"
        ></iconify-icon>
      </a>
      <a
        href="https://discord.com/invite/7V6GXAtERT"
        target="_blank"
        rel="noopener noreferrer"
        aria-label="Discord"
      >
        <iconify-icon icon="tabler:brand-discord" height="26" class="hover:text-[#e90e4b]"
        ></iconify-icon>
      </a>
      <a
        href="https://x.com/SerenyxLeague"
        target="_blank"
        rel="noopener noreferrer"
        aria-label="X (Twitter)"
      >
        <iconify-icon icon="tabler:brand-x" height="26" class="hover:text-[#e90e4b]"></iconify-icon>
      </a>
    </div>

    <div
      class="absolute bottom-0 left-0 right-0 z-0 mx-auto flex items-center justify-center gap-3 border-[#e90e4b] bg-[#e8e4dc]/50 py-2 backdrop-blur-sm"
    >
      <img src="/images/sponsor-logos.png" alt="Serenyx League" />
    </div>

    <!-- Top Teams Component -->
    <div
      class="grid grid-cols-1 gap-4 p-4 md:grid-cols-[320px_80px_320px] xl:grid-cols-[320px_600px_320px]"
    >
      <!-- Left Tournament (2v2) -->
      <div class="mt-8 flex h-full min-h-[400px] items-center justify-center md:mt-0">
        {#if loading}
          <div class="h-8 w-8 animate-spin rounded-full border-b-2 border-gray-900"></div>
        {:else if error}
          <div class="p-4 text-red-500">{error}</div>
        {:else if showLeft}
          <div transition:fly={{ y: -20, duration: 300 }}>
            <TopTeams teams={leftTeams} tournamentTitle={leftTournamentTitle} />
          </div>
        {/if}
      </div>

      <!-- Empty column for desktop spacing -->
      <div class="hidden md:block"></div>

      <!-- Right Tournament (1v1) -->
      <div class="mb-32 flex h-full min-h-[400px] items-center justify-center md:mb-0">
        {#if loading}
          <div class="h-8 w-8 animate-spin rounded-full border-b-2 border-gray-900"></div>
        {:else if error}
          <div class="p-4 text-red-500">{error}</div>
        {:else if showRight}
          <div transition:fly={{ y: -20, duration: 300, delay: 150 }}>
            <TopTeams teams={rightTeams} tournamentTitle={rightTournamentTitle} />
          </div>
        {/if}
      </div>
    </div>
  </div>
</main>
