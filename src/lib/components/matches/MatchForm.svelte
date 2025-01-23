<script lang="ts">
  import { Form, Input, Select } from '$lib/components/ui/shared';
  import Button from '$lib/components/ui/Button.svelte';
  import { spring } from 'svelte/motion';
  
  export let teams: any[] = [];
  export let initialData: any = {};
  export let onSubmit: (data: any) => void;
  
  let loading = false;
  let form: HTMLFormElement;
  
  const formScale = spring(1);
  $: formScale.set(loading ? 0.98 : 1);
  
  function handleSubmit(e: Event) {
    e.preventDefault();
    const formData = new FormData(form);
    const data = Object.fromEntries(formData);
    onSubmit(data);
  }
</script>

<form
  bind:this={form}
  class="space-y-6"
  on:submit={handleSubmit}
  style="transform: scale({$formScale})"
>
  <div class="grid grid-cols-2 gap-6">
    <div class="space-y-4">
      <label class="text-sm font-medium">Team 1</label>
      <Select.Root
        name="team1Id"
        items={teams.map(t => ({ value: t.id, label: t.name }))}
        value={initialData.team1Id}
      />
      
      <label class="text-sm font-medium">Score</label>
      <Input
        type="number"
        name="team1Score"
        value={initialData.team1Score}
        min="0"
      />
    </div>
    
    <div class="space-y-4">
      <label class="text-sm font-medium">Team 2</label>
      <Select.Root
        name="team2Id" 
        items={teams.map(t => ({ value: t.id, label: t.name }))}
        value={initialData.team2Id}
      />
      
      <label class="text-sm font-medium">Score</label>
      <Input
        type="number"
        name="team2Score"
        value={initialData.team2Score}
        min="0"
      />
    </div>
  </div>
  
  <div class="space-y-4">
    <label class="text-sm font-medium">Match Date</label>
    <Input
      type="datetime-local"
      name="date"
      value={initialData.date}
    />
    
    <label class="text-sm font-medium">Status</label>
    <Select.Root
      name="status"
      items={[
        { value: 'scheduled', label: 'Scheduled' },
        { value: 'live', label: 'Live' },
        { value: 'completed', label: 'Completed' }
      ]}
      value={initialData.status}
    />
  </div>
  
  <div class="flex justify-end gap-4">
    <Button variant="outline" href="/admin/matches">
      Cancel
    </Button>
    <Button type="submit" disabled={loading}>
      {loading ? 'Saving...' : 'Save Match'}
    </Button>
  </div>
</form>