<script lang="ts">
  import { scale } from 'svelte/transition';
  import { spring } from 'svelte/motion';
  
  export let overlays = [
    { title: 'Match', description: 'Live match scores and stats', href: '/admin/overlays/match' },
    { title: 'Teams', description: 'Team rosters and info', href: '/admin/overlays/teams' },
    { title: 'Tournament', description: 'Brackets and standings', href: '/admin/overlays/tournament' }
  ];
  
  function createSpring() {
    return spring(0, {
      stiffness: 0.1,
      damping: 0.4
    });
  }
  
  let hovered = -1;
  const scales = overlays.map(() => createSpring());
</script>

<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  {#each overlays as overlay, i}
    <a
      href={overlay.href}
      class="block group relative overflow-hidden rounded-lg border bg-card p-6 hover:shadow-lg transition-shadow"
      on:mouseenter={() => {
        hovered = i;
        scales[i].set(1);
      }}
      on:mouseleave={() => {
        hovered = -1;
        scales[i].set(0);
      }}
      in:scale
    >
      <div class="space-y-2">
        <h3 class="text-xl font-bold">{overlay.title}</h3>
        <p class="text-muted-foreground">{overlay.description}</p>
      </div>
      
      <div class="absolute inset-0 -z-10 bg-gradient-to-b from-primary/10 to-primary/5 opacity-0 group-hover:opacity-100 transition-opacity" />
      
      {#if hovered === i}
        <div
          class="absolute bottom-0 left-0 h-1 bg-primary transition-all"
          style="width: {$scales[i] * 100}%"
        />
      {/if}
    </a>
  {/each}
</div>