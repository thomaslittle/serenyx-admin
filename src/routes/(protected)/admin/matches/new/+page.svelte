<script lang="ts">
  import { fade } from 'svelte/transition';
  import Button from '$lib/components/ui/Button.svelte';
  import Input from '$lib/components/ui/Input.svelte';
  import { Select } from '$lib/components/ui/shared';
  import { goto } from '$app/navigation';
  import { toast } from 'svelte-sonner';

  export let data;

  let form = {
    team1Id: '',
    team2Id: '',
    date: new Date().toISOString().slice(0, 16),
    format: 'bo3',
    status: 'scheduled'
  };

  async function handleSubmit() {
    try {
      const response = await fetch('/api/matches', {
        method: 'POST',
        body: JSON.stringify(form)
      });
      
      if (!response.ok) throw new Error('Failed to create match');
      toast.success('Match created');
      goto('/admin/matches');
    } catch (error) {
      toast.error('Failed to create match');
    }
  }
</script>

<div class="space-y-8" in:fade>
  <div>
    <h2 class="text-3xl font-bold tracking-tight">New Match</h2>
    <p class="text-muted-foreground">Schedule a new tournament match</p>
  </div>

  <form class="space-y-6" on:submit|preventDefault={handleSubmit}>
    <div class="grid grid-cols-2 gap-6">
      <div class="space-y-4">
        <label class="text-sm font-medium">Team 1</label>
        <Select.Root 
          bind:value={form.team1Id}
          items={data.teams.map(t => ({ value: t.id, label: t.name }))}
        />
      </div>

      <div class="space-y-4">
        <label class="text-sm font-medium">Team 2</label>
        <Select.Root
          bind:value={form.team2Id}
          items={data.teams.map(t => ({ value: t.id, label: t.name }))}
        />
      </div>
    </div>

    <div class="space-y-4">
      <label class="text-sm font-medium">Match Date</label>
      <Input type="datetime-local" bind:value={form.date} />
    </div>

    <div class="grid grid-cols-2 gap-6">
      <div class="space-y-4">
        <label class="text-sm font-medium">Format</label>
        <Select.Root
          bind:value={form.format}
          items={[
            { value: 'bo1', label: 'Best of 1' },
            { value: 'bo3', label: 'Best of 3' },
            { value: 'bo5', label: 'Best of 5' }
          ]}
        />
      </div>

      <div class="space-y-4">
        <label class="text-sm font-medium">Status</label>
        <Select.Root
          bind:value={form.status}
          items={[
            { value: 'scheduled', label: 'Scheduled' },
            { value: 'live', label: 'Live' },
            { value: 'completed', label: 'Completed' }
          ]}
        />
      </div>
    </div>

    <div class="flex justify-end gap-4">
      <Button variant="outline" href="/admin/matches">Cancel</Button>
      <Button type="submit">Create Match</Button>
    </div>
  </form>
</div>