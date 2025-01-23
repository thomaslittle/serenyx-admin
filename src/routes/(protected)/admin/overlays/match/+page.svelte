<script lang="ts">
  import { fade, fly } from 'svelte/transition';
  import { Tabs } from '$lib/components/ui/shared';
  import Button from '$lib/components/ui/Button.svelte';
  import { toast } from 'svelte-sonner';
  
  export let data;
  
  let selectedMatch = null;
  let overlayURL = '';
  
  function copyOverlayURL() {
    navigator.clipboard.writeText(overlayURL);
    toast.success('Overlay URL copied to clipboard');
  }
</script>

<div class="space-y-8" in:fade>
  <div>
    <h2 class="text-3xl font-bold tracking-tight">Match Overlay</h2>
    <p class="text-muted-foreground">Configure live match overlays</p>
  </div>

  <Tabs.Root value="current">
    <Tabs.List class="w-full border-b">
      <Tabs.Trigger value="current">Current Match</Tabs.Trigger>
      <Tabs.Trigger value="upcoming">Upcoming Matches</Tabs.Trigger>
      <Tabs.Trigger value="settings">Overlay Settings</Tabs.Trigger>
    </Tabs.List>
    
    <div class="mt-6">
      <Tabs.Content value="current" class="space-y-6">
        {#if data.currentMatch}
          <div class="rounded-lg border p-6 space-y-4" in:fly|local={{ y: 20 }}>
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-4">
                <img src={data.currentMatch.team1.logo} alt="" class="w-12 h-12 rounded-full" />
                <span class="text-2xl font-bold">VS</span>
                <img src={data.currentMatch.team2.logo} alt="" class="w-12 h-12 rounded-full" />
              </div>
              
              <div class="flex items-center gap-2">
                <Button variant="outline" size="sm" href="/admin/matches/{data.currentMatch.id}">
                  Edit Match
                </Button>
                <Button size="sm" on:click={copyOverlayURL}>
                  Copy Overlay URL
                </Button>
              </div>
            </div>
          </div>
        {:else}
          <div class="text-center py-12 text-muted-foreground">
            No match is currently live
          </div>
        {/if}
      </Tabs.Content>
      
      <Tabs.Content value="upcoming">
        <!-- Upcoming matches table -->
      </Tabs.Content>
      
      <Tabs.Content value="settings">
        <!-- Overlay settings -->
      </Tabs.Content>
    </div>
  </Tabs.Root>
</div>