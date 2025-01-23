<script lang="ts">
  import { Button } from 'bits-ui';

  export let teams = [];
</script>

<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  {#each teams as team}
    <div class="p-4 border rounded-lg shadow-sm">
      <div class="flex items-center space-x-4">
        {#if team.logo}
          <img src={team.logo} alt={team.name} class="w-12 h-12 rounded-full" />
        {/if}
        <div>
          <h3 class="text-lg font-semibold">{team.name}</h3>
          <p class="text-sm text-gray-500">{team.players?.length || 0} Players</p>
        </div>
      </div>
      <div class="mt-4 flex justify-end">
        <Button.Root class="px-4 py-2 bg-primary text-white rounded hover:bg-primary/90">
          View Team
        </Button.Root>
      </div>
    </div>
  {/each}
</div>