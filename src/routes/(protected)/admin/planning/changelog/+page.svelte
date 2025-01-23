<script lang="ts">
  import { fade, fly } from 'svelte/transition';
  import { ScrollArea } from '$lib/components/ui/shared';
  import Button from '$lib/components/ui/Button.svelte';
  import { toast } from 'svelte-sonner';
  
  export let data;
  
  function formatDate(date: string) {
    return new Date(date).toLocaleDateString('en-US', {
      month: 'long',
      day: 'numeric',
      year: 'numeric'
    });
  }
</script>

<div class="space-y-8" in:fade>
  <div class="flex items-center justify-between">
    <div>
      <h2 class="text-3xl font-bold tracking-tight">Changelog</h2>
      <p class="text-muted-foreground">Track broadcast updates and changes</p>
    </div>
    
    <Button href="/admin/planning/changelog/new">
      Add Entry
    </Button>
  </div>

  <div class="rounded-lg border bg-card" in:fly={{ y: 20 }}>
    <ScrollArea.Root className="h-[700px]">
      <ScrollArea.Viewport class="p-6">
        {#each data.entries as entry}
          <div class="relative pl-8 pb-8 last:pb-0">
            <div class="absolute left-0 top-0 bottom-0 w-px bg-border" />
            <div class="absolute left-[-4px] top-2 w-2 h-2 rounded-full bg-primary" />
            
            <div class="space-y-2">
              <div class="flex items-center gap-4">
                <time class="text-sm text-muted-foreground">
                  {formatDate(entry.date)}
                </time>
                <span class="inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium bg-primary/10 text-primary">
                  {entry.type}
                </span>
              </div>
              
              <h3 class="font-medium">{entry.title}</h3>
              <p class="text-muted-foreground">{entry.description}</p>
              
              {#if entry.updates?.length}
                <ul class="space-y-2 text-sm list-disc list-inside">
                  {#each entry.updates as update}
                    <li>{update}</li>
                  {/each}
                </ul>
              {/if}
            </div>
          </div>
        {/each}
      </ScrollArea.Viewport>
      <ScrollArea.Scrollbar />
    </ScrollArea.Root>
  </div>
</div>