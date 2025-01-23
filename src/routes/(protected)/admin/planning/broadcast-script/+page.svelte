<script lang="ts">
  import { fade, fly } from 'svelte/transition';
  import { ScrollArea } from '$lib/components/ui/shared';
  import Button from '$lib/components/ui/Button.svelte';
  import { toast } from 'svelte-sonner';
  
  export let data;
  let script = data.script || '';
  let saving = false;
  
  async function saveScript() {
    try {
      saving = true;
      await fetch('/api/planning/script', {
        method: 'POST',
        body: JSON.stringify({ script })
      });
      toast.success('Script saved successfully');
    } catch (error) {
      toast.error('Failed to save script');
    } finally {
      saving = false;
    }
  }
</script>

<div class="space-y-8" in:fade>
  <div class="flex items-center justify-between">
    <div>
      <h2 class="text-3xl font-bold tracking-tight">Broadcast Script</h2>
      <p class="text-muted-foreground">Plan your tournament broadcast</p>
    </div>
    
    <Button on:click={saveScript} disabled={saving}>
      {saving ? 'Saving...' : 'Save Script'}
    </Button>
  </div>

  <div class="grid grid-cols-2 gap-8" in:fly={{ y: 20 }}>
    <div class="space-y-4">
      <div class="rounded-lg border bg-card">
        <div class="border-b p-4">
          <h3 class="font-medium">Script Editor</h3>
        </div>
        <div class="p-4">
          <textarea
            bind:value={script}
            class="w-full h-[600px] bg-transparent resize-none focus:outline-none"
            placeholder="Add your broadcast script..."
          />
        </div>
      </div>
    </div>
    
    <div class="space-y-4">
      <div class="rounded-lg border bg-card">
        <div class="border-b p-4">
          <h3 class="font-medium">Preview</h3>
        </div>
        <ScrollArea.Root className="h-[600px]">
          <ScrollArea.Viewport class="p-4">
            <div class="prose prose-invert max-w-none">
              {@html marked(script)}
            </div>
          </ScrollArea.Viewport>
          <ScrollArea.Scrollbar />
        </ScrollArea.Root>
      </div>
    </div>
  </div>
</div>