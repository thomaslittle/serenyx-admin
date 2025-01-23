<script lang="ts">
  import { fade, fly } from 'svelte/transition';
  import { spring } from 'svelte/motion';
  
  export let data;
  
  let matches = data.matches;
  let activeRound = 0;
  
  const scale = spring(1);
  
  function getMatchPosition(match) {
    const round = match.round - 1;
    const matchInRound = match.matchInRound - 1;
    const totalMatchesInRound = matches.filter(m => m.round === match.round).length;
    const y = (matchInRound / totalMatchesInRound) * 100;
    
    return {
      left: `${round * 25}%`,
      top: `${y}%`
    };
  }
</script>

<div class="fixed inset-0 flex items-center justify-center p-8 bg-background/95" in:fade>
  <div class="relative w-full h-full max-w-7xl">
    {#each matches as match (match.id)}
      <div
        class="absolute transform -translate-x-1/2 -translate-y-1/2 w-64 transition-all duration-500"
        style="left: {getMatchPosition(match).left}; top: {getMatchPosition(match).top};"
      >
        <div 
          class="rounded-lg border bg-card p-4 space-y-4"
          style="transform: scale({$scale})"
          in:fly={{ y: 20 }}
        >
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-2">
              <img src={match.team1.logo} alt="" class="w-8 h-8 rounded-full" />
              <span class="font-medium">{match.team1.name}</span>
            </div>
            <span class="font-bold">{match.team1Score || 0}</span>
          </div>
          
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-2">
              <img src={match.team2.logo} alt="" class="w-8 h-8 rounded-full" />
              <span class="font-medium">{match.team2.name}</span>
            </div>
            <span class="font-bold">{match.team2Score || 0}</span>
          </div>
          
          {#if match.status === 'live'}
            <div class="absolute -top-2 -right-2 w-4 h-4 rounded-full bg-primary animate-pulse" />
          {/if}
        </div>
        
        {#if match.nextMatchId}
          <div class="absolute top-1/2 right-0 w-full h-px bg-border" />
        {/if}
      </div>
    {/each}
    
    <div class="absolute top-4 left-4 space-x-2">
      {#each Array(Math.max(...matches.map(m => m.round))) as _, i}
        <button
          class="px-3 py-1 rounded-full text-sm transition-colors"
          class:bg-primary={activeRound === i}
          class:text-primary-foreground={activeRound === i}
          on:click={() => activeRound = i}
        >
          Round {i + 1}
        </button>
      {/each}
    </div>
  </div>
</div>