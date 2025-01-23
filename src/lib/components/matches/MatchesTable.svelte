<script lang="ts">
  import { Button } from 'bits-ui';

  export let matches = [];
</script>

<div class="w-full overflow-x-auto">
  <table class="w-full border-collapse">
    <thead>
      <tr>
        <th class="p-2 border text-left">Date</th>
        <th class="p-2 border text-left">Teams</th>
        <th class="p-2 border text-left">Score</th>
        <th class="p-2 border text-left">Status</th>
        <th class="p-2 border text-left">Actions</th>
      </tr>
    </thead>
    <tbody>
      {#each matches as match}
      <tr>
        <td class="p-2 border">{match.date}</td>
        <td class="p-2 border">{match.team1} vs {match.team2}</td>
        <td class="p-2 border">{match.score1} - {match.score2}</td>
        <td class="p-2 border">{match.status}</td>
        <td class="p-2 border">
          <Button.Root class="px-4 py-2 bg-primary text-white rounded hover:bg-primary/90">
            View
          </Button.Root>
        </td>
      </tr>
      {/each}
    </tbody>
  </table>
</div>