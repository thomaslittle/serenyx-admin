<script lang="ts">
  import Card from '../ui/card.svelte';
  import { scale } from 'svelte/transition';
  
  export let name: string;
  export let prizePool: number;
  export let teamCount: number;
  export let maxTeams = 8;
  export let status: 'open' | 'in_progress' | 'completed' = 'open';
</script>

<Card hover class="w-full">
  <div class="flex justify-between items-center mb-4">
    <h3 class="text-xl font-bold text-foreground">{name}</h3>
    <span 
      class="px-3 py-1 rounded text-sm"
      class:bg-primary={status === 'open'}
      class:bg-yellow-500={status === 'in_progress'}
      class:bg-green-500={status === 'completed'}
    >
      {status.replace('_', ' ')}
    </span>
  </div>
  
  <div class="grid grid-cols-2 gap-4 mt-4">
    <div transition:scale>
      <p class="text-sm text-muted-foreground">Prize Pool</p>
      <p class="text-xl font-bold">${prizePool}</p>
    </div>
    <div transition:scale>
      <p class="text-sm text-muted-foreground">Teams</p>
      <p class="text-xl font-bold">{teamCount}/{maxTeams}</p>
    </div>
  </div>
</Card>