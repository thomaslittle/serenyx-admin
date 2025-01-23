<script lang="ts">
  import { fade, fly } from 'svelte/transition';
  import Button from '../ui/Button.svelte';
  import { spring } from 'svelte/motion';
  
  export let match: any;
  export let editable = false;
  export let onScoreUpdate = (scores: any) => {};
  
  const score1Spring = spring(match.team1Score || 0);
  const score2Spring = spring(match.team2Score || 0);
  
  $: {
    score1Spring.set(match.team1Score || 0);
    score2Spring.set(match.team2Score || 0);
  }
</script>

<div class="rounded-lg border bg-card p-6 space-y-6" in:fade>
  <div class="grid grid-cols-3 items-center gap-4 text-center">
    <div class="space-y-2">
      <img src={match.team1.logo} alt="" class="w-16 h-16 rounded-full mx-auto" />
      <h3 class="font-bold">{match.team1.name}</h3>
      {#if editable}
        <div class="flex items-center justify-center gap-2">
          <Button 
            variant="outline" 
            size="icon"
            on:click={() => onScoreUpdate({ team1Score: Math.max(0, match.team1Score - 1), team2Score: match.team2Score })}
          >-</Button>
          <span class="text-2xl font-bold w-12">{$score1Spring}</span>
          <Button 
            variant="outline" 
            size="icon"
            on:click={() => onScoreUpdate({ team1Score: match.team1Score + 1, team2Score: match.team2Score })}
          >+</Button>
        </div>
      {:else}
        <p class="text-3xl font-bold">{match.team1Score}</p>
      {/if}
    </div>
    
    <div>
      <div class="text-xl font-bold text-muted-foreground">VS</div>
      <div class="text-sm text-muted-foreground mt-2">
        {new Date(match.date).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
      </div>
    </div>
    
    <div class="space-y-2">
      <img src={match.team2.logo} alt="" class="w-16 h-16 rounded-full mx-auto" />
      <h3 class="font-bold">{match.team2.name}</h3>
      {#if editable}
        <div class="flex items-center justify-center gap-2">
          <Button 
            variant="outline" 
            size="icon"
            on:click={() => onScoreUpdate({ team1Score: match.team1Score, team2Score: Math.max(0, match.team2Score - 1) })}
          >-</Button>
          <span class="text-2xl font-bold w-12">{$score2Spring}</span>
          <Button 
            variant="outline" 
            size="icon"
            on:click={() => onScoreUpdate({ team1Score: match.team1Score, team2Score: match.team2Score + 1 })}
          >+</Button>
        </div>
      {:else}
        <p class="text-3xl font-bold">{match.team2Score}</p>
      {/if}
    </div>
  </div>
</div>