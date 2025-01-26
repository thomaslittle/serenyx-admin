<script lang="ts">
  import MatchOverlay from '$lib/components/overlays/MatchOverlay.svelte';
  import { page } from '$app/stores';

  $: matchId = $page.url.searchParams.get('matchId') || '';
</script>

{#if matchId}
  <MatchOverlay {matchId} />
{:else}
  <div class="fixed inset-0 flex items-center justify-center bg-neutral-900">
    <div class="text-white">No match ID provided</div>
  </div>
{/if}

<style>
  :global(body) {
    margin: 0;
    padding: 0;
    overflow: hidden;
  }
</style>
