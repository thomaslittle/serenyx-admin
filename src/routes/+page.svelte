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
        '/api/standings?slug=tournament/serenyx-league-na-120-3v3-meltdown-2/event/weekly-120-3v3-meltdown-2'
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
  <div class="relative min-h-screen bg-white" style="min-height: calc(100vh)">
    <!-- Video background -->
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

    <!-- Social icons stay absolute -->
    <div class="text-white lg:text-black text-shadow-sm absolute right-0 top-0 z-50 mx-auto flex items-center justify-center gap-3 p-4 drop-shadow-md">
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

    <!-- Main content grid -->
    <div class="relative z-10 grid min-h-screen grid-rows-[auto_1fr_auto] py-32">
      <!-- Winners section -->
      {#if !loading && !error && winner.teamName}
        <div 
          class="text-center mb-8 mx-4 bg-[#e8e4dc]/90 py-4 lg:bg-transparent"
          transition:fly={{ y: -20, duration: 300 }}
        >
          <h1 class="lg:text-7xl md:text-5xl text-4xl font-bold mb-2 text-[#e90e4b] drop-shadow-lg">
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

      <!-- Tournaments grid -->
      <div class="grid grid-cols-1 gap-8 p-4 place-content-center place-items-center lg:grid-cols-3">
        <!-- Left Tournament (2v2) -->
        <div class="w-full max-w-[320px] flex h-full min-h-[400px] items-center justify-center">
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
        <div class="w-full max-w-[320px] flex h-full min-h-[400px] items-center justify-center">
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
        <div class="w-full max-w-[320px] flex h-full min-h-[400px] items-center justify-center">
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

      <!-- Sponsor logos -->
      <div class="mx-auto w-full flex items-center justify-center gap-3 border-[#e90e4b] bg-[#e8e4dc]/50 py-2 backdrop-blur-sm">
        <img src="/images/logos-new.png" alt="Serenyx League" />
      </div>
    </div>
  </div>
</main>

<!-- <ScoreBoard data={someData} /> -->
