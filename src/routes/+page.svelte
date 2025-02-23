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
  let middleTeams = $state([]);
  let leftTournamentTitle = $state('Loading...');
  let rightTournamentTitle = $state('Loading...');
  let middleTournamentTitle = $state('Loading...');
  let someData = $state({});
  let showLeft = $state(false);
  let showRight = $state(false);
  let showMiddle = $state(false);
  let winner = $state({ teamName: '', players: [] });

  // Fetch both tournaments
  $effect(() => {
    loading = true;
    error = null;

    // Array to track all fetch promises
    const fetchPromises = [
      // 2v2 tournament (now left)
      fetch(
        '/api/standings?slug=tournament/serenyx-league-2025-2v2-hub/event/serenyx-league-200-2v2-blitz-1'
      )
        .then((response) => {
          if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
          return response.json();
        })
        .then((data) => {
          leftTeams = data.standings;
          leftTournamentTitle = data.tournamentName;
          someData = data;
        }),

      // 3v3 tournament (middle)
      fetch(
        '/api/standings?slug=tournament/serenyx-league-2025-3v3-hub/event/serenyx-league-360-3v3-meltdown-1'
      )
        .then((response) => {
          if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
          return response.json();
        })
        .then((data) => {
          middleTeams = data.standings;
          middleTournamentTitle = data.tournamentName;
          // Get winner info from first place team
          if (data.standings?.[0]) {
            winner = {
              teamName: data.standings[0].name,
              players: data.standings[0].players || []
            };
          }
        }),

      // 1v1 tournament (now right)
      fetch(
        '/api/standings?slug=tournament/serenyx-league-2025-1v1-hub/event/serenyx-league-100-1v1-gauntlet-2'
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
          showMiddle = true;
          setTimeout(() => {
            showRight = true;
          }, 150);
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
      <a
        href="https://www.instagram.com/serenyx_league/"
        target="_blank"
        rel="noopener noreferrer"
        aria-label="Instagram"
      >
        <iconify-icon icon="tabler:brand-instagram" height="26" class="hover:text-[#e90e4b]"
        ></iconify-icon>
      </a>
      <a
        href="https://www.youtube.com/@SerenyxLeague"
        target="_blank"
        rel="noopener noreferrer"
        aria-label="YouTube"
      >
        <iconify-icon icon="tabler:brand-youtube" height="26" class="hover:text-[#e90e4b]"
        ></iconify-icon>
      </a>
      <a
        href="https://www.tiktok.com/@serenyx.league"
        target="_blank"
        rel="noopener noreferrer"
        aria-label="TikTok"
      >
        <iconify-icon icon="tabler:brand-tiktok" height="26" class="hover:text-[#e90e4b]"
        ></iconify-icon>
      </a>
    </div>

    <div
      class="absolute bottom-0 left-0 right-0 z-0 mx-auto flex items-center justify-center gap-3 border-[#e90e4b] bg-[#e8e4dc]/50 py-2 backdrop-blur-sm"
    >
      <img src="/images/logos-new.png" alt="Serenyx League" />
    </div>

    <!-- Top Teams Component -->
    <div
      class="grid grid-cols-1 gap-4 p-4 md:grid-cols-[320px_320px_320px] xl:grid-cols-[320px_320px_320px]"
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

      <!-- Middle Tournament (3v3) -->
      <div class="flex h-full min-h-[400px] items-center justify-center">
        {#if loading}
          <div class="h-8 w-8 animate-spin rounded-full border-b-2 border-gray-900"></div>
        {:else if error}
          <div class="p-4 text-red-500">{error}</div>
        {:else if showMiddle}
          <div transition:fly={{ y: -20, duration: 300, delay: 150 }}>
            <TopTeams teams={middleTeams} tournamentTitle={middleTournamentTitle} />
          </div>
        {/if}
      </div>

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

    <!-- Add this right before the Top Teams Component div -->
    {#if !loading && !error && winner.teamName}
      <div 
        class="absolute top-24 z-10 text-center w-full"
        transition:fly={{ y: -20, duration: 300 }}
      >
        <h1 class="text-4xl font-bold my-8 text-[#e90e4b] drop-shadow-lg">
          CONGRATS {winner.teamName}
        </h1>
        <p class="text-xl text-[#e90e4b] drop-shadow-lg">
          {winner.players.map(p => p.name).join(' • ')}
        </p>
        <p class="text-lg mt-2 text-black/80 drop-shadow-lg">
          Winners of {middleTournamentTitle}
        </p>
      </div>
    {/if}
  </div>
</main>

<!-- <ScoreBoard data={someData} /> -->
