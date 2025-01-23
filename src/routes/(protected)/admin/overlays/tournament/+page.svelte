<script lang="ts">
  import { fade, fly } from 'svelte/transition';
  import { Tabs } from '$lib/components/ui/shared';
  import Button from '$lib/components/ui/Button.svelte';
  import { toast } from 'svelte-sonner';
  
  export let data;
  let selectedOverlay = 'bracket';
  
  const overlayTypes = [
    { id: 'bracket', name: 'Tournament Bracket' },
    { id: 'standings', name: 'Standings' },
    { id: 'schedule', name: 'Schedule' }
  ];
  
  function copyOverlayURL(type: string) {
    const url = `${window.location.origin}/overlays/tournament/${type}`;
    navigator.clipboard.writeText(url);
    toast.success('Overlay URL copied');
  }
</script>

<div class="space-y-8" in:fade>
  <div>
    <h2 class="text-3xl font-bold tracking-tight">Tournament Overlay</h2>
    <p class="text-muted-foreground">Configure tournament bracket and standings overlays</p>
  </div>

  <Tabs.Root bind:value={selectedOverlay}>
    <Tabs.List class="w-full border-b">
      {#each overlayTypes as type}
        <Tabs.Trigger value={type.id}>{type.name}</Tabs.Trigger>
      {/each}
    </Tabs.List>
    
    <div class="mt-6 space-y-6">
      <Tabs.Content value="bracket">
        <div class="grid grid-cols-2 gap-8" in:fly|local={{ y: 20 }}>
          <div class="rounded-lg border bg-card p-6">
            <div class="flex items-center justify-between mb-4">
              <h3 class="font-medium">Double Elimination Bracket</h3>
              <Button size="sm" on:click={() => copyOverlayURL('bracket')}>
                Copy URL
              </Button>
            </div>
            
            <div class="aspect-video bg-muted rounded-lg flex items-center justify-center">
              Preview
            </div>
          </div>
        </div>
      </Tabs.Content>
      
      <Tabs.Content value="standings">
        <div class="rounded-lg border bg-card p-6" in:fly|local={{ y: 20 }}>
          <div class="flex items-center justify-between mb-4">
            <h3 class="font-medium">Tournament Standings</h3>
            <Button size="sm" on:click={() => copyOverlayURL('standings')}>
              Copy URL
            </Button>
          </div>
          
          <div class="space-y-4">
            {#each data.standings || [] as team, i}
              <div class="flex items-center gap-4 p-4 bg-muted rounded-lg">
                <span class="text-xl font-bold w-8">{i + 1}</span>
                <img src={team.logo} alt="" class="w-10 h-10 rounded-full" />
                <div>
                  <p class="font-medium">{team.name}</p>
                  <p class="text-sm text-muted-foreground">{team.wins}W - {team.losses}L</p>
                </div>
              </div>
            {/each}
          </div>
        </div>
      </Tabs.Content>
      
      <Tabs.Content value="schedule">
        <div class="rounded-lg border bg-card p-6" in:fly|local={{ y: 20 }}>
          <div class="flex items-center justify-between mb-4">
            <h3 class="font-medium">Tournament Schedule</h3>
            <Button size="sm" on:click={() => copyOverlayURL('schedule')}>
              Copy URL
            </Button>
          </div>
          
          <div class="space-y-4">
            {#each data.schedule || [] as day}
              <div class="space-y-2">
                <h4 class="font-medium text-sm text-muted-foreground">
                  {new Date(day.date).toLocaleDateString('en-US', {
                    weekday: 'long',
                    month: 'long',
                    day: 'numeric'
                  })}
                </h4>
                
                {#each day.matches as match}
                  <div class="flex items-center justify-between p-4 bg-muted rounded-lg">
                    <div class="flex items-center gap-4">
                      <img src={match.team1.logo} alt="" class="w-8 h-8 rounded-full" />
                      <span class="text-sm">vs</span>
                      <img src={match.team2.logo} alt="" class="w-8 h-8 rounded-full" />
                    </div>
                    <time class="text-sm text-muted-foreground">
                      {new Date(match.time).toLocaleTimeString('en-US', {
                        hour: 'numeric',
                        minute: '2-digit'
                      })}
                    </time>
                  </div>
                {/each}
              </div>
            {/each}
          </div>
        </div>
      </Tabs.Content>
    </div>
  </Tabs.Root>
</div>