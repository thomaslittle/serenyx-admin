<script lang="ts">
  import Button from '$lib/components/ui/Button.svelte';
  import MatchesTable from '$lib/components/matches/MatchesTable.svelte';
  import { fade, fly } from 'svelte/transition';

  export let data;
</script>

<div class="space-y-8" in:fade>
  <div class="flex items-center justify-between">
    <div>
      <h2 class="text-3xl font-bold tracking-tight">Matches</h2>
      <p class="text-muted-foreground">Manage your tournament matches and games</p>
    </div>
    
    <Button href="/admin/matches/new">
      New Match
    </Button>
  </div>

  <div in:fly={{ y: 20, duration: 300 }}>
    <MatchesTable matches={data.matches} />
  </div>
</div>