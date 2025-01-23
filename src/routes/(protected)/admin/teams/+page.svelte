<script lang="ts">
  import TeamGrid from '$lib/components/teams/TeamGrid.svelte';
  import Button from '$lib/components/ui/Button.svelte';
  import { fade, fly } from 'svelte/transition';
  
  export let data;
</script>

<div class="space-y-8" in:fade>
  <div class="flex items-center justify-between">
    <div>
      <h2 class="text-3xl font-bold tracking-tight">Teams</h2>
      <p class="text-muted-foreground">Manage tournament teams and rosters</p>
    </div>
    
    <Button href="/admin/teams/new">
      Add Team
    </Button>
  </div>
  
  <div in:fly={{ y: 20, duration: 300 }}>
    <TeamGrid teams={data.teams} />
  </div>
</div>