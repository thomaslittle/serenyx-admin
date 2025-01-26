<script lang="ts">
  import { Button } from '$lib/components/ui/button';
  import ArrowUpDown from 'lucide-svelte/icons/arrow-up-down';

  export let onClick: () => void;
</script>

<div class="flex items-center gap-2">
  <span>Email</span>
  <button
    type="button"
    class="inline-flex h-8 items-center justify-center rounded-md px-2 text-sm font-medium ring-offset-background transition-colors hover:bg-accent hover:text-accent-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50"
    on:click={onClick}
  >
    <ArrowUpDown class="h-4 w-4" />
  </button>
</div>
