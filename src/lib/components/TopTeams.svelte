<script lang="ts">
  import { fly } from 'svelte/transition';
  const { teams, tournamentTitle } = $props<{
    teams: {
      placement: number;
      name: string;
      participants: { gamerTag: string }[];
    }[];
    tournamentTitle: string;
  }>();

  let currentPage = $state(1);
  const itemsPerPage = 3;
  const paginatedTeams = $derived(
    teams.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage)
  );
  const totalPages = $derived(Math.ceil(teams.length / itemsPerPage));
  let transitionDirection = $state<'left' | 'right'>('left');

  function handlePageChange(direction: 'left' | 'right') {
    transitionDirection = direction;
    if (direction === 'left') {
      currentPage--;
    } else {
      currentPage++;
    }
  }
</script>

<div
  class="relative z-[9999] w-80 border-b-[2px] border-l-[6px] border-[#e90e4b] bg-[#e8e4dc]/80 p-6 shadow-2xl backdrop-blur-sm transition-all md:mt-0"
>
  <h3 class="mb-6 text-xl font-bold uppercase text-black">{tournamentTitle}</h3>
  <div class="max-h-[400px] space-y-5 overflow-y-auto">
    {#key currentPage}
      {#each paginatedTeams as team, index}
        <div
          transition:fly={{
            x: transitionDirection === 'left' ? -50 : 50,
            duration: 200
          }}
          class="flex items-center gap-4"
        >
          {#if team.placement <= 3}
            <div class="flex items-center justify-center">
              {#if team.placement === 1}
                <iconify-icon
                  width="44"
                  icon="pepicons-pop:trophy-circle-filled"
                  class="text-yellow-400 drop-shadow-sm"
                />
              {:else if team.placement === 2}
                <iconify-icon
                  width="44"
                  icon="pepicons-pop:trophy-circle-filled"
                  class="text-gray-400"
                />
              {:else if team.placement === 3}
                <iconify-icon
                  width="44"
                  icon="pepicons-pop:trophy-circle-filled"
                  class="text-amber-700"
                />
              {/if}
            </div>
          {/if}
          <div class="flex flex-col">
            <span class="text-lg font-black uppercase text-black">{team.name}</span>
            <div class="flex flex-wrap gap-1">
              {#each team.participants as participant, index}
                <span class="font-regular text-sm text-black">
                  {participant.gamerTag}
                  {#if index < team.participants.length - 1}
                    /
                  {/if}
                </span>
              {/each}
            </div>
            <span class="text-sm font-black text-[#e90e4b]">
              {team.placement}{team.placement === 1
                ? 'st'
                : team.placement === 2
                  ? 'nd'
                  : team.placement === 3
                    ? 'rd'
                    : 'th'}
            </span>
          </div>
        </div>
        {#if index !== paginatedTeams.length - 1}
          <div class="border-b border-[#e90e4b]/20" />
        {/if}
      {/each}
    {/key}
  </div>

  {#if totalPages > 1}
    <div class="mt-4 flex items-center justify-between">
      <button
        onclick={() => handlePageChange('left')}
        disabled={currentPage === 1}
        class="pt-2 text-[#e90e4b] disabled:opacity-50"
        aria-label="Previous page"
      >
        <iconify-icon icon="teenyicons:double-caret-left-small-outline" width="24"></iconify-icon>
      </button>
      <span class="text-sm text-gray-700">{currentPage}/{totalPages}</span>
      <button
        onclick={() => handlePageChange('right')}
        disabled={currentPage === totalPages}
        class="pt-2 text-[#e90e4b] disabled:opacity-50"
        aria-label="Next page"
      >
        <iconify-icon icon="teenyicons:double-caret-right-small-outline" width="24"></iconify-icon>
      </button>
    </div>
  {/if}
</div>
